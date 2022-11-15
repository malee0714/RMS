package lims.wrk.dao;

import java.util.List;

import lims.sys.vo.AuthMVo;
import lims.sys.vo.MenuMVo;
import lims.wrk.vo.AbsnceMVo;

public interface AbsnceMDao {
//	public List<AbsnceMVo> getUnitList(AbsnceMVo vo);
	public int insAbsnceM(AbsnceMVo vo);
	public int updAbsnceM(AbsnceMVo vo);
	public int saveAbsnceM(AbsnceMVo vo);
	public List<AbsnceMVo> getAbsnceList(AbsnceMVo vo);
	public int deleteAbsnM(AbsnceMVo vo);
	public int confirmAbsnceM(AbsnceMVo vo);
	
}
