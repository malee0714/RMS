package lims.rsc.service;

import lims.rsc.vo.EqpmnRepairDto;

import java.util.List;

public interface EqpmnRepairService {

	List<EqpmnRepairDto> getEqpRepairHist(EqpmnRepairDto eqpmnRepairDto);
	int saveEqpRepairHist(EqpmnRepairDto eqpmnRepairDto);

}
