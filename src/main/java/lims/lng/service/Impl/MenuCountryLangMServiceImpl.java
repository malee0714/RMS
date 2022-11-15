package lims.lng.service.Impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.com.service.CommonService;
import lims.lng.dao.MenuCountryLangMDao;
import lims.lng.service.MenuCountryLangMService;
import lims.sys.vo.MenuMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;


@Service
public class MenuCountryLangMServiceImpl implements MenuCountryLangMService{
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	private MenuCountryLangMDao menuCountryLangMDao;
	
	@Override
	public List<MenuMVo> getMconlang(MenuMVo vo){
		return menuCountryLangMDao.getMconlang(vo);
	}

	@Override
	public int saveMconlang(List<MenuMVo> list, MenuMVo vo) {
		//Service에서 세션값 받아오기
				HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
				UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
				String sLastChangerId = userMVo.getUserId(); 
				String nationLangCode = vo.getNationLangCode();	
				int count = 0;
				if (list.isEmpty())
					return count;
				for(int i=0; i<list.size(); i++) {
					list.get(i).setNationLangCode(nationLangCode);
					list.get(i).setLastChangerId(sLastChangerId); // 로그인 세션값 할당
					if(list.get(i).getLangMenuSeqno() == "" || list.get(i).getLangMenuSeqno() == null) {
						count = menuCountryLangMDao.saveMconlang(list.get(i));
					} else {
						count = menuCountryLangMDao.upMconlang(list.get(i));
					}
				}
		return count;
	}
}
