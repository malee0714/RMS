package lims.wrk.service;

import java.util.List;

import lims.sys.vo.CmmnCodeMVo;
import lims.wrk.vo.UnitFMVo;

public interface UnitFMService {
	public List<UnitFMVo> getUnitList(UnitFMVo vo);
	public int saveUnit(List<UnitFMVo> addedUnitFMVO, List<UnitFMVo> editedUnitFMVO, List<UnitFMVo> removedUnitFMVO);
	public int updUnitFM(UnitFMVo vo);
	public int insUnitFM(UnitFMVo vo);
	public int delUnitFM(UnitFMVo vo);
	public int confirmUnitFM(UnitFMVo vo);
}
