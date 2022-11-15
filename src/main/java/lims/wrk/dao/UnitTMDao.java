package lims.wrk.dao;

import java.util.List;

import lims.wrk.vo.UnitTMVo;

public interface UnitTMDao {

	public List<UnitTMVo> getUnitList(UnitTMVo vo);
	public int updateUnit(UnitTMVo vo);
	public int deleteUnit(UnitTMVo vo);
	public int insUnit(UnitTMVo vo);
	public int overlapUnit(UnitTMVo vo);
	
}
