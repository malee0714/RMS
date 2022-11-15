package lims.wrk.service.Impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;


import lims.com.vo.ComboVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.wrk.dao.UnitMDao;
import lims.wrk.service.UnitMService;
import lims.wrk.vo.UnitMVo;

/**
 * @author csy
 *
 */
/**
 * @author csy
 *
 */
@Service
public class UnitMServiceImpl implements UnitMService{
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
    private UnitMDao unitMDao;

	//시험항목수수료조회
	@Override
	public List<UnitMVo> getUnitList(UnitMVo vo) {
		return unitMDao.getUnitList(vo);
	}
	
	//시험항목수수료저장
	@Override
	public int saveUnit(List<UnitMVo> added, List<UnitMVo> edited, List<UnitMVo> removed) {
		
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);		
		
		int check = 0;
		for(int i = 0; i<added.size(); i++){
			added.get(i).setLastChangerId(userMVo.getUserId());
			if(added.get(i).getUnitSeqno() == "" || added.get(i).getUnitSeqno() == null){			
				check += unitMDao.insertUnit(added.get(i));
			}else{			
				check += unitMDao.updateUnit(added.get(i));
			}
		}
		
		for(int i = 0; i<edited.size(); i++){
			edited.get(i).setLastChangerId(userMVo.getUserId());
			if(edited.get(i).getUnitSeqno() == "" || edited.get(i).getUnitSeqno() == null){			
				check += unitMDao.insertUnit(edited.get(i));
			}else{			
				check += unitMDao.updateUnit(edited.get(i));
			}
		}
		
		for(int i = 0; i<removed.size(); i++){
			removed.get(i).setLastChangerId(userMVo.getUserId());
			check += unitMDao.deleteUnit(removed.get(i));
		}
		
		if(check > 1){
			check = 1;
		}
		return check;
	}


	@Override
	public List<ComboVo> getUnitcomdo(UnitMVo vo) {
		return unitMDao.getUnitcomdo(vo);
	}

	@Override
	public int unitNmValidation(UnitMVo vo) {
		int count = 0;
		for(UnitMVo unitMVo : vo.getAddedRowItems()) {
			if(unitMDao.insUnitNmValidation(unitMVo)>=1){
				count ++;
			}
		}
		for(UnitMVo unitMVo : vo.getEditedRowItems()) {
			if(unitMDao.updUnitNmValidation(unitMVo)>=1){
				count ++;
			}
		}
		return count;
	}
	
	
}
