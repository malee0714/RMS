package lims.src.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.src.dao.ImPartclLogMDao;
import lims.src.service.ImPartclLogMService;
import lims.src.vo.ImpartclLogMVo;

@Service
public class ImPartclLogMServiceImpl implements ImPartclLogMService {

	@Autowired
	private ImPartclLogMDao imPartclLogMDao;

	@Override
	public List<ImpartclLogMVo> getParticleList(ImpartclLogMVo vo) {
		return imPartclLogMDao.getParticleList(vo);
	}

	@Override
	public List<ImpartclLogMVo> getMhrlsList() {
		return imPartclLogMDao.getMhrlsList();
	}
	
}
