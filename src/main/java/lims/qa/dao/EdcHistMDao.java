package lims.qa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import lims.qa.vo.EdcManageDto;

@Mapper
public interface EdcHistMDao {

	List<EdcManageDto> getEdcAllList(EdcManageDto edcManageDto);

}
