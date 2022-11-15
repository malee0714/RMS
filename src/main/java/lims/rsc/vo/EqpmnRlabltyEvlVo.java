package lims.rsc.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Map;

@Getter
@Setter
public class EqpmnRlabltyEvlVo {

	//장비신뢰성평가
	private int eqpmnRlabltyEvlRegistSeqno;
	private String inspctCrrctSeCode;
	private String inspctCrrctSeNm;
	private String evlerId;
	private String evlerNm;
	private String evlDte;
	private int atchmnflSeqno;
	private String rm;
	private String eqpmnClCode;
	private String eqpmnClNm;
	private String eqpmnManageNo;
	private String eqpmnNm;
	private int eqpmnSeqno;
	private int eqpmnRlabltyEvlExpriemSeqn;
	private String bplcCode;
	private int expriemSeqno;
	private int sortOrdr;
	private String expriemNm;
	private String resultValue;
	private String detectLimitApplcAt;
	private int detectLimitSeqno;
	private String deleteAt;
	private String bestInspctInsttCode;
	private String value;
	private String key;
	private String inspctCrrctCycle;
	private String cycleCode;
	private String inspctCrrctPlanDte;
	private String nextInspctCrrctDte;
	private List<Map<String, Object>> notInCode;






	//조회 기타
	private String bplcCodeSch;
	private String evlBeginDteSch;
	private String evlEndDteSch;
	private String eqpmnNmSch;
	private String evlerNmSch;
	private String inspctCrrctSeCodeSch;
	private List<EqpmnRlabltyEvlVo> list;




}
