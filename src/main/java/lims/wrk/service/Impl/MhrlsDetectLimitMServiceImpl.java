package lims.wrk.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.wrk.dao.MhrlsDetectLimitMDao;
import lims.wrk.service.MhrlsDetectLimitMService;
import lims.wrk.vo.MhrlsDetectLimitMVo;

@Service
public class MhrlsDetectLimitMServiceImpl implements MhrlsDetectLimitMService{
	
	private final MhrlsDetectLimitMDao mhrlsDetectLimitMDao;

	@Autowired
	public MhrlsDetectLimitMServiceImpl(MhrlsDetectLimitMDao mhrlsDetectLimitMDao) {
		this.mhrlsDetectLimitMDao = mhrlsDetectLimitMDao;
	}

	@Override
	public List<MhrlsDetectLimitMVo> getDLExpriems(MhrlsDetectLimitMVo vo){
		return mhrlsDetectLimitMDao.getDLExpriems(vo);
	}
	
	@Override
	public int saveExprDl(MhrlsDetectLimitMVo vo) {
		if(vo.isNew()){
			return mhrlsDetectLimitMDao.insExprDl(vo);
		}else{
			return mhrlsDetectLimitMDao.updExprDl(vo);
		}
	}
}
