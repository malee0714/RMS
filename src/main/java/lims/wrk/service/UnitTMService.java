package lims.wrk.service;

import java.util.List;

import lims.sys.vo.MenuMVo;
import lims.wrk.vo.UnitTMVo;

public interface UnitTMService {
	public List<UnitTMVo> getUnitList(UnitTMVo vo);
	//public int saveUnit(List<UnitTMVo> added, List<UnitTMVo> edited, List<UnitTMVo> removed);
	public int insUnit(UnitTMVo vo);
	public int deleteUnit(UnitTMVo vo);
	public int updateUnit(UnitTMVo vo);
	public int overlapUnit(UnitTMVo vo);
}
