package lims.lng.service;

import java.util.List;

import lims.lng.vo.DefaultLangMVo;

public interface DefaultLangMService {
	//조회
	public List<DefaultLangMVo> getDelang(DefaultLangMVo vo);
	//저장
	public int saveDelang(List<DefaultLangMVo> list);
	//중복체크
	public int langNmChk(DefaultLangMVo vo);
	//삭제
	public int delDelang(List<DefaultLangMVo> list);

}
