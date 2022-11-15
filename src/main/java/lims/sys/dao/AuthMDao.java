package lims.sys.dao;

import java.util.List;

import lims.com.vo.AuditVo;
import lims.sys.vo.AuthMVo;
import lims.sys.vo.UserMVo;

public interface AuthMDao {
	
	public List<AuthMVo> getAthMList(AuthMVo param);
	public List<AuthMVo> getAllMenuList(AuthMVo param);
	public List<AuthMVo> getAthMenuList(AuthMVo param);
	public List<UserMVo> getAllUserList(UserMVo param);
	public List<UserMVo> getAthUserList(UserMVo param);
	public int insAthMenu(AuthMVo param);
	public int insAthUser(UserMVo param);
	public int updAthUser(UserMVo param); //유저의 권한 칼럼 값 부여
	public int updAthUser2(UserMVo param);//유저의 권한 칼럼 값 초기화
	public int updAthUser3(UserMVo param);//권한에 사용자 추가시 sy_author_emplyr 테이블에 이미 값이 있으면 권한 값만 수정
	public int updAthUserSS(UserMVo param);
	public int delAthMenu(AuthMVo param);
	public int delAthUser(UserMVo param);
	public int checkAuthUser(UserMVo param); //sy_author_emplyr테이블에 이미 값이 있는지 체크
	public int upsAthGroup(AuthMVo param);
	public int insAthGroup(AuthMVo param);
	public int updAthGroup(AuthMVo param);
	//Audit 생성
	public int insertAudit(AuditVo vo);

}
