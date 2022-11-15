package lims.rsc.service;

import lims.rsc.vo.EqpmnManageDto;

import java.util.List;

public interface EqpmnManageService {
	
	List<EqpmnManageDto> getEqpmnMList(EqpmnManageDto eqpmnManageDto);
	int insEqpmn(EqpmnManageDto list);
	int updEqpmn(EqpmnManageDto list);
	List<EqpmnManageDto> getAnalsMtrilList(EqpmnManageDto eqpmnManageDto);
	int delAnalsMtril(List<EqpmnManageDto> list);
	List<EqpmnManageDto> getAnalsItemList(EqpmnManageDto eqpmnManageDto);
	int delAnalsItem(List<EqpmnManageDto> list);
	List<EqpmnManageDto> getCrrctCycleList(EqpmnManageDto eqpmnManageDto);
	int delCrrctCycle(List<EqpmnManageDto> list);
	List<EqpmnManageDto> getEqpmnChckExpr(EqpmnManageDto eqpmnManageDto);
	int delChckExpr(List<EqpmnManageDto> list);

}
