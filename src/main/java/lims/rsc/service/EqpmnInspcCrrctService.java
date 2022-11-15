package lims.rsc.service;

import lims.rsc.vo.EqpmnInspcCrrctDto;

import java.util.List;

public interface EqpmnInspcCrrctService {

	List<EqpmnInspcCrrctDto> getEqpmnInspctList(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	int saveEqpmnInspctCrrct(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	EqpmnInspcCrrctDto chkExistAtInspctCycle(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	int chkDuplicateInspctDte(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	List<EqpmnInspcCrrctDto> getEqpInspctCrrctReq(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	List<EqpmnInspcCrrctDto> getEqpInspctCrrctReqExpr(List<Integer> list);
	int delEqpInspctCrrctReq(List<EqpmnInspcCrrctDto> list);

}
