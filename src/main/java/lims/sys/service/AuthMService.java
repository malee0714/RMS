package lims.sys.service;

import java.util.List;

import lims.sys.vo.AuthMVo;
import lims.sys.vo.UserMVo;


public interface AuthMService {

	public List<AuthMVo> getAthMList(AuthMVo param);
	public List<AuthMVo> getAllMenuList(AuthMVo param);
	public List<AuthMVo> getAthMenuList(AuthMVo param);
	public List<UserMVo> getAllUserList(UserMVo param);
	public List<UserMVo> getAthUserList(UserMVo param);
	public String insAthMenu(List<AuthMVo> addedRow, List<AuthMVo> editedRow, List<AuthMVo> removedRow);
	public String insAthUser(List<UserMVo> addedRow, List<UserMVo> editedRow, List<UserMVo> removedRow);
	public int insAthGroup(AuthMVo vo);
	public int updAthGroup(AuthMVo vo);
}

