package lims.lng.dao;

import java.util.List;

import lims.lng.vo.CountryLangMVo;
import lims.lng.vo.DefaultLangMVo;


public interface CountryLangMDao {

	public List<CountryLangMVo> getConlang(CountryLangMVo vo);

	public int saveConlang(CountryLangMVo countryLangMVo);

	public int conlangChk(CountryLangMVo vo);

	public int upConlang(CountryLangMVo countryLangMVo);

	public int delConlang(DefaultLangMVo defaultLangMVo);
	
}
