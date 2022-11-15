package lims.wrk.service.Impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.sys.vo.CmmnCodeMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.wrk.dao.UnitFMDao;
import lims.wrk.service.UnitFMService;
import lims.wrk.vo.UnitFMVo;
import lombok.extern.slf4j.Slf4j;
/**
 * @author csy
 *
 */
/**
 * @author csy
 *
 */
@Service
public class UnitFMServiceImpl implements UnitFMService{
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
    private UnitFMDao unitFMDao;

	//시험항목수수료조회
	@Override
	public List<UnitFMVo> getUnitList(UnitFMVo vo) {		
		return unitFMDao.getUnitList(vo);
	}
	
	//시험항목수수료저장
	@Override
	public int saveUnit(List<UnitFMVo> added, List<UnitFMVo> edited, List<UnitFMVo> removed) {
		
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);		
		
		int check = 0;
		for(int i = 0; i<added.size(); i++){
			added.get(i).setLastChangerId(userMVo.getUserId());
			if(added.get(i).getUnitSeqno() == "" || added.get(i).getUnitSeqno() == null){			
				check += unitFMDao.insertUnit(added.get(i));
			}else{			
				check += unitFMDao.updateUnit(added.get(i));
			}
		}
		
		for(int i = 0; i<edited.size(); i++){
			edited.get(i).setLastChangerId(userMVo.getUserId());
			if(edited.get(i).getUnitSeqno() == "" || edited.get(i).getUnitSeqno() == null){			
				check += unitFMDao.insertUnit(edited.get(i));
			}else{			
				check += unitFMDao.updateUnit(edited.get(i));
			}
		}
		
		for(int i = 0; i<removed.size(); i++){
			removed.get(i).setLastChangerId(userMVo.getUserId());
			check += unitFMDao.deleteUnit(removed.get(i));
		}
		
		if(check > 1){
			check = 1;
		}
		
		return check;
	}

	@Override
	public int updUnitFM(UnitFMVo vo) {
		int count = 0;
		count= unitFMDao.updateUnit(vo);
		
		return count;
	}
	
	@Override
	public int insUnitFM(UnitFMVo vo) {
		int count =0;
		count= unitFMDao.insertUnit(vo);
		
		return count;
	}

	@Override
	public int delUnitFM(UnitFMVo vo) {
		int count =0;
		count= unitFMDao.deleteUnit(vo);
		
		return count;
	}

	@Override
	public int confirmUnitFM(UnitFMVo vo) {
		return unitFMDao.confirmUnitFM(vo);
	}
}
