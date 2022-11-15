package lims.rsc.vo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EqpmnRepairDto {
	
	private Integer eqpmnRepairHistSeqno;
	private String bplcCode;
	private Integer eqpmnSeqno;
	private String eqpmnClNm;
	private String eqpmnManageNo;
	private String eqpmnNm;
	private String serialNo;
	private String modlNm;
	private String occrrncCauseCode;
	private String innerRepairAt;
	private String innerRepairNm;
	private String repairmanNm;
	private String repairBeginDt;
	private String repairEndDt;
	private String eqpmnRepairResultCode;
	private String repairCn;
	private Integer atchmnflSeqno;
	private String rm;
	private String deleteAt;
	private String lastChangerId;
	private String lastChangeDt;
	private String oprAt;

	// 조회 조건
	private String schEqpmnClCode;
	private String schCustlabSeqno;
	private String schEqpmnNm;
	private String schRepairBeginDte;
	private String schRepairEndDte;

}
