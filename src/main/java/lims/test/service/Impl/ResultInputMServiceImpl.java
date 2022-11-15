package lims.test.service.Impl;

import lims.com.vo.WdtbVo;
import lims.qa.vo.NCRReportMVo;
import lims.spc.enm.ResultValueType;
import lims.spc.service.SpcRuleTestService;
import lims.spc.vo.SpcMtrilExpriem;
import lims.spc.vo.SpcParam;
import lims.spc.vo.SpcRuleTestDto;
import lims.test.dao.ResultInputMDao;
import lims.test.service.ResultInputMService;
import lims.test.vo.ResultInputMVo;
import lims.util.CommonFunc;
import lims.util.CustomMessageException;
import lims.wrk.vo.CalcLawMVo;
import lims.wrk.vo.PrductMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class ResultInputMServiceImpl implements ResultInputMService {

	private final ResultInputMDao resultInputMDao;
	private final CommonFunc commonFunc;
	private final SpcRuleTestService spcRuleTestService;

	@Autowired
	public ResultInputMServiceImpl(ResultInputMDao resultInputMDao, CommonFunc commonFunc, SpcRuleTestService spcRuleTestServiceImpl) {
		this.resultInputMDao = resultInputMDao;
		this.commonFunc = commonFunc;
		this.spcRuleTestService = spcRuleTestServiceImpl;
	}

	//의뢰 목록 조회
	@Override
	public List<ResultInputMVo> getReqestListSch(ResultInputMVo vo) {
		List<ResultInputMVo> list = this.resultInputMDao.getReqestListSch(vo);
		return list;
	}

	//시험항목 목록 조회
	@Override
	public List<ResultInputMVo> getExpriemListSch(ResultInputMVo vo) {
		List<ResultInputMVo> list = this.resultInputMDao.getExpriemListSch(vo);

		return list;
	}

	//의뢰시험항목에 계산식 저장/수정
	@Override
	public void saveExpriemResult(ResultInputMVo param) {
		//return 해줄 변수
		List<ResultInputMVo> list = param.getEditSaveData();

		Optional<ResultInputMVo> item = list.stream().findFirst();

		//의뢰 진행상황 체크
		checkRequestProgrs(param, "IM03000003");

		//시험항목 수정한 내역이 있으면 타는 로직
		if(item.isPresent()) {

			ResultInputMVo firstVo = item.get();

			for(ResultInputMVo vo : list) {

				//계산식 폼 셋팅하기
				List<CalcLawMVo> resultCal = (vo.getCalcItem() == null || vo.getCalcItem().getCalcGridList().isEmpty())? null : vo.getCalcItem().getCalcGridList();

				//계산식 저장하기
				if(resultCal != null && !resultCal.isEmpty()) {
					mergeCalcList(vo, resultCal);
				}

				//시험항목 결과 입력
				updateExpriemResult(vo);

				updateExpriem(vo);
			}

			this.resultInputMDao.updateRequestProcess(firstVo);
		};
	}

	//spc8대룰 검사
	private void testResultBySPC8Rule(ResultInputMVo vo) {

		List<ResultInputMVo> list = vo.getEditSaveData();

		List<ResultInputMVo> failExpriem = new ArrayList<ResultInputMVo>();

		List<ResultInputMVo> successExpriem = new ArrayList<ResultInputMVo>();

		List<ResultInputMVo> failSpcExpriem = new ArrayList<ResultInputMVo>();

		List<ResultInputMVo> successSpcExpriem = new ArrayList<ResultInputMVo>();

		List<ResultInputMVo> allExpriem = new ArrayList<ResultInputMVo>();

		//최대/최소에 위배된 항목들은 SPC8대룰 체크 안함(NCR REPORT , MAIL에 중복으로 항목이 들어가는걸 막기 위함)
		Boolean flag = false;

		for(int i = 0; i < list.size(); i++){

			ResultInputMVo resultData = list.get(i);

			/*//결과가 빈값은 spc8대룰 검사를 안한다.
			if(commonFunc.isEmpty(resultData.getResultValue())) continue;

			allExpriem.add(resultData);

			if(!commonFunc.isEmpty(resultData.getJdgmntWordCode()) && resultData.getJdgmntWordCode().equals("IM05000002")) {
				flag = true;
				failExpriem.add(resultData);
			}else if(!commonFunc.isEmpty(resultData.getJdgmntWordCode()) && !resultData.getJdgmntWordCode().equals("IM05000002")) {
				successExpriem.add(resultData);
			}*/

			if(!flag) {
				//spc8대룰 적용해서 부적합이면 npc report테이블에 등록
				SpcRuleTestDto spcRuleTestDto = SpcRuleTestDto
						.builder()
						//.lotNo(resultData.getLotNo()) //라트
						.inspctTyCode(resultData.getInspctTyCode()) //검사유형
						.build();

				SpcMtrilExpriem spcMtrilExpriem = SpcMtrilExpriem.builder()
						.mtrilSeqno(resultData.getMtrilSeqno()) //자재 일련번호
						.mtrilSdspcSeqno(resultData.getMtrilSdspcSeqno()) //기준규격일련번호
						.build();

				SpcParam spcParam = SpcParam
						.builder()
						.spcRuleTestDto(spcRuleTestDto)
						.spcMtrilExpriem(spcMtrilExpriem)
						.resultValueType(ResultValueType.RESULT_VALUE)
						.build();

				//spc8대룰에 합격 - true , 불합격 - false
				/*if(this.spcRuleTestService.resultValueSpcTest(spcParam).isPresent()) {
					failSpcExpriem.add(resultData);
				}else {
					successSpcExpriem.add(resultData);
				};*/
			}

			flag = false;
		}

		//배포 테이블에 데이터 쌓기
//		settingWdtbCn(vo, allExpriem, failExpriem, successExpriem, failSpcExpriem, successSpcExpriem);

	}

	//배포 테이블에 데이터 쌓기
	private void settingWdtbCn(ResultInputMVo vo
			, List<ResultInputMVo> allExpriem
			, List<ResultInputMVo> failExpriem
			, List<ResultInputMVo> successExpriem
			, List<ResultInputMVo> failSpcExpriem
			, List<ResultInputMVo> successSpcExpriem) {

		NCRReportMVo ncr = new NCRReportMVo();

		//워닝 메일 발송할 사용자가 있는지 조회 해오기
		List<PrductMVo> target = this.resultInputMDao.getMtrilTarget(vo.getReqestSeqno());


		//**********최대/최소 기준규격에 위배된 항목들 기준으로 NCR REPORT작성
		//기준규격에 부적합 항목 RS_NCR에 등록
		if(failExpriem.size() > 0) {
			ncr = insertNCRReport(failExpriem, "RS19000001", vo.getBplcCode());
		}

		//성공 시험항목 받을 사람이 있을경우
		if(target.stream().filter(t -> t.getPsexamRecptnAt().equals("Y")).findFirst().isPresent()) {
			if(successExpriem.size() > 0) {
				//합격 시험항목 메일링
				settingMailCn(successExpriem, ncr, "S");
			}
		};

		//불합격 시험항목을 받을 사람이 있을경우
		if(target.stream().filter(t -> t.getDsqlfcRecptnAt().equals("Y")).findFirst().isPresent()) {
			if(failExpriem.size() > 0) {
				//불합격 시험항목 메일링
				settingMailCn(failExpriem, ncr, "F");
			}
		}
		//*************************


		//**********SPC8대룰에 위배된 항목들 기준으로 NCR REPORT작성과 메일링 기능
		//기준규격에 부적합 항목 RS_NCR에 등록
		if(failSpcExpriem.size() > 0) {
			ncr = insertNCRReport(failSpcExpriem, "RS19000002", vo.getBplcCode());
		}

		//전체 시험항목을 받기로 되어있는사람을 제외한 성공 시험항목 받을 사람이 있을경우
		if(target.stream().filter(t -> t.getPsexamRecptnAt().equals("Y") && t.getAllRecptnAt().equals("N")).findFirst().isPresent()) {
			if(successSpcExpriem.size() > 0) {
				//합격 시험항목 메일링
				settingMailCn(successSpcExpriem, ncr, "S");
			}
		};

		//전체 시험항목을 받기로 되어있는사람을 제외한 불합격 시험항목을 받을 사람이 있을경우
		if(target.stream().filter(t -> t.getDsqlfcRecptnAt().equals("Y") && t.getAllRecptnAt().equals("N")).findFirst().isPresent()) {
			if(failSpcExpriem.size() > 0) {
				//불합격 시험항목 메일링
				settingMailCn(failSpcExpriem, ncr, "F");
			}
		}
		//*************************

		//전체 시험항목을 받을사람이 있을 경우
		if(target.stream().filter(t -> t.getAllRecptnAt().equals("Y")).findFirst().isPresent()) {
			if(allExpriem.size() > 0) {
				settingMailCn(allExpriem, null, "A");
			}
		}
	}

	@Override
	public void completeResultInput(ResultInputMVo vo) {

		checkRequestProgrs(vo, "IM03000003");

		//spc8대룰 검사
//		testResultBySPC8Rule(vo);

		this.resultInputMDao.completeResultInput(vo);
		this.commonFunc.auditTrail("CM03000007", "결과입력 완료", vo.getReqestSeqno(), null, null, null, vo.getBplcCode(), null, null, null);
	}


	@Override
	public void returnExpriem(ResultInputMVo vo) {
		checkRequestProgrs(vo, "IM03000004");

		this.resultInputMDao.returnExpriem(vo);

		this.commonFunc.auditTrail("CM03000007", "결과 회수", vo.getReqestSeqno(), null, null, null, vo.getBplcCode(), null, null, null);
	}

	@Override
	public List<ResultInputMVo> getExpriemCalcNomfrm(ResultInputMVo vo) {
		return this.resultInputMDao.getExpriemCalcNomfrm(vo);
	}

	/*
	 * 재분석 기능
	 * */
	@Override
	public void changeToNextOdr(ResultInputMVo vo) {
		List<ResultInputMVo> list = vo.getEditSaveData();
		ResultInputMVo firVo = list.get(0);

		checkRequestProgrs(firVo,"IM03000003");

		//의뢰 정보 수정(차수 등)
		this.resultInputMDao.insReReqest(firVo);

		vo.getEditSaveData().forEach(item -> {
			//im_reqesT_expriem 정보 수정
			this.resultInputMDao.insReExpriem(item);
			//im_reqest_expriem_Result 차수 생성
			this.resultInputMDao.insReExpriemResult(item);
			//im_reqest_expriem_Result 차수 생성
			this.resultInputMDao.insReExpriemResultNomfrm(item);

			this.commonFunc.auditTrail("CM03000007", "의뢰 재분석", item.getReqestSeqno(), item.getReqestExpriemSeqno(), item.getExpriemSeqno(), item.getExprOdr(), item.getBplcCode(), null, null, null);
		});
	}

	//계산식 추가 및 수정(MERGE문)
	public void mergeCalcList(ResultInputMVo resultData, List<CalcLawMVo> resultCalc) {


		for(int i = 0; i < resultCalc.size(); i++) {
			resultCalc.get(i).setReqestExpriemSeqno(resultData.getReqestExpriemSeqno());
			resultCalc.get(i).setExprOdr(resultData.getExprOdr());

			//계산식 변수 인서트
			this.resultInputMDao.insertNomfrmInfo(resultCalc.get(i));

			this.commonFunc.auditTrail(
					"CM03000007", "결과입력 계산식 저장", resultData.getReqestSeqno(), resultData.getReqestExpriemSeqno(), resultData.getExpriemSeqno(), resultData.getExprOdr(), resultData.getBplcCode(), resultCalc.get(i).getVriablId(), null, null);
		}
	}

	//IM_REQEST_EXPRIEM_RESULT테이블에 결과 값 입력
	public void updateExpriemResult(ResultInputMVo vo) {
		//시험항목 결과 입력
		this.resultInputMDao.updateExpriemResult(vo);
	}

	//IM_REQEST_EXPRIEM테이블에 데이터 입력
	public void updateExpriem(ResultInputMVo vo) {
		//시험항목 결과 입력(리턴으로 해당 항목의 진행상황을 넘겨준다.)
		this.resultInputMDao.updateExpriem(vo);

		this.commonFunc.auditTrail("CM03000007", "결과입력 저장", vo.getReqestSeqno(), vo.getReqestExpriemSeqno(), vo.getExpriemSeqno(), vo.getExprOdr(), vo.getBplcCode(), null, null, null);
	}

	//부적합 난 항목 ncr report에 insert
	public NCRReportMVo insertNCRReport(List<ResultInputMVo> failExpriem, String importTyCode, String bplcCode) {

		NCRReportMVo ncr = new NCRReportMVo();

		//전체 시험항목 이어 붙이기
		String expriemNmAll = failExpriem.stream()
										.map(x -> x.getExpriemNm() + "")
										.distinct()
										.collect(Collectors.joining(","));

		ncr.setExpriemSumry(expriemNmAll);
		ncr.setImproptTyCode(importTyCode);
		ncr.setReqestSeqno(failExpriem.get(0).getReqestSeqno());
		ncr.setBplcCode(bplcCode);

		this.resultInputMDao.insertNCRReport(ncr);

		for(ResultInputMVo fail : failExpriem) {
			ncr.setReqestExpriemSeqno(fail.getReqestExpriemSeqno());
			ncr.setExprOdr(fail.getExprOdr());
			ncr.setResultValue(fail.getResultValue());

			List<NCRReportMVo> ncrList = this.resultInputMDao.checkDuplicateNcrExpriem(ncr);

			if(ncrList.size() == 0){
				this.resultInputMDao.insertNCRDetailReport(ncr);
			}

		}

		return ncr;

	}

	private void settingMailCn(List<ResultInputMVo> expriem, NCRReportMVo ncr, String type) {
		StringBuffer buffer = new StringBuffer();
		int cnt = expriem.size()-1;
		ResultInputMVo vo = expriem.get(0);
		WdtbVo wv = new WdtbVo();

		String title = "";
		if(type != null && type.equals("S"))
			title = vo.getMtrilNm() + "」의 '["+vo.getExpriemNm()+"]'분석항목 " + ((cnt > 0) ? "외 " + cnt + "항목" : "" ) + " spec pass";
		else if(type != null && type.equals("F"))
			title = "[LIMS] 「" + vo.getMtrilNm() + "」의 '["+vo.getExpriemNm()+"]'분석항목 " + ((cnt > 0) ? "외 " + cnt + "항목" : "" ) + " spec off발생";
		else if(type != null && type.equals("A"))
			title = "[LIMS] 「" + vo.getMtrilNm() + "」의 '["+vo.getExpriemNm()+"]'분석항목 " + ((cnt > 0) ? "외 " + cnt + "항목" : "" ) + " spec off발생";


		String titleTr = "<tr>";
		String p = "<p align='center' style='text-align : center;'>";
		String tr = "<tr>";
		String td = "<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>";
		String th = "<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>";
		String span = "<span style='font-size:9pt;'>";
		String li = "<li style='font-weight: bold;'>";
		String spanE = "</span>";
		String tdE = "</td>";
		String thE = "</th>";
		String trE = "</tr>";
		String liE = "</li>";
		String pE = "</p>";

		Optional<ResultInputMVo> first = expriem.stream().findFirst();

		if(first.isPresent()){
			buffer.append("<h3>" + title + "</h3>");
			buffer.append("<ul>");
				buffer.append(li);
				buffer.append("Data확인 및 해당 제품군에 대한 내부 이상발생 처리절차를 따르시오.");
				buffer.append(liE);
				if(!type.equals("A")) {
					buffer.append(li);
					buffer.append("QMS 문서번호 - " + ncr.getNcrNo());
					buffer.append(liE);
				}
			buffer.append("</ul>");
			buffer.append("<table style='border-top:1px solid #1f296f;'>");
				buffer.append(tr);
					buffer.append(th);
						buffer.append("분석항목");
					buffer.append(thE);
					buffer.append(th);
						buffer.append("단위");
					buffer.append(thE);
					buffer.append(th);
						buffer.append("상한");
					buffer.append(thE);
					buffer.append(th);
						buffer.append("하한");
					buffer.append(thE);
					buffer.append(th);
						buffer.append("스펙");
					buffer.append(thE);
					buffer.append(th);
						buffer.append("분석");
					buffer.append(thE);
				buffer.append(trE);

				expriem.stream().parallel()
				.forEach(y -> {
					buffer.append(tr);
						buffer.append(th);
							buffer.append((!this.commonFunc.isEmpty(y.getExpriemNm()))? y.getExpriemNm() : "");
						buffer.append(thE);
						buffer.append(td);
							buffer.append(!this.commonFunc.isEmpty(y.getUnitNm())? y.getUnitNm() :  "");
						buffer.append(tdE);
						buffer.append(td);
							buffer.append(!this.commonFunc.isEmpty(y.getUclValue())? y.getUclValue() : "");
						buffer.append(tdE);
						buffer.append(td);
							buffer.append(!this.commonFunc.isEmpty(y.getLclValue())? y.getLclValue() : "");
						buffer.append(tdE);
						buffer.append(td);
							buffer.append(!this.commonFunc.isEmpty(y.getLclUcl())? y.getLclUcl() : "");
						buffer.append(tdE);
						buffer.append(td);
							buffer.append(!this.commonFunc.isEmpty(y.getResultValue())? y.getResultValue() : "");
						buffer.append(tdE);

					buffer.append(trE);
				});
				buffer.append(tr);
					buffer.append(th);
						buffer.append("요청비고");
					buffer.append(thE);
					buffer.append("<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px;>");
						buffer.append("<textarea rows='6' style='resize: none; width: 100%;' readonly>");
							buffer.append("요청비고");
						buffer.append("</textarea>");
					buffer.append(tdE);
				buffer.append(trE);
			buffer.append("</table>");

			//메일 내용
			wv.setCn(buffer.toString());
			//메일 제목
			wv.setSj(title);
			wv.setType(type);
			wv.setReqestSeqno(first.get().getReqestSeqno());

			this.resultInputMDao.insertWdtbInfo(wv);

			this.resultInputMDao.insertWdtbInfoSender(wv);
		};
	}

	public void checkRequestProgrs(ResultInputMVo vo, String value){
		String progrsSittn = this.resultInputMDao.checkReqestProGrs(vo);

		if(progrsSittn == null || !(progrsSittn.equals(value))) {
			throw new CustomMessageException("진행상황을 확인해주세요");
		}
	}
}
