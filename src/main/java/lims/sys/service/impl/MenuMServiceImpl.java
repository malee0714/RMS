package lims.sys.service.impl;

import lims.com.dao.SmMenuDao;
import lims.sys.dao.MenuMDao;
import lims.sys.service.MenuMService;
import lims.sys.vo.AuthMVo;
import lims.sys.vo.MenuMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class MenuMServiceImpl implements MenuMService {

    private final MenuMDao menuMDao;
	private final SmMenuDao smMenuDao;
	private final CommonFunc commonFunc;

	@Autowired
	public MenuMServiceImpl(MenuMDao menuMDao, SmMenuDao smMenuDao, CommonFunc commonFunc) {
		this.menuMDao = menuMDao;
		this.smMenuDao = smMenuDao;
		this.commonFunc = commonFunc;
	}

	@Override
	public List<MenuMVo> getMenuMList(MenuMVo vo) {
		return menuMDao.getMeuMList(vo);
	}

	@Override
	public int insMenuM(MenuMVo vo) {
		return menuMDao.insMeuLv(vo);
	}
	@Override
	public MenuMVo getMenuSeqno(MenuMVo vo) {
		return menuMDao.getMenuSeqno(vo);
	}

	@Override
	public int chkBookMarkRegistred(MenuMVo vo) {
		return menuMDao.chkBookMarkRegistred(vo);
	}

	@Override
	public MenuMVo bookMarkControl(MenuMVo vo) {
		MenuMVo result = new MenuMVo();

		HttpServletRequest request = ((ServletRequestAttributes) (RequestContextHolder.getRequestAttributes())).getRequest();
		UserMVo loginUser = commonFunc.getLoginUser(request);
		vo.setUserId(loginUser.getUserId());
		vo.setLangCode(loginUser.getNationLangCode());

		int bookMarkCnt = menuMDao.chkBookMarkRegistred(vo);
		if (bookMarkCnt > 0) {
			menuMDao.delMenuBookMark(vo);
			result.setReturnStr("del");
		} else {
			menuMDao.insMenuBookMark(vo);
			result.setReturnStr("save");
		}

		result.setTopMenu(smMenuDao.getTopMenu(vo));
		result.setLeftMenu(smMenuDao.getBkmkLeftMenu(vo));

		return result;
	}

	@Override
	public int updMenuM(MenuMVo vo) {
		return menuMDao.updMenuM(vo);
	}

	@Override
	public int delMenuM(List<MenuMVo> list) {
		int count = 0;
		if (list.isEmpty()) {
			return count;
		} else if (list.size() != 0) {
			for (int i = 0; i <list.size(); i++) {
				count = menuMDao.delMeuM(list.get(i));
			}
		} else {
			count = -1;
		}

		return count;
	}

	@Override
	public List<MenuMVo> getHirMenuList(MenuMVo vo) {
		return menuMDao.getHirMenuList(vo);
	}

	@Override
	public List<MenuMVo> getMenuLvList(MenuMVo vo) {
		return menuMDao.getMenuLvList(vo);
	}

	@Override
	public List<MenuMVo> getMenuOneList(MenuMVo vo) {
		return menuMDao.getMenuOneList(vo);
	}

	@Override
	public List<MenuMVo> getMenuTwoList(MenuMVo vo) {
		return menuMDao.getMenuTwoList(vo);
	}

	@Override
	public List<AuthMVo> getSchAuth(AuthMVo vo) {
		return menuMDao.getSchAuth(vo);
	}

	@Override
	public int insManual(MenuMVo vo) {
		if (vo.getMnlCn() != null) {
			vo.setBlobMnlCn(vo.getMnlCn().getBytes());
		}

		return menuMDao.insManual(vo);
	}

	@Override
	public MenuMVo getEditorData(MenuMVo vo) {
		MenuMVo getEdiorDataVo = menuMDao.getEditorData(vo);
		if (getEdiorDataVo != null && getEdiorDataVo.getBlobMnlCn() != null) {
			vo.setMnlCn(new String(getEdiorDataVo.getBlobMnlCn()));
		}

		return vo;
	}
}
