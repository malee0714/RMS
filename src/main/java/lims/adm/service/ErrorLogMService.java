package lims.adm.service;

import java.util.List;

import lims.adm.vo.ErrorLogMVo;
import lims.req.vo.RequestMVo;

public interface ErrorLogMService {
	//조회
	public List<ErrorLogMVo> getErrorLog(ErrorLogMVo vo);

	
	


}
