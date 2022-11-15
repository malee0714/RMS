package lims.src.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.src.dao.PedigeeMDao;
import lims.src.dao.PedigeeRealMDao;
import lims.src.service.PedigeeMService;
import lims.src.service.PedigeeRealMService;
import lims.src.vo.PedigeeMVo;
import lims.test.vo.IssueMVo;
import lims.util.GetUserSession;

@Service
public class PedigeeRealMServiceImpl implements PedigeeRealMService {

	@Autowired
	private PedigeeRealMDao pedigeeRealMDao;
	

	@Override
	public List<PedigeeMVo> getUpperReqestPedigee(PedigeeMVo vo) {
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
		return pedigeeRealMDao.getUpperReqestPedigee(vo);
	}
}
