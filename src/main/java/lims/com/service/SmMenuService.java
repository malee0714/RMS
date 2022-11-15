package lims.com.service;

import lims.sys.vo.MenuMVo;

import java.util.List;

public interface SmMenuService {
	List<MenuMVo> getTopMenu(MenuMVo param);
	List<MenuMVo> getLeftMenu(MenuMVo param);
	List<MenuMVo> getBkmkLeftMenu(MenuMVo param);
	MenuMVo getMenuByUrl(MenuMVo param);
	MenuMVo getBkmkMenuByUrl(MenuMVo param);
	int instMenuHist(MenuMVo param);

}
