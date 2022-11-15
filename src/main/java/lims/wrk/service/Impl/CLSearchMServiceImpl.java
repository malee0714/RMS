package lims.wrk.service.Impl;

import lims.util.CommonFunc;
import lims.wrk.dao.CLSearchMDao;
import lims.wrk.service.CLSearchMService;
import lims.wrk.vo.CLVersionResultVO;
import lims.wrk.vo.CLVersionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service(value = "cLSearchMServiceImpl")
public class CLSearchMServiceImpl implements CLSearchMService {
	
	private final CommonFunc commonFunc;
	private final CLSearchMDao clSearchMDao;

	@Autowired
	public CLSearchMServiceImpl(CommonFunc commonFunc, CLSearchMDao clSearchMDao) {
		this.commonFunc = commonFunc;
		this.clSearchMDao = clSearchMDao;
	}

	@Override
	public List<CLVersionVO> getCLVersions(CLVersionVO vo) {
		return clSearchMDao.getCLVersions(vo);
	}
	
	@Override
	public List<CLVersionResultVO> getCLVersionResults(CLVersionResultVO vo) {
		return clSearchMDao.getCLVersionResults(vo);
	}
	
	@Override
	public void updateClVersionResult(List<CLVersionResultVO> list) {
		list.forEach(clVersionResultVO -> {
			clSearchMDao.updateClVersionResult(clVersionResultVO);
			clSearchMDao.updateMtrilSdspc(clVersionResultVO);
		});
	}
}
