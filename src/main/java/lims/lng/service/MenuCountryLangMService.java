package lims.lng.service;

import java.util.List;

import lims.sys.vo.MenuMVo;

public interface MenuCountryLangMService {
	// 조회
	public List<MenuMVo> getMconlang(MenuMVo vo);
	//저장
	public int saveMconlang(List<MenuMVo> list, MenuMVo vo);

}
