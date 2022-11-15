package lims.util.Locale;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * annotation
 * 용법 : 페이지 호출 메소드(인자로 Model이 선언되어 있어야 함)에 선언하고 prefix=메뉴코드를 지정
 * 결과 : 공통 언어(알림, 버튼, 팝업 어휘, 메인)와 지정한 메뉴코드에 해당하는 어휘를 Model 객체에 담음
 * LocaleAop 참고
 */
@Retention(RetentionPolicy.RUNTIME)
public @interface SetLocale {
}
