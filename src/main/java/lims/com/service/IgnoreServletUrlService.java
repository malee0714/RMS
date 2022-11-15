package lims.com.service;

import java.util.List;

import lims.com.vo.ComboVo;
import lims.sys.vo.CmmnCodeMVo;
import lims.sys.vo.InsttMVo;
import lims.sys.vo.UserMVo;

public interface IgnoreServletUrlService {

	//권한 코드
	List<ComboVo> getBplcCode(InsttMVo param);

	//부서 코드
	List<ComboVo> getDeptCode(InsttMVo param);
	
	//직위,직급 콤보
	List<ComboVo> getOfcpsAndClsfCode(CmmnCodeMVo vo);
	
	//신규 사용자 등록
	int insUserJoin(UserMVo param);

	//화면에 비밀번호정책을 알려주기위한 문자열 조회
	UserMVo getPasswordPolicyString();
}
