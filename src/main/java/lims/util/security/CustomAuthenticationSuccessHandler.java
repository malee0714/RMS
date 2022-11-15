package lims.util.security;

import lims.com.service.CommonService;
import lims.com.service.LoginMService;
import lims.sys.service.CmmnCodeMService;
import lims.sys.vo.UserMVo;
import lims.util.Locale.LocaleUtil;
import lims.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Service
@PropertySource("classpath:property/foosung.properties")
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	
	// RD 레포트 서버 세팅
	@Value("${foosung.DATA_SERVER}")
	private String DATA_SERVER;
	@Value("${foosung.REPORTING_SERVER}")
	private String REPORTING_SERVER;
	@Value("${foosung.SERVER_IP}")
	private String SERVER_IP;
	@Value("${foosung.REPORTID}")
	private String reportID;
	@Value("${foosung.REPORTPW}")
	private String reportPW;
	@Value("${foosung.SERVICENAME}")
	private String rdServiceNm;
	@Value("${foosung.CONTYPE}")
	private String rdContype;
	
	// RDMS 세팅
	@Value("${enf.OS_URL}")
	private String rdmsUrl;
	
	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Resource(name = "loginMServiceImpl")
	private LoginMService loginMService;
	
	@Resource(name ="cmmnCodeMServiceImpl")
	private CmmnCodeMService cmmnCodeMService;
	
	private RequestCache requestCache = new HttpSessionRequestCache();
	private String targetUrlParameter;
	private String defaultUrl;
	private boolean useReferer;
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	@Autowired
	private LocaleUtil localeUtil;
	
	public CustomAuthenticationSuccessHandler() {
		targetUrlParameter = "";
		defaultUrl = "/";
		useReferer = false;
	}	

	public String getTargetUrlParameter() {
		return targetUrlParameter;
	}

	public void setTargetUrlParameter(String targetUrlParameter) {
		this.targetUrlParameter = targetUrlParameter;
	}

	public String getDefaultUrl() {
		return defaultUrl;
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}

	public boolean isUseReferer() {
		return useReferer;
	}
	
	public void setUseReferer(boolean useReferer) {
		this.useReferer = useReferer;
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		clearAuthenticationAttributes(request);
		
		//getSession(true): HttpSession이 존재하면 현재 HttpSession을 반환하고 존재하지 않으면 새로이 세션을 생성
		//getSession(false): HttpSession이 존재하면 현재 HttpSession을 반환하고 존재하지 않으면 새로이 생성하지 않고 그냥 null을 반환
		HttpSession session = request.getSession(true);
		UserMVo vo = (UserMVo)authentication.getPrincipal();
		
		String langCd = request.getParameter("langCd");
		vo.setNationLangCode(langCd);
		String ip = request.getRemoteAddr();
		ip = cmmnCodeMService.getHostAddress(ip);
		vo.setLoginIp(ip);
		session.setAttribute("UserMVo", vo);
		
		commonService.setLoginLog(vo, ip);
		
		// 로그인 성공시 로그인 실패 카운터 초기화
		loginMService.loginSucceedOrFailure(vo);
		loginMService.updateLastLoginDate(vo);
		
		localeUtil.setSessionLocale(session, langCd);
		
		Util util = Util.getInstance();
		util.setDATA_SERVER(DATA_SERVER);
		util.setREPORTING_SERVER(REPORTING_SERVER);
		util.setSERVER_IP(SERVER_IP);
		util.setReportID(reportID);
		util.setReportPW(reportPW);
		util.setRdServiceNm(rdServiceNm);
		util.setRdContype(rdContype);
		util.setRdmsUrl(rdmsUrl); // rdms 서버 url 할당
		util.setGetAllCmmnCodeMap(commonService.getAllCmmnCodeMap());

		int intRedirectStrategy = decideRedirectStrategy(request, response);
		switch(intRedirectStrategy) {
		case 1:
			useTargetUrl(request, response);
			break;
		case 2:
			useSessionUrl(request, response);
			break;
		case 3:
			useRefererUrl(request, response);
			break;
		default:
			useDefaultUrl(request, response);
			break;
		}
	}
	
	private void useTargetUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		if(savedRequest != null) {
			requestCache.removeRequest(request, response);
		}
		redirectStrategy.sendRedirect(request, response, targetUrlParameter);
	}
	
	private void useSessionUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String targetUrl = savedRequest.getRedirectUrl();
		redirectStrategy.sendRedirect(request, response, targetUrl);
	}
	
	private void useRefererUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String targetUrl = request.getHeader("REFERER");
		redirectStrategy.sendRedirect(request, response, targetUrl);
	}
	
	private void useDefaultUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {
		redirectStrategy.sendRedirect(request, response, defaultUrl);
	}

	private void clearAuthenticationAttributes(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		if(session == null) {
			return;
		}
		
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}
	
	/*
	 * 인증 성공 후 어떤 URL로 redirect 할지를 결정한다.
	 * 판단 기준은 targetUrlParameter 값을 읽은 URL이 존재할 경우 그것을 1순위
	 * 1순위 URL이 없을 경우 Spring Security가 세션에 저장한 URL을 2순위
	 * 2순위 URL이 없을 경우 Request의 REFERER를 사용하고 그 REFERER URL이 존재할 경우 그 URL을 3순위
	 * 3순위 URL이 없을 경우 Default URL을 4순위로 한다. 
	 * @return 1 : targetUrlParameter 값을 ㅇ릭은 URL
	 * 			2 : Session에 저장되어 있는 URL
	 * 			3 : referer 헤더에 있는 URL
	 * 			0 : default url
	 */
	private int decideRedirectStrategy(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		targetUrlParameter = request.getParameter("targetUrlParameter");
		
		if(!"".equals(targetUrlParameter)) {
			if(targetUrlParameter != null && !targetUrlParameter.equals("")) {
				result = 1;
			} else {
				if(savedRequest != null) {
					result = 2;
				} else {
					String refererUrl = request.getHeader("REFERER");
					if(useReferer && StringUtils.hasText(refererUrl)) {
						result = 3;
					} else {
						result = 0;
					}
				}
			}
			
			return result;
		}
		
		String refererUrl = request.getHeader("REFERER");
		if(useReferer && StringUtils.hasText(refererUrl)) {
			result = 3;
		} else {
			result = 0;
		}
		
		return result;
	}
}
