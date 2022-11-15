package lims.wrk.dao;

import java.util.List;

import lims.sys.vo.AuthMVo;
import lims.sys.vo.MenuMVo;
import lims.wrk.vo.UnitFMVo;

public interface UnitFMDao {

	public List<UnitFMVo> getUnitList(UnitFMVo vo);
	public int insertUnit(UnitFMVo vo); 
	public int updateUnit(UnitFMVo vo);
	public int deleteUnit(UnitFMVo vo);
	public int insManual(MenuMVo vo);
	public List<AuthMVo> getUnitList(AuthMVo vo);
	public int confirmUnitFM(UnitFMVo vo);
}
