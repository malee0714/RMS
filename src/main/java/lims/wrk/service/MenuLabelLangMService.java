package lims.wrk.service;

import java.util.List;

import lims.sys.vo.MenuMVo;
import lims.wrk.vo.MenuLabelLangMVo;

public interface MenuLabelLangMService {
	//조회
	public List<MenuMVo> getLablang(MenuMVo vo);

	public List<MenuLabelLangMVo> getLabinfolang(MenuLabelLangMVo vo);
	//저장
	public int savelabellang(List<MenuLabelLangMVo> list);
	
	//삭제
	public int delLablang(List<MenuLabelLangMVo> list);

}
