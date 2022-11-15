package lims.util.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {
	
	private String loginidname;
	private String loginpwdname;
	private String loginredirectname;
	private String exceptionmsgname;
	private String defaultFailureUrl;


	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception)
			throws IOException, ServletException {
		// Request 객체의 Attribute에 사용자가 실패시 입력했던 로그인 ID와 비밀번호를 저장해두어 로그인페이지에서 이를 접근하도록 한다.

		String user_id = request.getParameter(loginidname);
		String pwd = request.getParameter(loginpwdname);
		String loginRedirect = request.getParameter(loginredirectname);
		
		request.setAttribute(loginidname, user_id);
		request.setAttribute(loginpwdname, pwd);
		request.setAttribute(loginredirectname, loginRedirect);
		
		// Request 객체의 Attribute에 예외 메시지 저장
		request.setAttribute(exceptionmsgname, exception.getMessage());
		
		request.getRequestDispatcher(defaultFailureUrl).forward(request, response);
	}

	public String getLoginidname() {
		return loginidname;
	}

	public void setLoginidname(String loginidname) {
		this.loginidname = loginidname;
	}

	public String getLoginpwdname() {
		return loginpwdname;
	}

	public void setLoginpwdname(String loginpwdname) {
		this.loginpwdname = loginpwdname;
	}

	public String getLoginredirectname() {
		return loginredirectname;
	}

	public void setLoginredirectname(String loginredirectname) {
		this.loginredirectname = loginredirectname;
	}

	public String getExceptionmsgname() {
		return exceptionmsgname;
	}

	public void setExceptionmsgname(String exceptionmsgname) {
		this.exceptionmsgname = exceptionmsgname;
	}

	public String getDefaultFailureUrl() {
		return defaultFailureUrl;
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}

}
