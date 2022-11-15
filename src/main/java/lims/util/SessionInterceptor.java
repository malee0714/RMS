package lims.util;

import lims.com.service.LoginMService;
import lims.sys.service.CmmnCodeMService;
import lims.sys.vo.MenuMVo;
import lims.sys.vo.UserMVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
public class SessionInterceptor extends HandlerInterceptorAdapter {

	@Resource(name = "loginMServiceImpl")
	private LoginMService loginMService;

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Resource(name ="cmmnCodeMServiceImpl")
	private CmmnCodeMService cmmnCodeMService;

	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	try {
    		
    		/*
    		 * 
    		 * 2021-06-28
    		 * 
    		 * audit여부가 필요한 화면만 적용되도록 할꺼여서 주석처리함
    		 *
    		CmmnCodeMVo cmmnCodemVo =new CmmnCodeMVo();
    		//audit 여부
    		String auditAt = cmmnCodeMService.getAuditAt(cmmnCodemVo);
    		GetUserSession getUserSession = new GetUserSession();
    		if(getUserSession.getAuthorSeCode().equals("SY09000003") || getUserSession.getAuthorSeCode().equals("SY09000004")){
    			auditAt = "Y";
    		}
    		request.getSession(true).setAttribute("auditAt", auditAt);
    		*/

			/**
			 * 사용자 신규 등록 팝업에서 서버에 요청할 때 시큐리티 우회하도록 설정
			 */
    		if ("/isu/getBplcCode.lims".equals(request.getRequestURI())
    				|| "/isu/getDeptCode.lims".equals(request.getRequestURI())
    				|| "/isu/insUserJoin.lims".equals(request.getRequestURI())
    				|| "/isu/getCmmnCode.lims".equals(request.getRequestURI())
					|| "/isu/getPasswordPolicyString.lims".equals(request.getRequestURI())
					|| "/isu/getOfcpsAndClsfCode.lims".equals(request.getRequestURI())) {
				return true;
			}

			if (request.getRequestURL().toString().indexOf("/chart") != -1) {
				String url = request.getRequestURI();
//    			    request.getSession(false).setAttribute("reqUrl", url);
			} else if(request.getRequestURL().toString().indexOf("/dly") != -1) {
				String url = request.getRequestURI();
			} else if(request.getRequestURL().toString().indexOf("/loginMhrls") != -1) {
				String url = request.getRequestURI();
				request.getSession(false).setAttribute("reqUrl", url);
			} else if (request.getRequestURL().toString().indexOf("/getRdmsResultData") != -1) {
				String url = request.getRequestURI();
//    			    request.getSession(false).setAttribute("reqUrl", url);
				return true;
			} else if (request.getRequestURL().toString().indexOf("/delBinderChck") != -1) {
				String url = request.getRequestURI();
//    			    request.getSession(false).setAttribute("reqUrl", url);
				return true;
			} else {
				// UserMVo 세션값이 null인 경우
				if (request.getSession(true) == null || request.getSession(true).getAttribute("UserMVo") == null) {
					// Ajax 콜인지 아닌지 판단
					if (isAjaxRequest(request)) {
						response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
					} else {
						String requestUri = "";

						// http 요청에 쿼리스트링이 포함된 경우, 로그인 후 이동할 url에 쿼리스트링을 붙여 해당 세션에 저장
						if (request.getQueryString() == null) {
							requestUri = request.getRequestURI();
						} else {
							requestUri = request.getRequestURI() + "?" + request.getQueryString();
						}
 						request.getSession(false).setAttribute("targetUrl", requestUri);

						// 로그인 화면으로 redirect
						response.sendRedirect("/login.lims");
					}

					return false;
				}

				String url = request.getRequestURI();

				// 화면 호출 시
				if(request.getHeader("Content-Type") == null
						&& (!"/sys/dragDropDownloadAction.lims".equals(request.getRequestURI())
						&& !"/sys/dragDropGetImage.lims".equals(request.getRequestURI())
						&& !"/com/excelDownload.lims".equals(request.getRequestURI())
						&& !"/test/ResultInputP01.lims".equals(request.getRequestURI())
						&& !"/test/getExpriemXls.lims".equals(request.getRequestURI())
						&& !"/test/getCoaVrifyAt2.lims".equals(request.getRequestURI())
						&& !"/rsc/ChartM.lims".equals(request.getRequestURI())
						&& !"/src/QCConditionChartM.lims".equals(request.getRequestURI())
						&& !"/dly/brcdValidM.lims".equals(request.getRequestURI())
						&& !"/sys/MenuHelpP.lims".equals(request.getRequestURI())
						&& !"/test/getExpriemDownload.lims".equals(request.getRequestURI())
						&& !"/src/PedigeeP01.lims".equals(request.getRequestURI())
						&& !"/imminentNotifyP01.lims".equals(request.getRequestURI())
						&& !"/wrk/getExDownload.lims".equals(request.getRequestURI())
						&& !"/wrk/getCoaDownload.lims".equals(request.getRequestURI())
						&& !"/rsc/ChartDailyCheckM.lims".equals(request.getRequestURI())
						&& !"/wrk/getRdDownload.lims".equals(request.getRequestURI())
						&& !"/test/getSampleRoaDownload.lims".equals(request.getRequestURI())
						&& !"/test/getSampleLotTraceDownload.lims".equals(request.getRequestURI()))
						&& !"/test/excelDownload.lims".equals(request.getRequestURI())
						&& !"/test/pblicateCoaExcelDownload.lims".equals(request.getRequestURI())) {

					UserMVo UserMVo = commonFunc.getLoginUser(request);
					MenuMVo menu = new MenuMVo();

					// 게시판 파마미터값 할당
					String board = request.getParameter("board");
					String menuSeqno = request.getParameter("menuSeqno");

					if (board != null && board != "") { // 게시판 파라미터가 있을 경우
						menu.setMenuUrl(url+"?board="+board);
					} else { // 일반 페이지
						menu.setMenuUrl(url);
					}

					menu.setUserId(UserMVo.getUserId());

					// 사용자의 메뉴 접근권한 체크
					int menuLen = loginMService.getChkAthMenu(menu);
					if (menuLen == 0 && !url.equals("/main.lims")) {
						response.sendRedirect("/main.lims");
					} else {
						request.getSession(false).setAttribute("reqUrl", url);
						request.getSession(false).setAttribute("menuSeqno", menuSeqno);
					}
				}
			}
    	} catch (Exception e) {
    		e.printStackTrace();
   		}
    	return true;
    }

	@Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView model) throws Exception {
		return;
	}
	
    private boolean isAjaxRequest(HttpServletRequest req) {
        String ajaxHeader = "AJAX";

        return req.getHeader(ajaxHeader) != null && req.getHeader(ajaxHeader).equals(Boolean.TRUE.toString());
    }
}
