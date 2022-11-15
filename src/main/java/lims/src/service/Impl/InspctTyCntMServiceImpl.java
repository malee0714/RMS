package lims.src.service.Impl;

import lims.src.dao.InspctTyCntMDao;
import lims.src.service.InspctTyCntMService;
import lims.src.vo.InspctTyCntMVo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InspctTyCntMServiceImpl implements InspctTyCntMService {
	
	@Autowired
	private InspctTyCntMDao inspctTyCntMDao;

	@Override
	public List<InspctTyCntMVo> getReqCntByInspctTyAndMnth(InspctTyCntMVo vo) {
		return inspctTyCntMDao.getReqCntByInspctTyAndMnth(vo);
	}
}
