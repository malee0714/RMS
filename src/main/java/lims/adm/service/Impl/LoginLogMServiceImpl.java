package lims.adm.service.Impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.adm.dao.LoginLogMDao;
import lims.adm.service.LoginLogMService;
import lims.adm.vo.LoginLogMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;

@Service
public class LoginLogMServiceImpl implements LoginLogMService{
	
	
	@Autowired
	LoginLogMDao LoginLogMDao;
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Override
	public List<LoginLogMVo> getLogingLoigMList(LoginLogMVo LoginLogMVo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		LoginLogMVo.setInspctInsttCode(userMVo.getBestInspctInsttCode());
		return LoginLogMDao.getLogingLoigMList(LoginLogMVo);
	}
	
}
