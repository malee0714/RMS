package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.MhrlsStndrdMVo;

public interface MhrlsStndrdMDao {
	public List<MhrlsStndrdMVo> getMhrlsStndrdUseMList(MhrlsStndrdMVo vo);
	public int instMhrlsStndrdUseM(MhrlsStndrdMVo vo);
	public int updtMhrlsStndrdUseM(MhrlsStndrdMVo vo);
}
