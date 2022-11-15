package lims.rsc.dao;

import lims.rsc.vo.EqpmnRepairDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EqpmnRepairDao {

	List<EqpmnRepairDto> getEqpRepairHist(EqpmnRepairDto eqpmnRepairDto);
	int insEqpRepairHist(EqpmnRepairDto eqpmnRepairDto);
	int updEqpRepairHist(EqpmnRepairDto eqpmnRepairDto);
	Integer getMostRecentRepairHist(EqpmnRepairDto eqpmnRepairDto);
	int updEqpmnOprAt(EqpmnRepairDto eqpmnRepairDto);

}
