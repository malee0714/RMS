package lims.wrk.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.com.service.CommonService;
import lims.sys.vo.MenuMVo;
import lims.util.CommonFunc;
import lims.wrk.dao.MenuLabelLangMDao;
import lims.wrk.service.MenuLabelLangMService;
import lims.wrk.vo.MenuLabelLangMVo;

@Service
public class MenuLabelLangMServiceImpl implements MenuLabelLangMService{
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	private MenuLabelLangMDao menuLabelLangMDao;
	
	@Override
	public List<MenuMVo> getLablang(MenuMVo vo){
		return menuLabelLangMDao.getLablang(vo);
	}
	
	@Override
	public List<MenuLabelLangMVo> getLabinfolang(MenuLabelLangMVo vo){
		return menuLabelLangMDao.getLabinfolang(vo);
	}
	
	@Override
	public int savelabellang(List<MenuLabelLangMVo> list) {
		int count = 0;

		if (list.isEmpty())
			return count;
		
		for(int i=0; i<list.size(); i++) {
		
				if(list.get(i).getLangMenuLblSeqno() == "" || list.get(i).getLangMenuLblSeqno() == null) {
					count = menuLabelLangMDao.savelabellang(list.get(i));
				} else {
					count = menuLabelLangMDao.uplabellang(list.get(i));
				}
			
		}
		
		return count;
	}
	
	// 삭제
	@Override
	public int delLablang(List<MenuLabelLangMVo> list) {
		int count = 0;
		if (list.isEmpty())
			return count;

		for (int i = 0; i < list.size(); i++) {
			count = menuLabelLangMDao.delLablang(list.get(i));
			
		}
		return count;
	}
}
