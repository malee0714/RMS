package lims.com.dao;

import java.util.List;

import lims.com.vo.ComboVo;
import lims.sys.vo.CmmnCodeMVo;
import lims.sys.vo.InsttMVo;
import lims.sys.vo.UserMVo;

public interface IgnoreServletUrlDao {

	//권한 코드
	List<ComboVo> getBplcCode(InsttMVo param);

	//부서 코드
	List<ComboVo> getDeptCode(InsttMVo param);
	
	//직위,직급 콤보
	List<ComboVo> getOfcpsAndClsfCode(CmmnCodeMVo vo);
	
	//신규 사용자 등록
	int insUserJoin(UserMVo param);

	//로그인아이디 중복체크
	List<String> getLoginIdList();

	//비밀번호 정책
	UserMVo getPasswordPolicy();

	int insAthUser(UserMVo param);
	String findAuthorCode(UserMVo param);
}
