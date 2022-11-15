package lims.com.dao;

import java.util.List;

import lims.com.vo.LocaleVo;


public interface LocaleDao {
	
	public List<LocaleVo> getListLanguage();
	
	public List<LocaleVo> getComLggNm(LocaleVo param);
	
	public List<LocaleVo> getListMenuLggCd();
	
	public List<LocaleVo> getMenusLggNm(LocaleVo param);
	
	public List<LocaleVo> getMenuLggNm(LocaleVo param);
	
	public LocaleVo getLocale(String locale);
	
	public LocaleVo getOneLocale(LocaleVo param);
	
	public String getLocaleNm(String param);
	
	public String getBrcNm(String param);
	
}
