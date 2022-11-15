package lims.rsc.service.Impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.com.service.CommonService;
import lims.rsc.dao.CndtnCheckMDao;
import lims.rsc.service.CndtnCheckMService;
import lims.rsc.vo.CndtnCheckMVo;
import lims.sys.vo.CanisterNoMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;

@Service
public class CndtnCheckMServiceImpl implements CndtnCheckMService{
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	private CndtnCheckMDao cndtnCheckMDao;
	
	@Override
	public List<CndtnCheckMVo> getcndtn(CndtnCheckMVo vo){
		return cndtnCheckMDao.getcndtn(vo);
	}
	@Override
	public List<CndtnCheckMVo> getCnd(CndtnCheckMVo vo){
		return cndtnCheckMDao.getCnd(vo);
	}
	@Override
	public List<CndtnCheckMVo> getCndVal(CndtnCheckMVo vo){
		return cndtnCheckMDao.getCndVal(vo);
	}
	@Override
	public List<CndtnCheckMVo> selectmhr(CndtnCheckMVo vo){
		return cndtnCheckMDao.selectmhr(vo);
	}
	
	
	@Override
	public List<CndtnCheckMVo> getchValueList(CndtnCheckMVo vo){
		return cndtnCheckMDao.getchValueList(vo);
	}
	@Override
	public CndtnCheckMVo getchkValueList(CndtnCheckMVo vo){
		CndtnCheckMVo data = new CndtnCheckMVo();
		data.setList(cndtnCheckMDao.getchkValueList(vo));
		data.setListDate(cndtnCheckMDao.getchkValueDateList(vo));
		return data;
	}
	
	@Override
	public int saveCndtnDetail(CndtnCheckMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		String sLastChangerId = userMVo.getUserId(); 
		//String cndtnInspctIemCode = vo.getCmmnCode();
		
		int count = 0;

		if (vo == null)
			return count;
		
		//마스터 등록
			vo.setLastChangerId(sLastChangerId);
				if(vo.getCndtnChckSeqno() == "" || vo.getCndtnChckSeqno() == null) {
					System.out.println("마스터 등록");
					count = cndtnCheckMDao.saveCndtn(vo); 
				} else {
					System.out.println("마스터 수정");
					count = cndtnCheckMDao.upCndtn(vo); 
				}
				
			

		
		
		for(int i=0; i<vo.getList().size(); i++) {

			vo.getList().get(i).setCndtnInspctIemCode(vo.getList().get(i).getCmmnCode());
			vo.getList().get(i).setLastChangerId(sLastChangerId);
			
			
				if(vo.getList().get(i).getCndtnChckSeqno() == "" || vo.getList().get(i).getCndtnChckSeqno() == null) {
				
					String cndtnChckSeqno = vo.getCndtnChckSeqno();	
					vo.getList().get(i).setCndtnChckSeqno(cndtnChckSeqno);
					System.out.println("디테일 등록");
					count = cndtnCheckMDao.saveCndtnDetail(vo.getList().get(i));
				} else {		
					System.out.println("디테일 수정");
					count = cndtnCheckMDao.upCndtnDetail(vo.getList().get(i));
				}
				
		}
		
		return count;
	}


	
}
