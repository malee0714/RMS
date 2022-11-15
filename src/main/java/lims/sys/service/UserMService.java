package lims.sys.service;

import java.util.List;

import lims.sys.vo.InsttMVo;
import lims.sys.vo.UserMVo;

public interface UserMService {

	//부서 콤보박스
	public List<UserMVo> getDeptComboList(UserMVo vo);

	//사용자 조회
	public List<UserMVo> getUserMList(UserMVo vo);

	//사용안함
	public int updNotUse(List<UserMVo> list);
	
	//6개월 이상 미접속자 조회
	public List<UserMVo> getNotLoginSixMonth();
	
	//가입승인 대기 사용자 조회
	public List<UserMVo> getSbscrbConfmUserList(UserMVo vo);
	
	//가입승인
	public int updSbscrbConfm(List<UserMVo> list);

	//비밀번호 초기화
	public int updResetPassword(List<UserMVo> list);

	public List<UserMVo> getAuthorSeCode(UserMVo vo);

	public List<InsttMVo> getInspctCode(InsttMVo vo);

	public List<UserMVo> getSignAtchmnflSeqno(UserMVo vo);

	public int getLoginIdChk(UserMVo vo);

	public int putUserM(UserMVo vo);

	public String deleteUserInfo(UserMVo vo);

	//고객사 권한 사용자 목록 조회
	public List<UserMVo> getUserAuthList(UserMVo vo);

	//부서별 고객사 저장
	public int updCustomerResult(UserMVo vo);
}
