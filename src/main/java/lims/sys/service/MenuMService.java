package lims.sys.service;

import lims.sys.vo.AuthMVo;
import lims.sys.vo.MenuMVo;

import java.util.List;

public interface MenuMService {

	List<MenuMVo> getMenuMList(MenuMVo vo);

	List<MenuMVo> getHirMenuList(MenuMVo vo);

	List<MenuMVo> getMenuLvList(MenuMVo vo);

	List<MenuMVo> getMenuOneList(MenuMVo vo);

	List<MenuMVo> getMenuTwoList(MenuMVo vo);

	int insMenuM(MenuMVo vo);

	int updMenuM(MenuMVo vo);

	int delMenuM(List<MenuMVo> list);

	int insManual(MenuMVo vo);

	List<AuthMVo> getSchAuth(AuthMVo vo);

	MenuMVo getEditorData(MenuMVo vo);

	MenuMVo getMenuSeqno(MenuMVo vo);

	int chkBookMarkRegistred(MenuMVo vo);

	MenuMVo bookMarkControl(MenuMVo vo);

}
