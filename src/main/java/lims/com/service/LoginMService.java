package lims.com.service;


import lims.sys.vo.MenuMVo;
import lims.sys.vo.UserMVo;


public interface LoginMService {
	public UserMVo getUser(UserMVo param);
	
	public void udtLogout(UserMVo param);
	
	public int loginFailureCount(UserMVo vo);
	
	public int loginSucceedOrFailure(UserMVo vo);
	
	public int getChkAthMenu(MenuMVo param);

	int updateLastLoginDate(UserMVo vo);
}
