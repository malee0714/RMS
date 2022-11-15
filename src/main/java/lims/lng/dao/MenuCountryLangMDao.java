package lims.lng.dao;

import java.util.List;

import lims.sys.vo.MenuMVo;

public interface MenuCountryLangMDao {

	public List<MenuMVo> getMconlang(MenuMVo vo);

	public int saveMconlang(MenuMVo menuCountryLangMVo);

	public int upMconlang(MenuMVo menuMVo);

}
