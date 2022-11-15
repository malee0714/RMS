package lims.com.service.impl;

import lims.com.dao.SmMenuDao;
import lims.com.service.SmMenuService;
import lims.sys.vo.MenuMVo;
import lims.util.CommonFunc;
import lims.util.Locale.LocaleUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class SmMenuServiceImpl implements SmMenuService {

	@Autowired
	private SmMenuDao smMenuDao;

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Autowired
	private LocaleUtil localeUtil;
	
	public List<MenuMVo> getTopMenu(MenuMVo param) {
		return smMenuDao.getTopMenu(param);
	}
	
	public List<MenuMVo> getLeftMenu(MenuMVo param) {
		return smMenuDao.getLeftMenu(param);
	}

	@Override
	public List<MenuMVo> getBkmkLeftMenu(MenuMVo param) {
		return smMenuDao.getBkmkLeftMenu(param);
	}

	public MenuMVo getMenuByUrl(MenuMVo param) {
		return smMenuDao.getMenuByUrl(param);
	}

	@Override
	public MenuMVo getBkmkMenuByUrl(MenuMVo param) {
		return smMenuDao.getBkmkMenuByUrl(param);
	}

	@Override
	public int instMenuHist(MenuMVo param) {
		return smMenuDao.instMenuHist(param);
	}

}
