package lims.rsc.vo;

import lims.com.vo.BaseDto;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class EqpmnInspcCrrctDto extends BaseDto {

	//검교정, 검교정 주기
	private Integer eqpmnInspctCrrctSeqno;
	private Integer eqpmnSeqno;
	private String eqpmnNm;
	private String eqpmnClNm;
	private String eqpmnManageNo;
	private String serialNo;
	private String modlNm;
	private String inspctCrrctChargerId;
	private String inspctCrrctChargerNm;
	private String inspctCrrctSeCode;
	private String inspctCrrctCycle;
	private String cycleCode;
	private String inspctCrrctDte;
	private String inspctCrrctPlanDte;
	private String nextInspctCrrctDte;
	private String inspctCrrctResultCode;
	private String inspctCrrctResultNm;
	private String sanctnDrftDte;
	private String atchmnflSeqno;
	private String rm;
	private String cycleUpdAt;

	//검교정 의뢰
	private Integer eqpmnInspctCrrctReqestSeqn;
	private Integer reqestSeqno;
	private Integer expriemSeqno;
	private String expriemNm;
	private String resultRegister;
	private String resultValue;
	private String jdgmntWordNm;
	
	//검교정 의뢰 그리드
	private List<EqpmnInspcCrrctDto> existReqList = new ArrayList<>();
	private List<EqpmnInspcCrrctDto> addedReqList = new ArrayList<>();

	//조회 조건
	private String schEqpmnClCode;
	private String schCustlabSeqno;
	private String schEqpmnManageNo;
	private String schEqpmnNm;
	private String schInspctCrrctBeginDte;
	private String schInspctCrrctEndDte;

	//의뢰목록 팝업
	private String reqestDeptNm;
	private String reqestDte;
	private String reqestNo;
	private String inspctTyNm;
	private String clientNm;
	private String custlabNm;
	private String mtrilNm;
	private String sploreNm;
	private String schReqDeptOnPop;
	private String schCustlabOnPop;
	private String schReqBeginDteOnPop;
	private String schReqEndDteOnPop;
	private String schInspctTyCodeOnPop;
	private String schReqNoOnPop;
	private String schSploreNmOnPop;
	private String schMtrilNmOnPop;
	private String ncrChk;
	private String prductTyNm;
	private String schPrductTyCodeOnPop;
	private Integer eqpmnSeqnoPop;
	private String pageGbn;
	private String reqestExpriemSeqno;
	private String exprOdr;
	private String qcResultValue;
	private String prductSeCode;
	private String traceChk;
	private String coaChk;
	private String mnfcturDte;
	private String mtrilSeqno;
	private String mainReqestSeqno;
	private String lotNo;
	private String lotTraceChk;

	public boolean isExistReq() {
		return this.existReqList.size() > 0;
	}

	public boolean isAddedReq() {
		return this.addedReqList.size() > 0;
	}

}

