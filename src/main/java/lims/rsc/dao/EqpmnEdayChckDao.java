package lims.rsc.dao;

import lims.rsc.vo.EqpmnEdayChckDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EqpmnEdayChckDao {
	
	List<EqpmnEdayChckDto> getEqpmnEdayChkList(EqpmnEdayChckDto eqpmnEdayChckDto);
	int chkDuplicateChckDte(EqpmnEdayChckDto eqpmnEdayChckDto);
	int insEqpEdayChkRegist(EqpmnEdayChckDto eqpmnEdayChckDto);
	int insEqpEdayChkResult(EqpmnEdayChckDto eqpmnEdayChckDto);
	List<EqpmnEdayChckDto> getEqpEdayChckExprM(EqpmnEdayChckDto eqpmnEdayChckDto);
	List<EqpmnEdayChckDto> getEqpEdayChckResult(EqpmnEdayChckDto eqpmnEdayChckDto);
	int updEqpEdayChkRegist(EqpmnEdayChckDto eqpmnEdayChckDto);
	int updEqpEdayChckResult(EqpmnEdayChckDto eqpmnEdayChckDto);
	List<EqpmnEdayChckDto> getEqpmnListOnPop(EqpmnEdayChckDto eqpmnEdayChckDto);
	
}
