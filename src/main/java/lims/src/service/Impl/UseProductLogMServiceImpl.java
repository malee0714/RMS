package lims.src.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.rsc.vo.RgntHistMVo;
import lims.src.dao.UseProductLogMDao;
import lims.src.service.UseProductLogMService;

@Service
public class UseProductLogMServiceImpl implements UseProductLogMService {

	@Autowired
	private UseProductLogMDao useProductLogMDao;
	
	@Override
	public List<RgntHistMVo> getUseBacode(RgntHistMVo vo) {
		return useProductLogMDao.getUseBacode(vo);
	}
}
