package lims.adm.service.Impl;

import lims.adm.dao.ErrorLogMDao;
import lims.adm.service.ErrorLogMService;
import lims.adm.vo.ErrorLogMVo;
import lims.com.service.CommonService;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ErrorLogMServiceImpl implements ErrorLogMService {

	private final CommonFunc commonFunc;
	private final CommonService commonService;
	private final ErrorLogMDao errorLogMDao;

	@Autowired
	public ErrorLogMServiceImpl(CommonFunc commonFunc, CommonService commonServiceImpl, ErrorLogMDao errorLogMDao) {
		this.commonFunc = commonFunc;
		this.commonService = commonServiceImpl;
		this.errorLogMDao = errorLogMDao;
	}

	@Override
	public List<ErrorLogMVo> getErrorLog(ErrorLogMVo vo){
		return errorLogMDao.getErrorLog(vo);
	}



}
