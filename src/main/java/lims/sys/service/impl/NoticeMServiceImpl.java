package lims.sys.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.sys.dao.NoticeMDao;
import lims.sys.service.NoticeMService;
import lims.sys.vo.NoticeMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;

@Service
public class NoticeMServiceImpl implements NoticeMService {
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
	private NoticeMDao noticeMDao;

	@Override
	public List<NoticeMVo> getNoticeMList(NoticeMVo vo) {
		return noticeMDao.getNoticeMList(vo);
	}
	
	// 저장 및 수정
	@Override
	public int saveNoticeM(List<NoticeMVo> vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		int result = 0;
		for(int i=0; i <vo.size(); i++) {
			String sLastChangerId = userMVo.getUserId(); 
			vo.get(i).setLastChangerId(sLastChangerId); // 로그인 세션값 할당
			
			if(vo.get(i).getGridCrud() != "" && vo.get(i).getGridCrud()  != null){
				if(vo.get(i).getGridCrud().equals("C")){ // CRUD 구분값이 C라면 insert
					result = noticeMDao.insNoticeM(vo.get(i));
				}
				
				if(vo.get(i).getGridCrud().equals("U")){ // CRUD 구분값이 U라면 update
					result = noticeMDao.updNoticeM(vo.get(i));
				}
			}
		}
		return result;
	}
	
}
