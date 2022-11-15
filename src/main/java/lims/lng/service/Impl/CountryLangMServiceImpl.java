package lims.lng.service.Impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.com.service.CommonService;
import lims.lng.dao.CountryLangMDao;
import lims.lng.service.CountryLangMService;
import lims.lng.vo.CountryLangMVo;
import lims.lng.vo.DefaultLangMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.util.Locale.LocaleUtil;


@Service
public class CountryLangMServiceImpl implements CountryLangMService{
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	private CountryLangMDao countryLangMDao;
	
	@Resource(name="localeUtil")
	private LocaleUtil localeUtil;
	
	@Override
	public List<CountryLangMVo> getConlang(CountryLangMVo vo){
		return countryLangMDao.getConlang(vo);
	} 

	@Override
	public int saveConlang(List<CountryLangMVo> list, CountryLangMVo vo) {
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
					if(list.get(i).getLangDetailSeqno() == "" || list.get(i).getLangDetailSeqno() == null) {
						count = countryLangMDao.saveConlang(list.get(i));
					} else {
						count = countryLangMDao.upConlang(list.get(i));
					}
				}
				
				localeUtil.updateMenuMessage(nationLangCode);
				
		return count;
	}
	
	@Override
	public int conlangChk(CountryLangMVo vo){
		return countryLangMDao.conlangChk(vo);
	}
	
	// 삭제
	@Override
	public int delConlang(List<DefaultLangMVo> list) {
		int count = 0;
		if (list.isEmpty())
			return count;

		for (int i = 0; i < list.size(); i++) {
			count = countryLangMDao.delConlang(list.get(i));
			
		}
		return count;
	}
	
}
