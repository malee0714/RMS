package lims.rsc.service;

import java.util.List;

import lims.rsc.vo.MhrlsUseHistMVo;

public interface MhrlsUseHistMService {
	public List<MhrlsUseHistMVo> getMhrlsUseHistM(MhrlsUseHistMVo vo);
	public int insMhrlsUseHistM(MhrlsUseHistMVo vo);
	public int updMhrlsUseHistDel(MhrlsUseHistMVo vo);
	
}
