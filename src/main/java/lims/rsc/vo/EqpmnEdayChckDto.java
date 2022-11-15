package lims.rsc.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class EqpmnEdayChckDto {

	// 장비일상점검 시험항목
	private Integer eqpmnChckExpriemSeqno;
	private String bplcCode;
	private Integer eqpmnSeqno;
	private String expriemSeqno;
	private String expriemNm;
	private String jdgmntFomCode;
	private String jdgmntFomNm;
	private String mummValue;
	private String mummValueSeCode;
	private String mxmmValue;
	private String mxmmValueSeCode;
	private String textStdr;
	private String unitSeqno;
	private String cycleDc;
	private String sortOrdr;
	private String deleteAt;
	private String lastChangerId;
	private String lastChangeDt;
	private String crud;

	// 장비일상점검 등록
	private String eqpmnEdayChckRegistSeqno;
	private Integer insctrId;
	private String insctrNm;
	private String chckDte;
	private String jdgmntWordCode;
	private String jdgmntWordNm;
	private String rm;

	// 장비일상점검 결과
	private String resultValue;
	private String partclrMatter;

	// 장비일상점검 목록 그리드
	private String eqpmnClCode;
	private String eqpmnClNm;
	private String eqpmnManageNo;
	private String eqpmnNm;
	private String serialNo;
	private String modlNm;

	// 장빚일상점검 정보 그리드
	private String expriemSdspcCn;
	private String unitNm;
	private List<EqpmnEdayChckDto> edayChckExprList;

	// 조회조건
	private String schEqpmnClCode;
	private String schCustlabSeqno;
	private String schEqpmnNm;
	private String schChckBeginDte;
	private String schChckEndDte;

	// 장비 팝업
	private String chrgDeptNm;
	private String custlabNm;

	// 장비일상점검 결과조회
	private String schJdgmntWordCode;

}
