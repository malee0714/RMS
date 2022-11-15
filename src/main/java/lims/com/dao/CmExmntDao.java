package lims.com.dao;

import lims.com.vo.CmExmntDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CmExmntDao {

	void insertExmnt(CmExmntDto cmExmntDto);

	void insertExmntHistory(CmExmntDto cmExmntDto);
	
	void updateExmnt(CmExmntDto cmExmntDto);

	List<CmExmntDto> getExmntHistory(CmExmntDto cmExmntDto);

}
