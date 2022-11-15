package lims.wrk.dao;

import java.util.List;

import lims.wrk.vo.CLManageMVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CLManageMDao {
	public List<CLManageMVo> getCLManageList(CLManageMVo vo);
	public int updateCLM(CLManageMVo vo);
	public int insertCLM(CLManageMVo vo);
}
