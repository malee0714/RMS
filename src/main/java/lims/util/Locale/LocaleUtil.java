package lims.util.Locale;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.com.dao.LocaleDao;
import lims.com.vo.LocaleVo;


@Service
@PropertySource(ignoreResourceNotFound = true, value="classpath:locale.properties")
public class LocaleUtil {
	
	@Value("${server}")
	private String server;
	
	@Autowired
	private LocaleDao localDao;
	
	public final String STATIC_LOCALE_CTG_MENU_STR = "MENU";
	
	//어플리케이션 구동 시 언어별 공통어휘가 할당되는 Map 객체
	private Map<String, JSONObject> commonMessageMap = new HashMap<String, JSONObject>();
	
	//프로퍼티 경로가 저장되는 Map 객체
	private Map<String, String> propertyPathMap = new HashMap<String, String>();
	
	
	public HttpSession getSession(){
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes(); 
		HttpSession httpSession = servletRequestAttribute.getRequest().getSession(true);
		return httpSession;
	}
	
	/**
	 * @return 로그인 및 세션 설정에서 세팅된 세션 locale
	 */
	public String getSessionLocale(){
		//비로그인 검증 시 다국어 사용하려고 임의로 세션에 대한민국 값 넣음
		if(getSession().getAttribute("locale") == null || getSession().getAttribute("locale") == "") {
			getSession().setAttribute("locale", "SY06000001");
		}
		return String.valueOf(getSession().getAttribute("locale"));
		
	}
	
	/**
	 * 세션에 locale값이 없다면 영문을 default값으로
	 */
	public void setSessionDefaultLocale(){
		HttpSession session = getSession();
		String langCd = String.valueOf(session.getAttribute("locale"));
	
		if(null == langCd || "".equals(langCd) || "null".equals(langCd))
			this.setSessionLocale(session, "SY06000001");
		
		session.setAttribute("server", this.server); //JSP 헤더의 지역별 로고 및 문구용 플래그값
	}
	
	/**
	 * 세션에 locale 세팅
	 */
	public void setSessionLocale(HttpSession session, String locale){
		LocaleVo vo = localDao.getLocale(locale);
		session.setAttribute("locale", vo.getCmmnCode());
//		session.setAttribute("prtLggCd", vo.getPrtLggCd()); //결과지 언어코드
//		session.setAttribute("prtLggNm", vo.getPrtLggNm()); //결과지 언어명
	}
	
	/**
	 * meesageMap에서 현재 세션의 언어설정에 맞는 공통 어휘를 가져와 세팅
	 * prefix(메뉴 코드)와 동일한 이름의 프로퍼티 파일에서 어휘를 가져와 세팅
	 * @return 위 두 가지의 어휘를 담은 JSONObject
	 */
	public JSONObject getMessageJsonObject(){
		//String locale = getSessionLocale();
		//세션 언어에 맞는 공통 어휘를 세팅
		//JSONObject jsonObject = commonMessageMap.get(locale);
		//System.out.println("로컬확인>>>>>>>>>>"+locale);

		//if(null != prefix && !prefix.equals(""))
		JSONObject jsonObject = setMenuPropertyToJsonObject();
		
		return jsonObject;
	}
	
	/**
	 * 코드를 인자로 넘겨 해당 코드에 맞는 어휘를 가져옴 (메시지, 버튼)
	 * @return 인자로 넘긴 코드에 해당하는 어휘
	 */
	public String getOneMessage(String locale, String lblCd){
		return (String) commonMessageMap.get(locale).get(lblCd);
	}
	
	public void logCrrSize(){
		String locale = getSessionLocale();
		System.out.println("ㅡㅡㅡㅡㅡㅡㅡㅡㅡ" + this.commonMessageMap.size());
		//세션 언어에 맞는 공통 어휘를 세팅
		JSONObject jsonObject = commonMessageMap.get(locale);
		System.out.println("ㅡㅡㅡㅡㅡㅡㅡㅡㅡ" + jsonObject);
	}
	
	
	/**
	 * 공통 어휘를 commonMessageMap에 저장
	 */
	public void initMessageToJsonObject(){
		commonMessageMap.clear();

		List<LocaleVo> commonList = null;
		List<LocaleVo> msgList = null;
		List<LocaleVo> btnList = null;
		List<LocaleVo> popList = null;
		List<LocaleVo> mainList = null;
		JSONObject jsonObject = null;
		
		List<LocaleVo> localeCategories = localDao.getListLanguage();
		
	/*	LocaleVo category = new LocaleVo();
		commonList = localDao.getComLggNm(category);
		msgList = new ArrayList<LocaleVo>();
		jsonObject = new JSONObject();
		jsonObject = setCommonMessageToJsonObject(jsonObject, commonList);
		commonMessageMap.put(category.getLangCd(), jsonObject);*/
		
	/*	for(LocaleVo category : localeCategories){
			commonList = localDao.getComLggNm(category);
			
			msgList = new ArrayList<LocaleVo>();
			btnList = new ArrayList<LocaleVo>();
			popList = new ArrayList<LocaleVo>();
			mainList = new ArrayList<LocaleVo>();
			
			for(LocaleVo vo : commonList){
				if(vo.getComCd().indexOf("MSG") != -1)
					msgList.add(vo);
				
				if(vo.getComCd().indexOf("BTN") != -1)
					btnList.add(vo);
					
				if(vo.getComCd().indexOf("PPP") != -1)
					popList.add(vo);
				
				if(vo.getComCd().indexOf("MAIN") != -1)
					mainList.add(vo);
			}
			
			jsonObject = new JSONObject();
			jsonObject = setCommonMessageToJsonObject(jsonObject, msgList);
			jsonObject = setCommonMessageToJsonObject(jsonObject, btnList);
			jsonObject = setCommonMessageToJsonObject(jsonObject, mainList);
			jsonObject = setPopupMessageToJsonObject(jsonObject, popList);

			commonMessageMap.put(category.getLangCd(), jsonObject);
		}*/
		
	}
	
	/**
	 * 공통 어휘 단일 데이터 갱신
	 */
	@SuppressWarnings("unchecked")
	public void updateCommonMessage(String langCd, String comCd, String lblCd){
/*		JSONObject jsonObject = commonMessageMap.get(langCd);
		LocaleVo param = new LocaleVo();
		param.setLangCd(langCd);
		param.setComCd(comCd);
		param.setLblCd(lblCd);
		LocaleVo vo = localDao.getOneLocale(param);
		
		//팝업 어휘를 수정한다면
		if(comCd.indexOf("PPP") != -1){
			JSONObject comJsonObject = (JSONObject) jsonObject.get(comCd);
			comJsonObject.put(lblCd, vo.getLggNm());
			jsonObject.put(comCd, comJsonObject);
			commonMessageMap.put(langCd, jsonObject);
		}
		//버튼 혹은 메세지를 수정한다면
		else{
			jsonObject.put(lblCd, vo.getLggNm());
			commonMessageMap.put(langCd, jsonObject);
		}*/
		
	}
	
	/**
	 * 공통 메세지, 버튼, 메인 어휘를 인자로 받은 JsonObject에 담아 리턴
	 */
	@SuppressWarnings("unchecked")
	public JSONObject setCommonMessageToJsonObject(JSONObject jsonObject, List<LocaleVo> list){
		LocaleVo vo = new LocaleVo();
		jsonObject.put(vo.getLangCode(), vo.getLangUage());
/*		for(LocaleVo vo : list){
			jsonObject.put(vo.getLblCd(), vo.getLggNm());
		}*/
		return jsonObject;
	}
	
	/**
	 * 공통 팝업 어휘를 인자로 받은 JsonObject에 담아 리턴
	 */
	@SuppressWarnings("unchecked")
	public JSONObject setPopupMessageToJsonObject(JSONObject jsonObject, List<LocaleVo> list){
/*		String preKey = null;
		JSONObject tempJsonObject = new JSONObject();
		
		for(int i=0; i<list.size(); i++){
			LocaleVo vo = list.get(i);
			String key = vo.getComCd();
			
			if(preKey == null)
				preKey = key;
			
			if(!preKey.equals(key)){
				jsonObject.put(preKey, tempJsonObject);
				
				preKey = key;
				tempJsonObject = new JSONObject();
			}
			
			tempJsonObject.put(vo.getLblCd(), vo.getLggNm());
			
			if(i==list.size()-1)
				jsonObject.put(preKey, tempJsonObject);
			
		}
		*/
		return jsonObject;
	}
	
	
	/**
	 * 언어별로 어휘 프로퍼티 경로 저장
	 */
	public void setPropertyPathMap(String langCd, String path){
		propertyPathMap.put(langCd, path);
	}
	
	/**
	 * 인자로 받은 JsonObject에 인자로 받은 메뉴코드의 어휘 데이터를 세팅한 뒤 리턴
	 */
	@SuppressWarnings("unchecked")
	private JSONObject setMenuPropertyToJsonObject(){
		JSONObject jsonObject = new JSONObject();
		try {
			String langCd = getSessionLocale();
			//세팅할 메뉴 프로퍼티가 존재하는 폴더 위치를 가져옴
			String propertyPath = addPath(propertyPathMap.get(langCd), STATIC_LOCALE_CTG_MENU_STR);
			//메뉴 프로퍼티 파일 위치를 가져옴
			String menuPropertyPath = addPath(propertyPath, langCd);
			
			//메뉴 프로퍼티 객체를 가져옴
			PropertiesConfiguration props = new PropertiesConfiguration(menuPropertyPath);
			//해당 객체의 property를 map에 담는다.
			for( Iterator<String> itr = props.getKeys(); itr.hasNext(); ){
				String key = itr.next(); 
				jsonObject.put(key, props.getProperty(key));
			}
		
		} catch (ConfigurationException e) {
			e.printStackTrace();
		}
		
		return jsonObject;
	}
	
	/**
	 * 메뉴별 어휘 프로퍼티에 어휘 저장
	 */
	public void initMenuProperties(String langCd, String path){
		
		try {
			//언어코드(langCd)에 해당하는 메뉴별 어휘 목록 가져오기
			LocaleVo param = new LocaleVo();
			param.setLocale(langCd);
			List<LocaleVo> msgList = localDao.getMenusLggNm(param); //메뉴별 선택언어 명 1.시험 2. a01 3. abcㅊ(처리기한)
			String filePath = mkFile(path, langCd); // 얘가 파일이름 ex sy01,02
			PropertiesConfiguration props = new PropertiesConfiguration(filePath);
			for(LocaleVo msg : msgList){ // 언어명을 돌린다
				//메뉴 프로퍼티 파일 객체 생성
				props.setProperty(msg.getLangCode(), msg.getLangUage());
			}
			props.save();
		} catch (ConfigurationException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 모든 언어 프로퍼티 갱신
	 */
	public void updateMenuProperties(){
		List<LocaleVo> languages = localDao.getListLanguage();
		
		for(LocaleVo vo : languages){
			String propertyPath = addPath(propertyPathMap.get(vo.getLangCode()), STATIC_LOCALE_CTG_MENU_STR);
			initMenuProperties(vo.getLangCode(), propertyPath);
		}
	}

	/**
	 * 단일 언어 프로퍼티 갱신
	 */
	public void updateMenuMessage(String langCd){
		try{
			String propertyPath = addPath(propertyPathMap.get(langCd), STATIC_LOCALE_CTG_MENU_STR);
			LocaleVo param = new LocaleVo();
			param.setLocale(langCd);
			//param.setMenuCd(menuCd);
			List<LocaleVo> msgList = localDao.getMenusLggNm(param);
				
			//메뉴 프로퍼티 파일 객체 생성
			String filePath = mkFile(propertyPath, langCd);
			PropertiesConfiguration props = new PropertiesConfiguration(filePath);
			
			//가져온 어휘로 property 작성
			for(LocaleVo msg : msgList){
				//현재 세팅중인 메뉴 프로퍼티와 동일한 메뉴의 어휘를 작성
				//props.setProperty(msg.getLblCd(), msg.getLggNm());
				props.setProperty(msg.getLangCode(), msg.getLangUage());
			}
			
			//프로퍼티 저장
			props.save();
			
		} catch (ConfigurationException e) {
			e.printStackTrace();
		}
		
	}
	
	public String addPath(String path1, String path2){
		return path1 + File.separator + path2;
	}
	
	/**
	 * 인자로 받은 경로에 폴더 생성
	 * 	@return 생성한 폴더의 경로
	 */
	public String mkDir(String path1, String path2){
		String path = addPath(path1, path2);
		File file = new File(path);
		file.mkdir();
		
		return path;
	}
	
	/**
	 * 인자로 받은 경로에 파일 생성
	 * @return 생성한 파일의 경로
	 */
	public String mkFile(String path1, String path2){
		String path = addPath(path1, path2);
		File file = new File(path);

		try {
			file.createNewFile();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return path;
	}
	
}
