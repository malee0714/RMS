package lims.wrk.service.Impl;

import lims.util.CommonFunc;
import lims.wrk.dao.CLManageMDao;
import lims.wrk.service.CLManageMService;
import lims.wrk.vo.CLManageMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CLManageMServiceImpl implements CLManageMService {
	
    private final CLManageMDao clmanageMDao;
	private final CommonFunc commonFunc;

	@Autowired
	public CLManageMServiceImpl(CLManageMDao clmanageMDao, CommonFunc commonFunc) {
		this.clmanageMDao = clmanageMDao;
		this.commonFunc = commonFunc;
	}

	@Override
	public List<CLManageMVo> getCLManageList(CLManageMVo vo) {
		return clmanageMDao.getCLManageList(vo);
	}
	
	@Override
	public int updateCLM(List<CLManageMVo> list){
		
		int result = 0;
		
		for(int i=0; i<list.size(); i++) {
			CLManageMVo vo = list.get(i);
			result = ( commonFunc.isEmpty(vo.getMtrilClManageSeqno()) ) ? clmanageMDao.insertCLM(list.get(i)) : clmanageMDao.updateCLM(list.get(i));
		}
		
		return result;
	}
}
