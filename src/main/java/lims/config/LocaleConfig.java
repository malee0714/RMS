package lims.config;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import lims.com.dao.LocaleDao;
import lims.com.vo.LocaleVo;
import lims.util.Locale.LocaleUtil;

@Configuration
public class LocaleConfig {
	
	@Autowired
	private LocaleUtil localeUtil;

	@Autowired
	private LocaleDao localDao;
	
	//메시지 프로퍼티가 생성될 경로 설정
	private final String MESSAGE_PROPERTIES_PATH = LocaleConfig.class.getClassLoader().getResource("").getPath()  + "property";
	
	@Bean
	public int initLocaleConfig(){
		
		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		//System.out.println(MESSAGE_PROPERTIES_PATH);
		try{
			//System.out.println("LocaleConfig initLocaleConfig");
			File dir = new File(MESSAGE_PROPERTIES_PATH);
			
			//기존 프로퍼티 폴더가 있다면 삭제
			if(dir.exists())
				dir.delete();
			
			//언어별 프로퍼티를 넣을 디렉토리 생성
			dir.mkdir();
			
			//디비에 저장된 언어 종류 목록 가져오기
			List<LocaleVo> languages = localDao.getListLanguage();
			
			//국가별 메뉴 어휘 프로퍼티 생성
			for(LocaleVo vo : languages){
				//국가 폴더 생성 
				String propertyPath = localeUtil.mkDir(MESSAGE_PROPERTIES_PATH, vo.getLangValue()); //ex 대한민국

				//메뉴 폴더 생성
				String menuPropertyPath = localeUtil.mkDir(propertyPath, localeUtil.STATIC_LOCALE_CTG_MENU_STR); // ex 대한민국 폴더안 menu 생성
				//메뉴별 어휘 파일 생성 및 프로퍼티 세팅
				//localeUtil.initMenuProperties(vo.getLangCd(), menuPropertyPath);

				localeUtil.initMenuProperties(vo.getCmmnCode(), menuPropertyPath); //대한민국  SY06000001

				//생성한 프로퍼티 경로 저장
				localeUtil.setPropertyPathMap(vo.getCmmnCode(), propertyPath); //대한민국  SY06000001
				
			}
			//국가별 메뉴 어휘 프로퍼티 생성 끝
			
			//공통어휘를 Map 객체에 저장
			localeUtil.initMessageToJsonObject();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return 0;
	}
	
}