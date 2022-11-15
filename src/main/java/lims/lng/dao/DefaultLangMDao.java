package lims.lng.dao;

import java.util.List;

import lims.lng.vo.DefaultLangMVo;

public interface DefaultLangMDao {

	public List<DefaultLangMVo> getDelang(DefaultLangMVo vo);

	public int saveDelang(DefaultLangMVo defaultLangMVo);

	public int upDelang(DefaultLangMVo defaultLangMVo);

	public int langNmChk(DefaultLangMVo vo);

	public int delDelang(DefaultLangMVo defaultLangMVo);

}
