package lims.com.dao;

import java.security.cert.PKIXRevocationChecker.Option;

import lims.com.vo.LoginMVo;
import lims.sys.vo.MenuMVo;
import lims.sys.vo.UserMVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginMDao {
	public UserMVo getUser(UserMVo param);
	public int udtLogout(LoginMVo param);
	public int loginFailureCount(UserMVo vo);
	public int loginSucceedOrFailure(UserMVo vo);
	public int getChkAthMenu(MenuMVo param);

	int updateLastLoginDate(UserMVo vo);
}
