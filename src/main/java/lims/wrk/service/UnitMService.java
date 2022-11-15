package lims.wrk.service;

import java.util.List;

import lims.com.vo.ComboVo;
import lims.wrk.vo.UnitMVo;

public interface UnitMService {
	
	public List<UnitMVo> getUnitList(UnitMVo vo);
	public int saveUnit(List<UnitMVo> added, List<UnitMVo> edited, List<UnitMVo> removed);
	public List<ComboVo> getUnitcomdo(UnitMVo vo);
	public int unitNmValidation(UnitMVo vo);
}
