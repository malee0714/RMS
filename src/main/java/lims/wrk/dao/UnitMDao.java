package lims.wrk.dao;

import java.util.List;

import lims.com.vo.ComboVo;
import lims.wrk.vo.UnitMVo;

public interface UnitMDao {

	public List<UnitMVo> getUnitList(UnitMVo vo);
	public int insertUnit(UnitMVo vo);
	public int updateUnit(UnitMVo vo);
	public int deleteUnit(UnitMVo vo);
	public List<ComboVo> getUnitcomdo(UnitMVo vo);
	public int insUnitNmValidation(UnitMVo vo);
	public int updUnitNmValidation(UnitMVo vo);
}
