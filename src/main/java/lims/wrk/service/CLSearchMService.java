package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.CLVersionResultVO;
import lims.wrk.vo.CLVersionVO;

public interface CLSearchMService {
	List<CLVersionVO> getCLVersions(CLVersionVO vo);
	List<CLVersionResultVO> getCLVersionResults(CLVersionResultVO vo);
	void updateClVersionResult(List<CLVersionResultVO> list);
}
