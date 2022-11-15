package lims.rsc.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.rsc.dao.MhrlsStndrdMDao;
import lims.rsc.service.MhrlsStndrdMService;
import lims.rsc.vo.MhrlsStndrdMVo;

@Service
public class MhrlsStndrdMServiceImpl implements MhrlsStndrdMService {

	@Autowired
	private MhrlsStndrdMDao mhrlsStndrdMDao;
	
	@Override
	public List<MhrlsStndrdMVo> getMhrlsStndrdUseMList(MhrlsStndrdMVo vo) {
		return mhrlsStndrdMDao.getMhrlsStndrdUseMList(vo);
	}
	
	@Override
	public int instMhrlsStndrdUseM(MhrlsStndrdMVo vo) {
		int result = 0;
		if(vo.getPrductStndrdSeqno() != null && !vo.getPrductStndrdSeqno().equals(""))
			result = mhrlsStndrdMDao.updtMhrlsStndrdUseM(vo);
		else{
			result = mhrlsStndrdMDao.instMhrlsStndrdUseM(vo);
		}
		return result;
	}

}
