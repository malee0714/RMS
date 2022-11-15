package lims.wrk.dao;

import java.util.List;

import lims.wrk.vo.CLVersionResultVO;
import lims.wrk.vo.CLVersionVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CLSearchMDao {
	List<CLVersionVO> getCLVersions(CLVersionVO vo);
	List<CLVersionResultVO> getCLVersionResults(CLVersionResultVO vo);
	int updateClVersionResult(CLVersionResultVO vo);
	int updateMtrilSdspc(CLVersionResultVO vo);
}
