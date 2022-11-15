package lims.wrk.dao;

import java.util.List;

import lims.sys.vo.MenuMVo;
import lims.wrk.vo.MenuLabelLangMVo;

public interface MenuLabelLangMDao {

	public List<MenuMVo> getLablang(MenuMVo vo);

	public List<MenuLabelLangMVo> getLabinfolang(MenuLabelLangMVo vo);

	public int savelabellang(MenuLabelLangMVo menuLabelLangMVo);

	public int uplabellang(MenuLabelLangMVo menuLabelLangMVo);

	public int delLablang(MenuLabelLangMVo menuLabelLangMVo);

}
