package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.CheckMVo;


public interface CheckMDao {
	public List<CheckMVo> getCheckMList(CheckMVo vo);
	public List<CheckMVo> getCheckDetailMList(CheckMVo vo);
	public int updCheckDetail(CheckMVo vo);
	public int insCheckWrhsdlvr(CheckMVo vo);
	public int updCheckWrhsdlvr(CheckMVo vo);
	public int insBrcdSeqno(CheckMVo vo);
	public int updCheck(CheckMVo vo);

}
