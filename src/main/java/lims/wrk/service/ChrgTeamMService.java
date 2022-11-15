package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.ChrgTeamMVo;

public interface ChrgTeamMService {
	
	public List<ChrgTeamMVo> getChrgTeamList(ChrgTeamMVo vo);
	
	public List<ChrgTeamMVo> getChrgTeamIpList(ChrgTeamMVo vo);
	
	public List<ChrgTeamMVo> getChrgTeamIpComboList(ChrgTeamMVo vo);
	
	public List<ChrgTeamMVo> getUserList(ChrgTeamMVo vo);
	
	public List<ChrgTeamMVo> getChrgTeamUserList(ChrgTeamMVo vo);
	
	public String saveChrgTeam(ChrgTeamMVo vo);
	
	public int deleteChrgTeam(ChrgTeamMVo vo);
}
