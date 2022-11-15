package lims.util;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.sys.vo.UserMVo;

public class GetUserSession {
	
	public static UserMVo getUserVo(){
		ServletRequestAttributes attr = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
		UserMVo vo = (UserMVo) attr.getRequest().getSession(false).getAttribute("UserMVo");
		return vo;
	}
		
	/**
	 * 사용자 ID
	 * @return
	 */
	public static String getUserId(){
		return getUserVo().getUserId();
	}
	
	/**
	 * 사용자명
	 * @return
	 */
	public static String getUserNm(){
		return getUserVo().getUserNm();
	}
	
	/**
	 * 사용자 부서코드
	 * @return
	 */
	public static String getDeptCode(){
		return getUserVo().getDeptCode();
	}
	
	/**
	 * 로그인 IP
	 * @return
	 */
	public static String getLoginIp(){
		return getUserVo().getLoginIp();
	}
	
	/**
	 * 권한 구분 코드 
	 * SY09000001 : 
	 * SY09000002 : 
	 * SY09000003 : 
	 * SY09000004 : 
	 * @return
	 */
	public static String getAuthorSeCode(){
		return getUserVo().getAuthorSeCode();
	}
	
	/**
	 * 사업장 코드
	 * @return
	 */
	public static String getBestInspctInsttCode(){
		return getUserVo().getBestInspctInsttCode();
	}
	
	/**
	 * 국가 코드
	 * @return
	 */
	public static String getNationLangCode(){
		return getUserVo().getNationLangCode();
	}
	
}
