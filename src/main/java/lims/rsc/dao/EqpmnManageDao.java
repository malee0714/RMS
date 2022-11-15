package lims.rsc.dao;

import lims.rsc.vo.EqpmnManageDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EqpmnManageDao {

	List<EqpmnManageDto> getEqpmnMList(EqpmnManageDto eqpmnManageDto);
	int insEqpmn(EqpmnManageDto eqpmnManageDto);
	int updEqpmn(EqpmnManageDto eqpmnManageDto);
	List<EqpmnManageDto> getAnalsMtrilList(EqpmnManageDto eqpmnManageDto);
	int insAnalsMtril(EqpmnManageDto eqpmnManageDto);
	int updMtrilSortOrdr(EqpmnManageDto eqpmnManageDto);
	int delAnalsMtril(EqpmnManageDto eqpmnManageDto);
	List<EqpmnManageDto> getAnalsItemList(EqpmnManageDto eqpmnManageDto);
	int insAnalsItem(EqpmnManageDto eqpmnManageDto);
	int updItemSortOrdr(EqpmnManageDto eqpmnManageDto);
	int delAnalsItem(EqpmnManageDto eqpmnManageDto);
	List<EqpmnManageDto> getCrrctCycleList(EqpmnManageDto eqpmnManageDto);
	int insCrrctCycle(EqpmnManageDto eqpmnManageDto);
	int updCrrctCycle(EqpmnManageDto eqpmnManageDto);
	int delCrrctCycle(EqpmnManageDto eqpmnManageDto);
	List<EqpmnManageDto> getEqpmnChckExpr(EqpmnManageDto eqpmnManageDto);
	int insChckExpr(EqpmnManageDto eqpmnManageDto);
	int updChckExpr(EqpmnManageDto eqpmnManageDto);
	int delChckExpr(EqpmnManageDto eqpmnManageDto);

}
