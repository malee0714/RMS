package lims.sys.dao;

import java.util.List;

import lims.sys.vo.SchdulMVo;

public interface SchdulMDao {
	public List<SchdulMVo> getSchdulMList(SchdulMVo vo);

	public List<SchdulMVo> getSchdulUserList(SchdulMVo vo);
	
	public int insSchdulInfo(SchdulMVo vo);
	
	public int updSchdulInfo(SchdulMVo vo);
	
	public int insSchdulUser(SchdulMVo vo);
	
	public int delSchdul(SchdulMVo vo);
	
	public int delSchdulUser(SchdulMVo vo);
}
