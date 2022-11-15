package lims.util;

import lims.com.service.CommonService;
import lims.com.vo.AuditVo;
import lims.sys.vo.UserMVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
public class CommonFunc {
	@Resource(name = "commonServiceImpl")
	private CommonService commonService;

	public UserMVo getLoginUser(HttpServletRequest request) {
		if(request.getSession(false) == null || request.getSession(false).getAttribute("UserMVo") == null ){
			System.out.println(">>> SESSION NULL : " + request.getSession(false));
			return null;
		}
		return (UserMVo)request.getSession(false).getAttribute("UserMVo");
	}

	public String getRequestUrl(HttpServletRequest request) {
		String url = (String)request.getSession(false).getAttribute("reqUrl");
	    return url;
	}

	public String getRequestMenuCd(HttpServletRequest request) {
		String menuCd = (String)request.getSession(false).getAttribute("menuCd");
	    return menuCd;
	}
	
	/**
     * 빈문자열 체크 + Objects Class를 이용한 null체크
     * Collection, Array, String 전부다 가능
     * @author shs
     * @param object
     * @return
     */
	public boolean isEmpty(Object object) {

		// 빈문자열 제크
        if ( object instanceof String ) {
            String str = (String) object;
            return str.length() == 0;
        }

        // Collection size 체크
        if ( object instanceof Collection ) {
			@SuppressWarnings("rawtypes")
			Collection collection = (Collection) object;
            return collection.size() == 0;
        }

        // Array lenth 체크
        if ( object instanceof Object[] ) {
        	return Array.getLength(object) == 0;
        }

        // 기타 나머지 체크
        return Objects.isNull(object);
    }
	
	public void auditTrail(String histSeCode, String processNm, String reqestSeqno, String reqestExpriemSeqno, String expriemSeqno, String exprOdr, String bplcCode, String anykey1, String anykey2, String anykey3){
		//AUDIT TRAIL ----------------------------------------------------------------------
		AuditVo auditvo = AuditVo.builder()
								.histSeCode(histSeCode)
								.processNm(processNm)
								.key1(Arrays.asList(reqestSeqno, reqestExpriemSeqno, expriemSeqno, exprOdr, anykey1, anykey2, anykey3, bplcCode)
										.stream()
										.filter(x -> x != null && !x.equals(""))
										.collect(Collectors.joining("|")))
								.reqestSeqno(reqestSeqno)
								.expriemSeqno(expriemSeqno)
								.exprOdr(exprOdr)
								.bplcCode(bplcCode)
								.build();

		int check = commonService.insertAudit(auditvo);
		if(check==0){TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();}
		//AUDIT TRAIL ----------------------------------------------------------------------
	}
	

	/**
	 * request객체에서 parameter를 Map으로 변환하여 return
	 * @author google
	 * @param request
	 * @return Map
	 */
	public Map<String, Object> getParameterMap(HttpServletRequest request) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		Enumeration<String> paramNames = request.getParameterNames();

		while(paramNames.hasMoreElements()) {
			String name	= paramNames.nextElement().toString();
			String value = request.getParameter(name);
			paramMap.put(name, value);
		}
		return paramMap;
	}
}
