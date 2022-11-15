package lims.util.security;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




import org.springframework.context.ApplicationListener;
import org.springframework.security.config.debug.SecurityDebugBeanFactoryPostProcessor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.session.SessionDestroyedEvent;
import org.springframework.security.web.authentication.session.SessionAuthenticationException;
import org.springframework.security.web.authentication.session.SessionAuthenticationStrategy;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.sys.vo.UserMVo;

@Component
public class SessionEvent implements ApplicationListener<SessionDestroyedEvent>, SessionAuthenticationStrategy{
	static final long serialVersionUID = 3L;
	
	
	@Resource(name = "loginMServiceImpl")
	private lims.com.service.LoginMService loginMService;
	
	@Override
	public void onApplicationEvent(SessionDestroyedEvent event) {
		// TODO Auto-generated method stub
		List<SecurityContext> lstSecurityContext = event.getSecurityContexts();
        //UserDetails ud;
        for (SecurityContext securityContext : lstSecurityContext){
            UserMVo vo = (UserMVo)securityContext.getAuthentication().getPrincipal();
            loginMService.udtLogout(vo);
        }
	}

	@Override
	public void onAuthentication(Authentication authentication, HttpServletRequest request,
			HttpServletResponse response) throws SessionAuthenticationException {
		// TODO Auto-generated method stub
	}

}
