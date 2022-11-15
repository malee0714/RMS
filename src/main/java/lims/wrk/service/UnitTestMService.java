package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.UnitTestMVo;

public interface UnitTestMService {
	
	public List<UnitTestMVo> getUnitTestList(UnitTestMVo vo);
	
	public List<UnitTestMVo> getAllMenuCharger();

	public void saveMenuCharger(UnitTestMVo unitTestMVo);

	public void deleteUnitTest(UnitTestMVo unitTestMVo);

	public void saveUnitTest(UnitTestMVo unitTestMVo);

	public void updateUnitTest(UnitTestMVo unitTestMVo);

	public String changeInputChargerNm(Integer menuSeqno);

}
