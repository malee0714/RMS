package lims.src.dao;

import lims.src.vo.EqpmnOprManageDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EqpmnOprMDao {
	List<EqpmnOprManageDto> getParMonTU(EqpmnOprManageDto eqpmnOprManageDto);
}
