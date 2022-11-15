package lims.rsc.dao;

import lims.rsc.vo.EqpmnInspcCrrctDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EqpmnInspcCrrctDao {

	List<EqpmnInspcCrrctDto> getEqpmnInspctList(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	int insEqpmnInspctCrrct(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	int updEqpmnInspctCrrct(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	int updInspctCrrctDte(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	EqpmnInspcCrrctDto chkExistAtInspctCycle(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	int chkDuplicateInspctDte(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	List<EqpmnInspcCrrctDto> getEqpInspctCrrctReq(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	int insEqpInspctCrrctReq(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	int delEqpInspctCrrctReq(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);
	List<EqpmnInspcCrrctDto> getEqpInspctCrrctReqExpr(List<Integer> list);

}
