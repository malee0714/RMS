package lims.util;

import lims.com.service.CommonService;
import lims.com.vo.ErrorLogVo;
import lims.sys.vo.UserMVo;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Optional;
@ControllerAdvice
public class ExceptionControllerAdvice {
	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(Exception.class)
    public ModelAndView exception(Exception e) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	    String url = (String)httpServletRequest.getAttribute( "javax.servlet.forward.request_uri" );
	    if(url == null)
	    	url = httpServletRequest.getRequestURI();
		UserMVo UserMVo = commonFunc.getLoginUser(httpServletRequest);
		
		ErrorLogVo vo = new ErrorLogVo();
		vo.setUrl(url);
		vo.setExcpNm(e.toString());
		vo.setExcpCn(e.getMessage());
		if(UserMVo != null)
			vo.setLastChangerId(UserMVo.getUserId());
		StackTraceElement[] ste = e.getStackTrace();
		String stacktrace = "";
		for(int i = 0;i < ste.length; i++) {
			stacktrace += ste[i].toString() + "\n";
		}
		vo.setExcpTraceCn(stacktrace);
		
		commonService.insErrorLog(vo);
		e.printStackTrace();
		
		if(isAjaxRequest(httpServletRequest)) {
			ModelAndView model = new ModelAndView(new MappingJackson2JsonView());
			model.addObject("error", vo);
			return model;
		} else {
			ModelAndView model = new ModelAndView("error");
			model.addObject("error", vo);
	        return model;			
		}
    }
	
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	@ExceptionHandler(CustomException.class)
	public ModelAndView customException(CustomException e) {

		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		
		String url = (String)httpServletRequest.getAttribute( "javax.servlet.forward.request_uri" );
		if(url == null){
			url = httpServletRequest.getRequestURI();
		}

		//user info
		UserMVo userMvo = Optional
							.ofNullable(commonFunc.getLoginUser(httpServletRequest))
							.orElseGet( UserMVo::new );
			
		ErrorLogVo vo = ErrorLogVo
							.builder()
							.url(url)
							.excpNm(e.toString())
							.excpCn(e.getCause() == null ? "" : e.getCause().getMessage())
							.excpTraceCn(e.getStackTraceString())
							.dvlprDc(e.getDeveloperDc())
							.vriablCn(e.getParam())
							.lastChangerId(userMvo.getUserId())
							.build();
		
		// 예외 로그 저장
		commonService.insErrorLog(vo);
		
		if(isAjaxRequest(httpServletRequest)) {
			ModelAndView model = new ModelAndView(new MappingJackson2JsonView());
			model.addObject("error", vo);
			return model;
		} else {
			ModelAndView model = new ModelAndView("error");
			model.addObject("error", vo);
			return model;
		}
	}
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	@ExceptionHandler(CustomMessageException.class)
	public ModelAndView customMessageException(CustomMessageException e) {

		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		ErrorLogVo vo = ErrorLogVo
				.builder()
				.dvlprDc(e.getDeveloperDc())
				.build();

		if(isAjaxRequest(httpServletRequest)) {
			ModelAndView model = new ModelAndView(new MappingJackson2JsonView());
			model.addObject("error", vo);
			return model;
		} else {
			ModelAndView model = new ModelAndView("error");
			model.addObject("error", vo);
			return model;
		}
	}
    private boolean isAjaxRequest(HttpServletRequest req) {
        String ajaxHeader = "AJAX";
        return req.getHeader(ajaxHeader) != null && req.getHeader(ajaxHeader).equals(Boolean.TRUE.toString());
    }
}
