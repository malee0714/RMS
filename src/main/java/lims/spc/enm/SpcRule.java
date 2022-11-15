package lims.spc.enm;

import lims.spc.vo.BadPoint;
import lims.spc.vo.SpcResultExpriem;
import lims.spc.vo.SpcSamples;
import lims.util.CustomException;
import lombok.extern.slf4j.Slf4j;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.BiFunction;

/**
 * Spc 8대 Rule, Nelson Rule, Nelson 법칙 이라고도 불리는 Rule에 대한 Enum입니다.
 * 각 rule에 대한 알고리즘이 정의되어 있으며, 위배된 구간을 전부 찾아 retrun합니다.
 * Enum 두번째 parameter인 expression은 lambda로 직접 적어야 하지만 가시성, 유지보수를 위해 미리 static method로 만들어놓고 사용합니다.
 * 
 * @author shs
 * @see ResultValueType 결과값 Type을 열거 해놓았습니다. chart의 종류가 되기도 합니다.
 * @see BadPoint      spc rule test 이후 Return되는 Dto 객체 입니다.
 * @see SpcSamples      Spc test에 필요한 시험항목에 따른 Lot 목록을 가진 일급 Collection 객체 입니다.
 */
@Slf4j
public enum SpcRule {

	RULE_1("SY04000001", SpcRule::rule1)
	, RULE_2("SY04000002", SpcRule::rule2)
	, RULE_3("SY04000003", SpcRule::rule3)
	, RULE_4("SY04000004", SpcRule::rule4)
	, RULE_5("SY04000005", SpcRule::rule_5_both_6)
	, RULE_6("SY04000006", SpcRule::rule_5_both_6)
	, RULE_7("SY04000007", SpcRule::rule_7_both_8)
	, RULE_8("SY04000008", SpcRule::rule_7_both_8);
	
	private final String code;
	private final BiFunction<List<? extends SpcResultExpriem>, BadPoint, List<BadPoint>> expression;

	SpcRule( String code, BiFunction<List<? extends SpcResultExpriem>, BadPoint, List<BadPoint>> expression ){
		this.code = code;
		this.expression = expression;
	}

	/**
	 * 이 method는 spcSamples에 대한 유효성 체크를 진행하며 결과입력, roa 메뉴에서 호출시 List의 size를 재가공한다.
	 * 재가공 이후 spc rule test를 진행하는데, 가공이 필요한 이유는 제조일자 검색범위의 기간에 해당하는 lot들을 모두 
	 * 조회하여 검사하지만 실질적으로 결과입력,roa에서는 현재 입력중인 lot가 spc 적합인지 부적합인지 판단해야 하기 때문이다.
	 * 과거 데이터는 검사할 필요가 없다. (하지만 과거 데이터로 통계적 데이터는 만들어야 하기 때문에 기간범위로 조회한다.)
	 * 
	 * @param spcSamples spc test samples
	 * @param badPoint  Bad point를 찾기위한 param
	 */
	public List<BadPoint> test(SpcSamples spcSamples, BadPoint badPoint) throws CustomException {
		try {

			// 유효한 샘플이 아니면 return
			if (spcSamples.isNotPresent()) {
				return new ArrayList<>();
			}

			// 유효한 샘플이어도 가공하는 과정이 필요하다.
			return expression.apply(spcSamples.getProcessedSpcSamples(badPoint), badPoint);
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, badPoint, "Spcrule test error");
		}
	}

	public String getCode() {
		return this.code;
	}
	
	/**
	 * 공통코드로 spc rule 찾아서 반환
	 * @param spcRuleCode spc rule 공통코드
	 * @return SpcRule
	 */
	public static SpcRule findSpcRule(String spcRuleCode) {
		return Arrays.stream(SpcRule.values())
				.filter(rule -> spcRuleCode.equals(rule.getCode()))
				.findFirst()
				.orElseThrow(() -> new RuntimeException( spcRuleCode + "-> No definition spc rule."));
	}
	
	/**
	 * 
	 * 예외적인 부분이 많은 RULE 입니다.
	 * 
	 * rule: 1개의 point가 [n] sigma를 벗어난다.
	 * 
	 * 1. ★★★★★ '원래 rule은 n sigma를 벗어난다.' 가 맞지만 표본을 통해 통계적 데이터인 표준편차, n sigma값을 사용하지 않는다. 
	 * 2. 시험항목 결과 Table의 ucl value와 직접 대조하여 ucl이 넘는지 안넘는지만 체크한다.
	 * 
	 * @param samples  표본 list
	 * @param badPoint 계산에 필요한 필수 param -> cl, n, standardDeviation, ResultValueType
	 */
	public static List<BadPoint> rule1 (List<? extends SpcResultExpriem> samples, BadPoint badPoint){
		List<BadPoint> badList = new ArrayList<>();
		
		for( int i = (samples.size() - 1); i > -1; i-- ){

			//현재 index의 lot
			SpcResultExpriem expr = samples.get(i);

			// 통계로 뽑아낸 ucl,lcl이 아닌 현재까지 기록된 ucl, lcl이다. (시험항목 테이블에 기록된)
			Double ucl = badPoint.getResultValueType().getUclValue(expr);
			Double lcl = badPoint.getResultValueType().getLclValue(expr);
			Double value = badPoint.getResultValueType().getValue(expr, badPoint.isQc());
			
			final UclLclSeCode uclSeCode = UclLclSeCode.findUclLclSeCode(expr.getUclValueSeCode()); // ucl 값 구분 코드
			final UclLclSeCode lclSeCode = UclLclSeCode.findUclLclSeCode(expr.getLclValueSeCode()); // lcl 값 구분 코드
			if( uclSeCode.isBad(ucl, value) ){
				// ucl 값 이상 또는 초과 point가 있다면. rule에 위배된다.
				badList.add(
						BadPoint.builder()
								.badSploreNames(samples.subList(i, i + 1))
								.fromIndex(i)
								.toIndex(i)
								.ucl(ucl)
								.rule(SpcRule.RULE_1)
								.chartData(badPoint.isChartData())
								.resultValueType(badPoint.getResultValueType())
								.qc(badPoint.isQc())
								.build()
				);
				
				if( badPoint.isFindFirst() ){
					log.info("### Rule test RULE_1, find first ==> return, ResultValueType : {} , badList size : {}", badPoint.getResultValueType(), badList.size());
					if(log.isDebugEnabled()){
						log.debug("{} \n", badList);
					}
					return badList;
				}
			} else if (lclSeCode.isBad(lcl, value)) {
				// lcl 값 이하 또는 미만의 point가 있다면. rule에 위배된다.
				badList.add(
						BadPoint.builder()
								.badSploreNames(samples.subList(i, i + 1))
								.fromIndex(i)
								.toIndex(i)
								.lcl(lcl)
								.rule(SpcRule.RULE_1)
								.chartData(badPoint.isChartData())
								.resultValueType(badPoint.getResultValueType())
								.qc(badPoint.isQc())
								.build()
				);
				
				if( badPoint.isFindFirst() ){
					log.info("### Rule test RULE_1, find first ==> return, ResultValueType : {} , badList size : {}", badPoint.getResultValueType(), badList.size());
					if(log.isDebugEnabled()){
						log.debug("{} \n", badList);
					}
					return badList;
				}
			}
		}
		
		log.info("### Rule test RULE_1, ResultValueType : {} , badList size : {}", badPoint.getResultValueType(), badList.size());
		if(log.isDebugEnabled()){
			log.debug("{} \n", badList);
		}
		return badList;
	}
	
	/**
	 * 연속된 [n]개의 Point가 중심선(CL)로부터 같은쪽에 있다.
	 * n개 이상 CL초과.
	 * 
	 * @param samples  표본 list
	 * @param badPoint 계산에 필요한 필수 param -> cl, n, ResultValueType
	 */
	public static List<BadPoint> rule2 (List<? extends SpcResultExpriem> samples, BadPoint badPoint){
		
		List<BadPoint> badList = new ArrayList<>();
		int n = badPoint.getN() - 1;
		double cl = badPoint.getCl();

		for( int i = (samples.size() - 1), fromIndex = i - n; fromIndex > -1; i--, fromIndex-- ){
			List<? extends SpcResultExpriem> testRange = samples.subList(fromIndex, i + 1);
			int rangeSize = (int) testRange
									.stream()
									.filter(expr -> badPoint.getResultValueType().getValue(expr, badPoint.isQc()) > cl) // 결과값 구분, qc여부에 따라서 결과값으로 검증할지 qc 결과값으로 검증할지 정한다.
									.count();

			if( rangeSize == badPoint.getN() ){
				badList.add(
					BadPoint.builder()
							.badSploreNames(testRange)
							.fromIndex(fromIndex)
							.toIndex(i)
							.n(badPoint.getN())
							.cl(cl)
							.rule(SpcRule.RULE_2)
							.chartData(badPoint.isChartData())
							.resultValueType(badPoint.getResultValueType())
							.qc(badPoint.isQc())
							.build()
				);
				
				if( badPoint.isFindFirst() ){
					log.info("### Rule test RULE_2, find first ==> return, ResultValueType : {} , badList size : {}", badPoint.getResultValueType(), badList.size());
					if(log.isDebugEnabled()){
						log.debug("{} \n", badList);
					}
					return badList;
				}
			}
		}
		log.info("### Rule test RULE_2, ResultValueType : {} , badList size : {}", badPoint.getResultValueType(), badList.size());
		if(log.isDebugEnabled()){
			log.debug("{} \n", badList);
		}
		return badList;
	}
	
	/**
	 * 연속된 [n]개의 Point가 모두 상승 또는 모두 하락한다.
	 * 
	 * @param samples  표본 list
	 * @param badPoint 계산에 필요한 필수 param -> n, ResultValueType
	 */
	public static List<BadPoint> rule3 (List<? extends SpcResultExpriem> samples, BadPoint badPoint){
		
		List<BadPoint> badList = new ArrayList<>();
		int n = badPoint.getN() - 1;
		for( int i = (samples.size() - 1), fromIndex = (i - n); fromIndex > -1; i--,fromIndex-- ){
			
			int upCnt = 0;
			int downCnt = 0;
			List<? extends SpcResultExpriem> testRange = samples.subList(fromIndex, i + 1);
			for( int k = (testRange.size() - 1), prevIndex = (k - 1); prevIndex > -1; k--, prevIndex-- ){
				
				// 결과값 구분, qc여부에 따라서 결과값으로 검증할지 qc 결과값으로 검증할지 정한다.
				
				// 현재값
				double presentValue = badPoint.getResultValueType().getValue(testRange.get(k), badPoint.isQc());
				// 이전값
				double prevValue = badPoint.getResultValueType().getValue(testRange.get(prevIndex), badPoint.isQc());

				//상향 하는지 체크
				if( prevValue < presentValue ){
					upCnt++;
					if( n == upCnt ){
						badList.add(
							BadPoint.builder()
									.badSploreNames(testRange)
									.fromIndex(fromIndex)
									.toIndex(i)
									.n(badPoint.getN())
									.up(true)
									.rule(SpcRule.RULE_3)
									.chartData(badPoint.isChartData())
									.resultValueType(badPoint.getResultValueType())
									.qc(badPoint.isQc())
									.build()
						);
						
						if( badPoint.isFindFirst() ){
							log.info("### Rule test RULE_3, find first ==> return, ResultValueType : {} , badList size : {}", badPoint.getResultValueType(), badList.size());
							if(log.isDebugEnabled()){
								log.debug("{} \n", badList);
							}
							return badList;
						}
					}
					
				}
				
				//하향 하는지 체크
				if( prevValue > presentValue ){
					downCnt++;
					if( n == downCnt ){
						badList.add(
							BadPoint.builder()
									.badSploreNames(testRange)
									.fromIndex(fromIndex)
									.toIndex(i)
									.n(badPoint.getN())
									.up(false)
									.rule(SpcRule.RULE_3)
									.chartData(badPoint.isChartData())
									.resultValueType(badPoint.getResultValueType())
									.qc(badPoint.isQc())
									.build()
						);
						
						if( badPoint.isFindFirst() ){
							log.info("### Rule test RULE_3, find first ==> return, ResultValueType : {} , badList size : {}", badPoint.getResultValueType(), badList.size());
							if(log.isDebugEnabled()){
								log.debug("{} \n", badList);
							}
							return badList;
						}
					}
					
				}
			}
		}

		log.info("### Rule test RULE_3, ResultValueType : {} , badList size : {}", badPoint.getResultValueType(), badList.size());
		if(log.isDebugEnabled()){
			log.debug("{} \n", badList);
		}
		return badList;
	}
	
	/**
	 * 연속된 [ n ]개의 Point가 교대로 상승 또는 하락한다.
	 * 
	 * @param samples  표본 list
	 * @param badPoint 계산에 필요한 필수 param -> n, ResultValueType
	 */
	public static List<BadPoint> rule4 (List<? extends SpcResultExpriem> samples, BadPoint badPoint){
		
		List<BadPoint> badList = new ArrayList<>();
		
		int n = badPoint.getN() - 1;
		for( int i = (samples.size() - 1), fromIndex = (i - n); fromIndex > -1; i--,fromIndex-- ){
			
			List<? extends SpcResultExpriem> testRange = samples.subList(fromIndex, i + 1);
			
			// testRange의 마지막 index - 1번째의 index
			double lastPrevValue = badPoint.getResultValueType().getValue(testRange.get(testRange.size() - 2), badPoint.isQc());
			
			// testRange의 마지막 index
			double lastValue = badPoint.getResultValueType().getValue(testRange.get(testRange.size() - 1), badPoint.isQc());
			
			/*
			  초기 상태.
			  true -> 하락
			  false -> 상승
			 */
			boolean prevUpDownStatus = ( lastPrevValue > lastValue );
			
			//testRange의 badPoint 갯수
			int badPoindCnt = 1;
			
			//마지막 (index - 1) 번째 index부터 시작한다. ** prevUpDownStatus를 통해 마지막 초기 상태를 정해 놓았기 때문.
			for( int k = (testRange.size() - 2), prevIndex = (k - 1); prevIndex > -1; k--, prevIndex-- ){
			
				// 현재 값
				double presentValue = badPoint.getResultValueType().getValue(testRange.get(k), badPoint.isQc()); 
				//이전 값
				double prevValue = badPoint.getResultValueType().getValue(testRange.get(prevIndex), badPoint.isQc());
				
				/*
				  현재 이전 index값에서 현재 index값이 상승했냐 or 하락했냐 status
				  true -> 하락
				  false -> 상승
				 */
				boolean presentUpDownStatus = ( prevValue > presentValue );

				//이전상태와 현재 상태가 다르다는것은 상승과 하락이 반복된다는것.
				if( prevUpDownStatus != presentUpDownStatus ){
					badPoindCnt++;
				}
				
				//상태 변경
				prevUpDownStatus = presentUpDownStatus;
				
				if( badPoindCnt == n ){
					
					//count 초기화 
					badPoindCnt = 1;
					
					badList.add(
						BadPoint.builder()
								.badSploreNames(testRange)
								.fromIndex(fromIndex)
								.toIndex(i)
								.n(badPoint.getN())
								.rule(SpcRule.RULE_4)
								.chartData(badPoint.isChartData())
								.resultValueType(badPoint.getResultValueType())
								.qc(badPoint.isQc())
								.build()
					);
					
					if( badPoint.isFindFirst() ){
						log.info("### Rule test RULE_4, find first ==> return, ResultValueType : {} , badList size : {}", badPoint.getResultValueType(), badList.size());
						if(log.isDebugEnabled()){
							log.debug("{} \n", badList);
						}
						return badList;
					}
				}
			}
		}
		
		log.info("### Rule test RULE_4, ResultValueType : {} , badList size : {}", badPoint.getResultValueType(), badList.size());
		if(log.isDebugEnabled()){
			log.debug("{} \n", badList);
		}
		return badList;
	}
	
	/**
	 * Rule 5. [ n+1 ]개의 Point 중에서 [ n ]개의 Point가 중심선(CL)로부터 2 Sigma 범위 밖에 있음. (한쪽)
	 * 		- n+1개 중 n개 모두 +2sigma 초과일 경우.
	 * 
	 * Rule 6. [ n+1 ]개의 Point 중에서 [ n ]개의 Point가 중심선(CL)로부터 1 Sigma 범위 밖에 있음. (한쪽)
	 * 		- n+1개 중 n개 모두 +1sigma 초과일 경우
	 * 	
	 * @param samples  표본 list
	 * @param badPoint 계산에 필요한 필수 param -> cl, n, standardDeviation, ResultValueType, ruleName
	 */
	public static List<BadPoint> rule_5_both_6 (List<? extends SpcResultExpriem> samples, BadPoint badPoint){
		
		List<BadPoint> badList = new ArrayList<>();
		SpcRule ruleName = badPoint.getRule();
		int n = badPoint.getN();
		double cl = badPoint.getCl();
		double sigma = (ruleName == SpcRule.RULE_5) ? ( cl + (2 * badPoint.getStandardDeviation()) ) : ( cl + badPoint.getStandardDeviation() );
		
		for( int i = (samples.size() - 1), fromIndex = (i - n); fromIndex > -1; i--,fromIndex-- ){
			
			List<? extends SpcResultExpriem> testRange = samples.subList(fromIndex, i + 1);
			int rangeSize = 
					(int) testRange
							.stream()
							.filter( expr -> {
								double value = badPoint.getResultValueType().getValue(expr, badPoint.isQc());
								return (value > cl && value > sigma );
							})
							.count();

			// n + 1 개중 n개가 벗어나느게 있으면 badPoint임
			if( rangeSize == n ){
				badList.add(
					BadPoint.builder()
							.badSploreNames(testRange)
							.fromIndex(fromIndex)
							.toIndex(i)
							.n(n)
							.cl(cl)
							.sigma(sigma)
							.rule(ruleName)
							.standardDeviation(badPoint.getStandardDeviation())
							.chartData(badPoint.isChartData())
							.resultValueType(badPoint.getResultValueType())
							.qc(badPoint.isQc())
							.build()
				);
				
				if( badPoint.isFindFirst() ){
					log.info("### Rule test {}, find first ==> return, ResultValueType : {} , badList size : {}", ruleName, badPoint.getResultValueType(), badList.size());
					if(log.isDebugEnabled()){
						log.debug("{} \n", badList);
					}
					return badList;
				}
			}
		}
		log.info("### Rule test {}, ResultValueType : {} , badList size : {}", ruleName, badPoint.getResultValueType(), badList.size());
		if(log.isDebugEnabled()){
			log.debug("{} \n", badList);
		}
		return badList;
	}
	
	/**
	 * Rule 7. 연속된 [ n ]개의 Point가 중심선(CL)로부터 1 Sigma 범위 내에 있음. (양쪽)
	 * 		- 연속된 n개 모두 ±1sigma 범위 안에 있는경우.
	 * 
	 * Rule 8. 연속된 [ n ]개의 Point가 중심선(CL)로부터 1 Sigma 범위 밖에 있음. (양쪽)
	 * 		- 연속된 n개 모두 ±1sigma 범위 밖에 있는경우.
	 * 	
	 * @param samples  표본 list
	 * @param badPoint 계산에 필요한 필수 param -> cl, n,standardDeviation, ResultValueType, ruleName
	 */
	public static List<BadPoint> rule_7_both_8 (List<? extends SpcResultExpriem> samples, BadPoint badPoint){
		
		List<BadPoint> badList = new ArrayList<>();
		SpcRule ruleName = badPoint.getRule();
		int n = badPoint.getN() - 1;
		double cl = badPoint.getCl();
		double sigmaLv1 = cl + badPoint.getStandardDeviation();
		double minaSigmaLv1 = cl - badPoint.getStandardDeviation();

		for( int i = (samples.size() - 1), fromIndex = i - n; fromIndex > -1; i--, fromIndex-- ){
			List<? extends SpcResultExpriem> testRange = samples.subList(fromIndex, i + 1);
			int rangeSize = 
					(int) testRange
							.stream()
							.filter( expr -> {
								double value = badPoint.getResultValueType().getValue(expr, badPoint.isQc());
								return (ruleName == SpcRule.RULE_7)
										? (value > cl && value < sigmaLv1 || value > minaSigmaLv1 && value < cl)    //연속된 n개 모두 ±1sigma 범위 안에 있는경우.
										: (value > cl && value > sigmaLv1 || value < minaSigmaLv1 && value > cl);   //연속된 n개 모두 ±1sigma 범위 밖에 있는경우.
							}).count();

			if( rangeSize == badPoint.getN() ){
				badList.add(
					BadPoint.builder()
							.badSploreNames(testRange)
							.fromIndex(fromIndex)
							.toIndex(i)
							.n(badPoint.getN())
							.cl(cl)
							.sigmaLv1(sigmaLv1)
							.minaSigmaLv1(minaSigmaLv1)
							.standardDeviation(badPoint.getStandardDeviation())
							.rule(ruleName)
							.chartData(badPoint.isChartData())
							.resultValueType(badPoint.getResultValueType())
							.qc(badPoint.isQc())
							.build()
				);
				
				if( badPoint.isFindFirst() ){
					log.info("### Rule test {}, find first ==> return, ResultValueType : {} , badList size : {}", ruleName, badPoint.getResultValueType(), badList.size());
					if(log.isDebugEnabled()){
						log.debug("{} \n", badList);
					}
					return badList;
				}
			}
		}
		log.info("### Rule test {}, ResultValueType : {} , badList size : {}", ruleName, badPoint.getResultValueType(), badList.size());
		if(log.isDebugEnabled()){
			log.debug("{} \n", badList);
		}
		return badList;
	}
}
