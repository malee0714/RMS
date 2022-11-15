package lims.spc.service.impl;

import lims.spc.dao.SpcRuleTestDao;
import lims.spc.enm.ResultValueType;
import lims.spc.enm.SpcRule;
import lims.spc.service.SpcRuleTestService;
import lims.spc.vo.*;
import lims.util.CustomException;
import lims.wrk.vo.CLManageMVo;
import lims.wrk.vo.TrendSpcRuleVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static java.util.Optional.empty;

/**
 * SPC Rule Test를 Service합니다.
 * 
 * @author shs
 */
@Service
public class SpcRuleTestServiceImpl implements SpcRuleTestService {

	private final SpcRuleTestDao spcRuleTestDao;
	
	@Autowired
	public SpcRuleTestServiceImpl(SpcRuleTestDao spcRuleTestDao) {
		this.spcRuleTestDao = spcRuleTestDao;
	}

	/**
	 * spc 8대 룰을 조회한다.
	 * @param spcParam spc rule test하기위한 param
	 * @return List<TrendSpcRuleVO> 
	 */
	public List<TrendSpcRuleVO> getSpcRules(SpcParam spcParam) {
		return spcRuleTestDao.getSpcRules(spcParam);
	}
	
	/**
	 * chart 메뉴 에서는 자재 일련번호만으로 시험항목별 목록, 시험항목별 spc rule test 결과까지
	 * 얻어야 합니다. 그래서 chart메뉴 data에 맞게 만들어서 return해줍니다.
	 * @param spcRuleTestDto spc rule test하기위한 param
	 */
	@Override
	public List<SpcChart> chartDataSupply(SpcRuleTestDto spcRuleTestDto) {
	
		List<SpcChart> chartData = new ArrayList<>();

		//자재별 자재기준규격 조회. 자재기준규격별로 조회조건에 맞는 list를 구할 것이며, 해당 list로 spc8대룰 검사를 한다.
		List<SpcMtrilExpriem> spcMtrilExpriems = spcRuleTestDao.getMtrilSdpcList(spcRuleTestDto);
		
		// Result Value Type의 수많큼 chart menut에서 표현해줘야한다.
		ResultValueType[] values = ResultValueType.values();
		for (ResultValueType resultValueType : values) {
			spcMtrilExpriems.forEach(spcMtrilExpriem -> {
				
				// spc rule test를 하기위해 조회한 list, 시험항목명, spc rule에 위배가 됬다면 위배된 list 등 모든 데이터를 조합하여 만든 chart data return
				SpcParam spcParam = SpcParam.builder()
						.spcMtrilExpriem(spcMtrilExpriem)
						.spcRuleTestDto(spcRuleTestDto)
						.resultValueType(resultValueType)
						.build();

				final SpcChart spcChart = this.chartSpcTest(spcParam);
				chartData.add(spcChart);
			});
		}
		return chartData;
	}

	/**
	 * 결과입력, ROA와 달리 chart메뉴에서는 Spc rule test 성공, 실패 여부만 retrun하는게 아닌,
	 * 자재 seqno, 제조일자 범위에 맞는 표본(해당 시험항목을 사용한 lot목록) 목록과 spc rule test가 실패일 경우 badList, badSploreNames를 return합니다.
	 * 
	 * @param spcParam spc rule test하기위한 param
	 * @return SpcRuleTestVO badList와 badSploreNames를 추가로 set하여 return합니다.
	 */
	public SpcChart chartSpcTest(SpcParam spcParam) {

		try {

			ResultValueType resultValueType = spcParam.getResultValueType();

			// 조회된 표본의 통계적 데이터인 cl, ucl, lcl, 표준편차를 계산하여 select한다.
			Optional<SpcSampleStats> nullableSpcSampleStats = Optional.ofNullable(spcRuleTestDao.getSpcSampleStats(spcParam));

			//null 이면 테스트 안하고 반환
			if(!nullableSpcSampleStats.isPresent()){
				return new SpcChart( spcParam.getSpcMtrilExpriem().getExpriemNm(), resultValueType, new SpcSamples(new ArrayList<>()));
			}

			//sample의 통계 데이터 get
			SpcSampleStats spcSampleStats = nullableSpcSampleStats.get();

			// 자재별 기준규격별 표본을 select한다. order by asc.
			SpcSamples spcSamples = new SpcSamples(spcRuleTestDao.getSpcSample(spcParam));

			// return될 dto객체. chart 데이터에 적합하게 여러 정보들을 담아 return 한다. 
			SpcChart returnDto = new SpcChart(spcParam.getSpcMtrilExpriem().getExpriemNm(), resultValueType, spcSamples);

			// 자재별, 업체별 SPC rules.
			List<TrendSpcRuleVO> spcRules = this.getSpcRules(spcParam);

			// 표본이 조회가 될 경우에만 spc rule test
			if (spcSamples.isPresent()) {

				// 조회된 spc rules code와 일치하는 테스트 실행.
				for (TrendSpcRuleVO trendSpcRuleVO : spcRules) {

					// spc test후 위배된 List return
					BadPointCollection badPointCollection = spcTest(spcParam, trendSpcRuleVO, spcSampleStats, spcSamples);

					//badPoints가 존재한다면 result data를 생성한다. 위반한 rule 모두 return한다.
					if(badPointCollection.isPresent()){
						returnDto.getViolateRules().add(
								SpcRuleTestDto.builder()
										.badSploreNames(badPointCollection.getPureBadSploreNames())    // Lot number만 모아놓은 String Array
										.ruleName(badPointCollection.getRule())                      // badPoint 들이 여러 index가 있더라도 rule name은 같음.
										.spcRuleCode(badPointCollection.getSpcCode())                // rule name의 공통코드 get.
										.build()
						);
					}
				}

				// Chart Line Data들을 ResultValueType에 맞게 setting한다. 
				resultValueType.setChartData(returnDto);
			}
			return returnDto;

		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, spcParam, "Spc Rule Test를 위한 데이터 검색이 정상적으로 처리되지 않았습니다.");
		}
	}

	/**
	 * 
	 * char 메뉴와는 달리 결과입력, roa 에서는 표본의 제조일자 검색범위가
	 * parameter로 전달되지 않기 때문에 Cl 산정기준관리 메뉴에서 저장하는 검색범위 데이터를 통해 제조일자 검색범위를 생성한다.
	 * 
	 * @param spcParam spc rule test하기위한 param
	 * @return Optional -> optional하게 처리하기위해 Optional 객체로 return한다. 
	 */
	@Override
	public Optional<SpcRuleTestDto> resultValueSpcTest(SpcParam spcParam) {

		try {
			// 자재 CL 산정기준관리 정보를 조회하여 제조일자 검색범위를 정한다.
			CLManageMVo clManageMVo = Optional
										.ofNullable(spcRuleTestDao.getMtrilClManage(spcParam.getSpcMtrilExpriem()))
										.orElseGet(CLManageMVo::new);

			// 제조일자 검색 시작일, 검색 종료일 set
			spcParam.getSpcRuleTestDto().setMnfcturStartDte(clManageMVo.getSearchBeginDte());
			spcParam.getSpcRuleTestDto().setMnfcturEndDte(clManageMVo.getSearchEndDte());

			// 조회된 표본의 통계적 데이터인 cl, ucl, lcl, 표준편차를 계산하여 select한다.
			Optional<SpcSampleStats> nullableSpcSampleStats = Optional.ofNullable(spcRuleTestDao.getSpcSampleStats(spcParam));

			//null 이면 테스트 안하고 반환
			if(!nullableSpcSampleStats.isPresent()){
				return empty();
			}

			SpcSampleStats spcSampleStats = nullableSpcSampleStats.get(); //sample의 통계 데이터 get
			SpcSamples spcSamples = new SpcSamples(spcRuleTestDao.getSpcSample(spcParam)); // 자재별 기준규격별 표본을 select한다. order by desc. 최근순
			List<TrendSpcRuleVO> spcRules = this.getSpcRules(spcParam); // 자재별, 업체별 SPC rules.

			// 표본이 조회가 될 경우에만 spc rule test
			if (spcSamples.isPresent()) {

				// 조회된 spc rules code와 일치하는 테스트 실행.
				for (TrendSpcRuleVO trendSpcRuleVO : spcRules) {

					// spc test후 위배된 List return
					BadPointCollection badPointCollection = this.spcTest(spcParam, trendSpcRuleVO, spcSampleStats, spcSamples);
					if (badPointCollection.isPresent()) {
						return Optional.ofNullable(
								SpcRuleTestDto.builder()
										.badSploreNames(badPointCollection.getPureBadSploreNames())   // Lot number만 모아놓은 String Array
										.ruleName(badPointCollection.getRule())            // badPoint 들이 여러 index가 있더라도 rule name은 같음.
										.spcRuleCode(badPointCollection.getSpcCode())   // rule name의 공통코드 get.
										.expriemNm(spcSamples.getExpriemNm())                       // spc rule test를 진행한 시험항목 명
										.build()
						);
					}
				}
			}
			return empty();

		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, spcParam, "Spc Rule Test를 위한 데이터 검색이 정상적으로 처리되지 않았습니다.");
		}
	}

	/**
	 * @param spcParam     chart, 결과입력, ROA에서 SpcRule Test를 위해 만들어서 보내는 Param객체
	 * @param trendSpcRuleVO    조회된 해당 자재의 Spc rule
	 * @param spcSampleStats    해당 자재의 통계적 데이터. 표준편차, 평균 등등
	 * @param spcSamples        SpcRule Test하기위한 표본 목록
	 * @return                  검사후 테스트 결과 return
	 */
	private BadPointCollection spcTest(SpcParam spcParam, TrendSpcRuleVO trendSpcRuleVO, SpcSampleStats spcSampleStats, SpcSamples spcSamples) {
		try {
			// 공통코드와 일치하는 spc rule enum 찾기.
			SpcRule spcRule = SpcRule.findSpcRule(trendSpcRuleVO.getSpcRuleCode());

			final SpcRuleTestDto spcRuleTestDto = spcParam.getSpcRuleTestDto();
			ResultValueType resultValueType = spcParam.getResultValueType();
			boolean qc = spcRuleTestDto.isQc();
			
			// 공통코드와 일치하는 SpcRule. Test에 사용될 badPointParam 생성
			BadPoint badPointParam = BadPoint.builder()
					.n(trendSpcRuleVO.parseIntegerN())
					.cl(resultValueType.getCl(spcSampleStats, qc))
					.standardDeviation(resultValueType.getStdev(spcSampleStats, qc))
					.resultValueType(resultValueType)
					.rule(spcRule)
					.findFirst(spcRuleTestDto.isFindFirst())
					.chartData(spcRuleTestDto.isChartData())
					.qc(qc)
					.build();
			return new BadPointCollection(spcRule.test(spcSamples, badPointParam));
			
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, spcParam, "Spc Rule Test가 정상적으로 처리되지 않았습니다.");
		}
	}
}
