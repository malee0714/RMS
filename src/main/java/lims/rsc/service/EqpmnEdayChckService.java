package lims.rsc.service;

import lims.rsc.vo.EqpmnEdayChckDto;

import java.util.List;

public interface EqpmnEdayChckService {

	int chkDuplicateChckDte(EqpmnEdayChckDto eqpmnEdayChckDto);
	int saveEqpEdayChkResult(EqpmnEdayChckDto eqpmnEdayChckDto);
	List<EqpmnEdayChckDto> getEqpmnEdayChkList(EqpmnEdayChckDto eqpmnEdayChckDto);
	List<EqpmnEdayChckDto> getEqpEdayChckExprM(EqpmnEdayChckDto eqpmnEdayChckDto);
	List<EqpmnEdayChckDto> getEqpEdayChckResult(EqpmnEdayChckDto eqpmnEdayChckDto);
	List<EqpmnEdayChckDto> getEqpmnListOnPop(EqpmnEdayChckDto eqpmnEdayChckDto);

}
