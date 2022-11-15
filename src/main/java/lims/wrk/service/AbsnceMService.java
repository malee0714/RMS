package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.AbsnceMVo;

public interface AbsnceMService {
	public int insAbsnceM(AbsnceMVo vo);
	public int updAbsnceM(AbsnceMVo vo);
	public int saveAbsnceM(AbsnceMVo vo);
	public List<AbsnceMVo> getAbsnceList(AbsnceMVo vo);
	public int deleteAbsnM(AbsnceMVo vo);
	public int confirmAbsnceM(AbsnceMVo vo);
	
}
