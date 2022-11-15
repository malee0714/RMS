package lims.com.dao;

import lims.sys.vo.MenuMVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SmMenuDao {
	List<MenuMVo> getTopMenu(MenuMVo param);
	List<MenuMVo> getLeftMenu(MenuMVo param);
	List<MenuMVo> getBkmkLeftMenu(MenuMVo param);
	MenuMVo getMenuByUrl(MenuMVo param);
	MenuMVo getBkmkMenuByUrl(MenuMVo param);
	int instMenuHist(MenuMVo param);

}
