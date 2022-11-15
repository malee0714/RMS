package lims.qa.dao;

import lims.com.vo.CmRtn;
import lims.qa.vo.SanctnManageDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SanctnManageDao {

	List<SanctnManageDto> getSanctn(SanctnManageDto cmSanctn);

	void confirmSanctnInfo(SanctnManageDto sanctnManageDto);

	List<CmRtn> getRtn(CmRtn cmRtn);

	void returnProcess(SanctnManageDto sanctnManageDto);

	void insertReturn(SanctnManageDto sanctnManageDto);
}
