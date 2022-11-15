package lims.wrk.dao;

import java.util.List;
import lims.wrk.vo.ChrgTeamMVo;

public interface ChrgTeamMDao {
	
	public List<ChrgTeamMVo> getChrgTeamList(ChrgTeamMVo vo);
	
	public List<ChrgTeamMVo> getChrgTeamIpList(ChrgTeamMVo vo);
	
	public List<ChrgTeamMVo> getChrgTeamIpComboList(ChrgTeamMVo vo);
	
	public List<ChrgTeamMVo> getUserList(ChrgTeamMVo vo);
	
	public List<ChrgTeamMVo> getChrgTeamUserList(ChrgTeamMVo vo);
	
	
	public int insertChrgTeam(ChrgTeamMVo vo);
	
	public int updateChrgTeam(ChrgTeamMVo vo);
	
	public int deleteChrgTeamUser(ChrgTeamMVo vo);
	
	public int insertChrgTeamUser(ChrgTeamMVo vo);
	
	public int deleteChrgTeam(ChrgTeamMVo vo);
	
	public int addChrgIp(ChrgTeamMVo vo);
	public int editChrgIp(ChrgTeamMVo vo);
	public int delChrgIp(ChrgTeamMVo vo);
	
	public int delChrgTeamUser(String vo);
	
	public int instChrgTeamUser(ChrgTeamMVo vo);
}
