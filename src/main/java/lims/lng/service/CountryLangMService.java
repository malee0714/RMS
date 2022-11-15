package lims.lng.service;

import java.util.List;

import lims.lng.vo.CountryLangMVo;
import lims.lng.vo.DefaultLangMVo;

public interface CountryLangMService {
	//조회
	public List<CountryLangMVo> getConlang(CountryLangMVo vo);
	//저장
	public int saveConlang(List<CountryLangMVo> list, CountryLangMVo vo);
	//중복값
	public int conlangChk(CountryLangMVo vo);
	//삭제
	public int delConlang(List<DefaultLangMVo> list);

}
