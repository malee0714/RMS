package lims.util.Locale;



import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;


/**
 *	annotation aop을 이용한 locale message
 * SetLocale 어노테이션이 선언된 타겟 메소드 기준으로 실행
 */

@Aspect
public class LocaleAop {

	@Autowired
	private LocaleUtil localeUtil;
	
	@Around("@annotation(lims.util.Locale.SetLocale) && @annotation(setLocale)")
	public Object localeManager(ProceedingJoinPoint joinPoint, SetLocale setLocale){
		Object resultObj = null;
		
		try {
			//aop 타겟 메소드 실행
			resultObj = joinPoint.proceed();
			
			//prefix 파라미터 체크 (메뉴 코드)
			//세션에 locale 및 결과지 언어코드 세팅
			//localeUtil.setSessionDefaultLocale();
			
			//locale Map에서 공통 어휘들을, prefix에 해당하는 메뉴의 프로퍼티에서 메뉴별 어휘들을 JsonObject에 담아온다.
			//localeUtil.logCrrSize();
			JSONObject jsonObject = localeUtil.getMessageJsonObject();
			
	        //타겟 메소드의 Model 객체를 가져와서 어휘를 삽입
	        for(Object obj : joinPoint.getArgs()){ 
	        	if(obj instanceof Model){
	        		((Model) obj).addAttribute("msg", jsonObject); //모델 객체에 어휘 삽입
	        		break;
	        	}
	        }
		} catch (Throwable e) {
			e.printStackTrace();
		}
        return resultObj;
	}
}
