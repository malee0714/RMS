package lims.lng.service;

import java.util.List;

import lims.sys.vo.MenuMVo;

public interface MenuCountryLangMService {
	// ์กฐํ
	public List<MenuMVo> getMconlang(MenuMVo vo);
	//์ ์ฅ
	public int saveMconlang(List<MenuMVo> list, MenuMVo vo);

}
