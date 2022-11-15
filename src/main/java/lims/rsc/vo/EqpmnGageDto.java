package lims.rsc.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter @Setter
public class EqpmnGageDto extends EqpmnInspcCrrctDto {

	//Gage 등록
	private Integer eqpmnGageRegistSeqno;
	private String registerId;
	private String registerNm;
	private String registDte;
	
	//Gage 의뢰
	private String eqpmnGageReqestSeqno;

	//Gage 결과
	private Integer eqpmnGageResultSeqno;
	private String cntrbtdgValue;
	private String rsrchChngeValue;
	private String guacctoCtgryValue;
	private String gageJdgmntCode;

	//Gage 의뢰 그리드
	private List<EqpmnGageDto> reqList = new ArrayList<>();
	private List<EqpmnGageDto> newReqList = new ArrayList<>();
	private List<EqpmnGageDto> resultList = new ArrayList<>();
	private List<EqpmnGageDto> newResultList = new ArrayList<>();
	private List<EqpmnGageDto> editedResultList = new ArrayList<>();

	//조회 조건
	private String schRegistBeginDte;
	private String schRegistEndDte;

	public boolean isNull() {
		return this.eqpmnGageRegistSeqno == null;
	}

	public boolean isNotEmptyReq() {
		return this.reqList.size() > 0;
	}

	public boolean isNewReq() {
		return this.newReqList.size() > 0;
	}

	public boolean isNotEmptyResult() {
		return this.resultList.size() > 0;
	}

	public boolean isNewResult() {
		return this.newResultList.size() > 0;
	}

	public boolean isEditedResult() {
		return this.editedResultList.size() > 0;
	}

}
