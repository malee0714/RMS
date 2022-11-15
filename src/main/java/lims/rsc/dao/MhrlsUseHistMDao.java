package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.MhrlsUseHistMVo;

public interface MhrlsUseHistMDao {
	public List<MhrlsUseHistMVo> getMhrlsUseHistM(MhrlsUseHistMVo vo);
	public int insMhrlsUseHistM(MhrlsUseHistMVo vo);
	public int updMhrlsUseHistDel(MhrlsUseHistMVo vo);
	public int updMhrlsUseHistAllDel(MhrlsUseHistMVo vo);
}
