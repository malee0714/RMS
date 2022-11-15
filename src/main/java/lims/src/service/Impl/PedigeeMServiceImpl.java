package lims.src.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.src.dao.PedigeeMDao;
import lims.src.service.PedigeeMService;
import lims.src.vo.PedigeeMVo;
import lims.test.vo.IssueMVo;
import lims.util.GetUserSession;

@Service
public class PedigeeMServiceImpl implements PedigeeMService {

	@Autowired
	private PedigeeMDao pedigeeMDao;
	
	@Override
	public List<PedigeeMVo> getUpperPrduct(PedigeeMVo vo) {
		return pedigeeMDao.getUpperPrduct(vo);
	}

	@Override
	public List<PedigeeMVo> getReqestPrductList(PedigeeMVo vo) {
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
		return pedigeeMDao.getReqestPrductList(vo);
	}

	@Override
	public List<IssueMVo> getReqestIssueList(IssueMVo vo) {
		return pedigeeMDao.getReqestIssueList(vo);
	}

}
