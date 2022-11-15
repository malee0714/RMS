package lims.sys.service;

import java.util.List;

import lims.sys.vo.SchdulMVo;

public interface SchdulMService {
	public List<SchdulMVo> getSchdulMList(SchdulMVo vo);
	
	public List<SchdulMVo> getSchdulUserList(SchdulMVo vo);
	
	public int saveSchdulInfo(SchdulMVo vo);
	
	public int delSchdule(SchdulMVo vo);
}
