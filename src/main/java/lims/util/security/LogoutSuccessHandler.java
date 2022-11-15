package lims.util.security;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;
import org.springframework.stereotype.Component;

@Component
public class LogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler {

	
	@Resource(name = "loginMServiceImpl")
	private lims.com.service.LoginMService LoginMService;
	
	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws java.io.IOException, javax.servlet.ServletException  {
		try{ 
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			setDefaultTargetUrl("/login.lims");
	        super.onLogoutSuccess(request, response, authentication);
		}
	}
}
