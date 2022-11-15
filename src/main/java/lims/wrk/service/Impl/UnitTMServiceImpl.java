package lims.wrk.service.Impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.sys.vo.MenuMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.wrk.dao.UnitTMDao;
import lims.wrk.service.UnitTMService;
import lims.wrk.vo.UnitTMVo;

/**
 * @author csy
 *
 */
/**
 * @author csy
 *
 */
@Service
public class UnitTMServiceImpl implements UnitTMService{
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
    private UnitTMDao unitTMDao;

	//시험항목수수료조회
	@Override
	public List<UnitTMVo> getUnitList(UnitTMVo vo) {		
		return unitTMDao.getUnitList(vo);
	}
	@Override
	public int insUnit(UnitTMVo vo) {
		return unitTMDao.insUnit(vo);
	}
	@Override
	public int updateUnit(UnitTMVo vo) {
		return unitTMDao.updateUnit(vo);
	}
	@Override
	public int deleteUnit(UnitTMVo vo){
		return unitTMDao.deleteUnit(vo);
	}
	@Override
	public int overlapUnit(UnitTMVo vo){
		return unitTMDao.overlapUnit(vo);
	}
	/*
	//시험항목수수료저장
	@Override
	public int saveUnit(List<UnitTMVo> added, List<UnitTMVo> edited, List<UnitTMVo> removed) {
		
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);		
		
		int check = 0;
		for(int i = 0; i<added.size(); i++){
			added.get(i).setLastChangerId(userMVo.getUserId());
			if(added.get(i).getUnitSeqno() == "" || added.get(i).getUnitSeqno() == null){			
				check += unitTMDao.insertUnit(added.get(i));
			}else{			
				check += unitTMDao.updateUnit(added.get(i));
			}
		}
		
		for(int i = 0; i<edited.size(); i++){
			edited.get(i).setLastChangerId(userMVo.getUserId());
			if(edited.get(i).getUnitSeqno() == "" || edited.get(i).getUnitSeqno() == null){			
				check += unitTMDao.insertUnit(edited.get(i));
			}else{			
				check += unitTMDao.updateUnit(edited.get(i));
			}
		}
		
		for(int i = 0; i<removed.size(); i++){
			removed.get(i).setLastChangerId(userMVo.getUserId());
			check += unitTMDao.deleteUnit(removed.get(i));
		}
		
		if(check > 1){
			check = 1;
		}
		return check;
	}*/

}
