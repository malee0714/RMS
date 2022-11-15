package lims.util;

import lims.com.service.CommonService;
import lims.com.service.SmMenuService;
import lims.sys.vo.CmmnCodeMVo;
import lims.sys.vo.MenuMVo;
import lims.sys.vo.UserMVo;
import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.PreparerException;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class MenuPreparer implements ViewPreparer {

	@Resource(name = "smMenuServiceImpl")
	private SmMenuService smMenuService;

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Resource(name ="commonServiceImpl")
	private CommonService commonService;

	@Override
	public void execute(Request context, AttributeContext attributeContext) throws PreparerException {

		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	    HttpSession session = httpServletRequest.getSession();
		String menuUrl = (String)httpServletRequest.getAttribute( "javax.servlet.forward.request_uri" );
		
	    MenuMVo urlMenu = new MenuMVo();
		MenuMVo	currentMenu = null;
		List<MenuMVo> leftMenu = null;
		
		// 화면 URL에 붙은 파라미터 값 가져옴 (게시판, 북마크)
		String board = httpServletRequest.getParameter("board");
		String bkmkUrlParam = httpServletRequest.getParameter("bookmark");
		
		// 로그인 사용자의 세션값으로 사용자정보 조회
		UserMVo UserMVo = commonFunc.getLoginUser(httpServletRequest);
	    urlMenu.setLangCode(UserMVo.getNationLangCode());
		urlMenu.setUserId(UserMVo.getUserId());

		CmmnCodeMVo cmmnCodeMVo = new CmmnCodeMVo();
		GetUserSession getUserSession = new GetUserSession();
		
		// 게시판 화면에 접근하는 경우엔 url 파라미터 세팅
	    if(!commonFunc.isEmpty(board)) {
			urlMenu.setMenuUrl(menuUrl+"?board="+board);
		} else {
			urlMenu.setMenuUrl(menuUrl);
		}
		
		// URL에 북마크 파라미터가 있으면 북마크메뉴 계층조회 (1row)
		if (!commonFunc.isEmpty(bkmkUrlParam)) {
			currentMenu = smMenuService.getBkmkMenuByUrl(urlMenu);
		} else {
			currentMenu = smMenuService.getMenuByUrl(urlMenu);
		}

		// Audit 여부 조회
		String auditAt = commonService.getAuditAt(cmmnCodeMVo);
		
		/**
		 * 로그인 한 계정의 권한이 [고객사 - SY09000004]일 경우
		 * auditAt를 Y로 설정하여
		 * 고객사 공개여부가 Y인 메뉴만 불러오도록 처리
		 */
		if (getUserSession.getAuthorSeCode().equals("SY09000004")) {
			auditAt = "Y";
		}

		MenuMVo menu1 = new MenuMVo();
	    menu1.setMenuUrl(menuUrl);
	    menu1.setUserId(UserMVo.getUserId());
	    menu1.setAuditAt(auditAt);
		menu1.setLangCode(UserMVo.getNationLangCode());
		
	    if (currentMenu != null) {
			menu1.setMenuSeqno(currentMenu.getMenuCd2());

			// URL에 북마크 파라미터가 있으면 북마크전용 사이드메뉴 조회
			if (!commonFunc.isEmpty(bkmkUrlParam)) {
				leftMenu = smMenuService.getBkmkLeftMenu(menu1);
			} else {
				leftMenu = smMenuService.getLeftMenu(menu1);
			}
	    }

	    List<MenuMVo> topMenu = smMenuService.getTopMenu(menu1);

		// 홈 화면엔 사용되지 않는 메뉴리스트들이므로 빈 객체를 할당
	    if (currentMenu == null) {
			currentMenu = new MenuMVo();
		}

	    if (leftMenu == null) {
			leftMenu = new ArrayList<MenuMVo>();
		}

		// 메뉴 접근이력 등록
	    urlMenu.setUserId(UserMVo.getUserId());
	    urlMenu.setMenuSeqno(currentMenu.getMenuCd4());
	    smMenuService.instMenuHist(urlMenu);
		
		// JSP에서 사용될 속성 추가
		attributeContext.putAttribute("topMenu", new Attribute(topMenu), true);
		attributeContext.putAttribute("leftMenu", new Attribute(leftMenu), true);
		attributeContext.putAttribute("currentMenu", new Attribute(currentMenu), true);
		session.setAttribute("menuCd", currentMenu.getMenuCd4());
		session.setAttribute("reqUrl", menuUrl);
		System.out.println("topMenu ======== " + topMenu);
		System.out.println("currentMenu.getMenuCd2 ======== " + currentMenu.getMenuCd2());
	}

}
