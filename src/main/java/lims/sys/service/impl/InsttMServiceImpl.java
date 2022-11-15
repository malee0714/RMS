package lims.sys.service.impl;

import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.sys.dao.InsttMDao;
import lims.sys.dao.MenuMDao;
import lims.sys.service.InsttMService;
import lims.sys.vo.InsttMVo;
import lims.sys.vo.MenuMVo;
@Service
public class InsttMServiceImpl implements InsttMService {
	

	@Autowired
    private InsttMDao insttM;
	
	
	@Override
	public List<InsttMVo> getInsttMList(InsttMVo vo) {
		return insttM.getInsttMList(vo);
	}


	@Override
	public int insInsttM(InsttMVo vo) {
		return insttM.insInsttM(vo);
	}


	@Override
	public int updInsttM(InsttMVo vo) {
		int num = insttM.updInsttM(vo);
		return num;
	}


}
