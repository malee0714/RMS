package lims.lng.service.Impl;

import lims.com.service.CommonService;
import lims.lng.dao.CmmnCodeLangMDao;
import lims.lng.service.CmmnCodeLangMService;
import lims.lng.vo.CmmnCodeLangMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class CmmnCodeLangMServiceImpl implements CmmnCodeLangMService{
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	private CmmnCodeLangMDao cmmnCodeLangMDao;
	
	@Override
	public List<CmmnCodeLangMVo> getCmmnLang(CmmnCodeLangMVo vo){
		return cmmnCodeLangMDao.getCmmnLang(vo);
	}
	
	@Override
	public int saveCmmnlang(List<CmmnCodeLangMVo> list, CmmnCodeLangMVo vo) {
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

			if(list.get(i).getLangCmmnCodeSeqno() == "" || list.get(i).getLangCmmnCodeSeqno() == null) {
				count = cmmnCodeLangMDao.saveCmmnlang(list.get(i));
			} else {
				count = cmmnCodeLangMDao.upCmmnlang(list.get(i));
			}
		}

		return count;
	}
}
