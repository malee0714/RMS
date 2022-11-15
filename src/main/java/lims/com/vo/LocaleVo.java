package lims.com.vo;

public class LocaleVo {
	
/*	String comCd; // 접속이력 idx
	String lblCd; // 접속구분IO_I로그인O로그아웃
	int lggIdx; // 접속아이디
	String lggNm;	//언어명
	String udtId;	//접속일시
	String udtDate;	//ip
	String dftNm;	//비고
	String glgCtgCd;	//언어구분코드
	String menuCd;
	String ctg;
	String lang;
	String langCd; //언어의 코드값 ex)sy06
	String langNm; //언어명
	String langValue;
	String locale;
	String prtLggCd;
	String prtLggNm;*/
	
	//솔브레인 적용
	String locale;		// 세션에 국가코드 담음(SY06000001 ~
	String cmmnCode;	// 국가코드(SY06000001 ~
	String cmmnCodeNm;	// 국가코드명(대한민국,영어)
	String langValue;	// 국가코드 약어(KOR.USA)
	String langCode;	// 기본언어명 (mastr) 키값 C000000001 ~
	String prtLggCd;	// 얜 뭐라해야하
	String prtLggNm;	// 얘도 뭐라해야하나
	String langUage; 	// MASTR / DETAIL 기본 언어
	

	public String getCmmnCodeNm() {
		return cmmnCodeNm;
	}
	public void setCmmnCodeNm(String cmmnCodeNm) {
		this.cmmnCodeNm = cmmnCodeNm;
	}
	public String getLangUage() {
		return langUage;
	}
	public void setLangUage(String langUage) {
		this.langUage = langUage;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
	public String getCmmnCode() {
		return cmmnCode;
	}
	public void setCmmnCode(String cmmnCode) {
		this.cmmnCode = cmmnCode;
	}
	public String getLangValue() {
		return langValue;
	}
	public void setLangValue(String langValue) {
		this.langValue = langValue;
	}
	public String getLangCode() {
		return langCode;
	}
	public void setLangCode(String langCode) {
		this.langCode = langCode;
	}
	public String getPrtLggCd() {
		return prtLggCd;
	}
	public void setPrtLggCd(String prtLggCd) {
		this.prtLggCd = prtLggCd;
	}
	public String getPrtLggNm() {
		return prtLggNm;
	}
	public void setPrtLggNm(String prtLggNm) {
		this.prtLggNm = prtLggNm;
	}
	
	
	
}
