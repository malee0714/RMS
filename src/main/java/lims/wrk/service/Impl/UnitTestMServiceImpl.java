package lims.wrk.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.wrk.dao.UnitTestMDao;
import lims.wrk.service.UnitTestMService;
import lims.wrk.vo.UnitTestMVo;

@Service
public class UnitTestMServiceImpl implements UnitTestMService {
	
	private UnitTestMDao unitTestMDao;
	
	@Autowired
	public UnitTestMServiceImpl(UnitTestMDao unitTestMDao) {
		this.unitTestMDao = unitTestMDao;
	}
	
	@Override
	public List<UnitTestMVo> getUnitTestList(UnitTestMVo vo) {
		return unitTestMDao.getUnitTestList(vo);
	}
	
	@Override
	public List<UnitTestMVo> getAllMenuCharger() {
		return unitTestMDao.getAllMenuCharger();
	}

	@Override
	public void saveMenuCharger(UnitTestMVo unitTestMVo) {
		List<UnitTestMVo> unitTestMVoList = unitTestMVo.getGridData();
		for(UnitTestMVo vo : unitTestMVoList) {
			if(vo.getChargerNm() != null) {
				if(vo.getMenuSeqno() != null){
					unitTestMDao.saveMenuCharger(vo);
				}
			}
		}
	}
	
	@Override
	public void deleteUnitTest(UnitTestMVo unitTestMVo) {
		unitTestMDao.deleteUnitTest(unitTestMVo);
	}
	
	@Override
	public void saveUnitTest(UnitTestMVo unitTestMVo) {
		unitTestMDao.saveUnitTest(unitTestMVo);
	}
	
	@Override
	public void updateUnitTest(UnitTestMVo unitTestMVo) {
		unitTestMDao.updateUnitTest(unitTestMVo);
	}
	
	@Override
	public String changeInputChargerNm(Integer menuSeqno) {
		return unitTestMDao.changeInputChargerNm(menuSeqno);
	}
	

}
