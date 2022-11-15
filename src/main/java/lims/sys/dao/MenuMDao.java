package lims.sys.dao;

import lims.sys.vo.AuthMVo;
import lims.sys.vo.MenuMVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MenuMDao {

	List<MenuMVo> getMeuMList(MenuMVo vo);

	int insMeuLv(MenuMVo vo);

	int updMenuM(MenuMVo vo);

	int delMeuM(MenuMVo vo);

	List<MenuMVo> getHirMenuList(MenuMVo vo);

	List<MenuMVo> getMenuLvList(MenuMVo vo);

	List<MenuMVo> getMenuOneList(MenuMVo vo);

	List<MenuMVo> getMenuTwoList(MenuMVo vo);

	int insManual(MenuMVo vo);

	List<AuthMVo> getSchAuth(AuthMVo vo);

	MenuMVo getEditorData(MenuMVo vo);
	
	MenuMVo getMenuSeqno(MenuMVo vo);

	int chkBookMarkRegistred(MenuMVo vo);

	int insMenuBookMark(MenuMVo vo);

	int delMenuBookMark(MenuMVo vo);

}
