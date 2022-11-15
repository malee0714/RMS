package lims.util.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import lims.com.service.CommonService;
import lims.com.service.LoginMService;
import lims.sys.vo.SysManageVo;
import lims.sys.vo.UserMVo;

@Service
public class CustomUserDetailsService implements UserDetailsService{
	
	private final LoginMService loginMService;
	private final CommonService commonService;
	
	@Autowired
	public CustomUserDetailsService( LoginMService loginMServiceImpl, CommonService commonServiceImpl) {
		this.loginMService = loginMServiceImpl;
		this.commonService = commonServiceImpl;
	}
	
	@Override 
	public UserMVo loadUserByUsername(final String userId) throws UsernameNotFoundException { 
		
		// 회원 정보 dao 에서 데이터를 읽어 옴. 
		UserMVo user = new UserMVo();
		user.setLoginId(userId);

		return loginMService.getUser(user);
	}
	
	public SysManageVo getSystemRule() {
		return commonService.getSystemRule();
	}

}
