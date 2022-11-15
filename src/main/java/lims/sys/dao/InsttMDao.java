package lims.sys.dao;

import java.util.List;

import lims.sys.vo.InsttMVo;

public interface InsttMDao {
	public List<InsttMVo> getInsttMList(InsttMVo vo);
	public int insInsttM(InsttMVo vo);
	public int updInsttM(InsttMVo vo);
}
