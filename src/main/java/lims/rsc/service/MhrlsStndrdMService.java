package lims.rsc.service;

import java.util.List;

import lims.rsc.vo.MhrlsStndrdMVo;

public interface MhrlsStndrdMService {
	public List<MhrlsStndrdMVo> getMhrlsStndrdUseMList(MhrlsStndrdMVo vo);
	
	public int instMhrlsStndrdUseM(MhrlsStndrdMVo vo);
}
