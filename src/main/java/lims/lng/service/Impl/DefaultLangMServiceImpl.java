package lims.lng.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.com.service.CommonService;
import lims.lng.dao.DefaultLangMDao;
import lims.lng.service.DefaultLangMService;
import lims.lng.vo.DefaultLangMVo;
import lims.util.CommonFunc;

@Service
public class DefaultLangMServiceImpl implements DefaultLangMService{
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	private DefaultLangMDao defaultLangMDao;
	
	@Override
	public List<DefaultLangMVo> getDelang(DefaultLangMVo vo){
		return defaultLangMDao.getDelang(vo);
	} 
	
	@Override
	public int saveDelang(List<DefaultLangMVo> list) {
		int count = 0;

		if (list.isEmpty())
			return count;
		
		for(int i=0; i<list.size(); i++) {
			// 중복 체크 호출
			defaultLangMDao.langNmChk(list.get(i));
			
				if(list.get(i).getLangMastrSeqno() == "" || list.get(i).getLangMastrSeqno() == null) {
					count = defaultLangMDao.saveDelang(list.get(i));
				} else {
			/*		if(list.get(i).getUseAt().equals("N")) {
						list.get(i).setLangNm("　");
						System.out.println("사용여부에 따른 언어명 >>>>>>>>"+list.get(i).getLangNm());
					}*/
					count = defaultLangMDao.upDelang(list.get(i));
				}
			
		}
		
		return count;
	}
	
	@Override
	public int langNmChk(DefaultLangMVo vo){
		return defaultLangMDao.langNmChk(vo);
	}
	
	// 삭제
	@Override
	public int delDelang(List<DefaultLangMVo> list) {
		int count = 0;
		if (list.isEmpty())
			return count;

		for (int i = 0; i < list.size(); i++) {
			count = defaultLangMDao.delDelang(list.get(i));
			
		}
		return count;
	}
}
