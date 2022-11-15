package lims.sys.dao;

import lims.sys.vo.InsttMVo;
import lims.sys.vo.UserMVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMDao {

	public String getUserBplcCode(UserMVo vo);

	//부서 콤보박스
	public List<UserMVo> getDeptComboList(UserMVo vo);

	//사용자 조회 및 가입승인 대기 사용자 조회
	public List<UserMVo> getUserMList(UserMVo vo);
	
	//사용안함
	public int updNotUse(UserMVo vo);
	
	//6개월 이상 미접속자 조회
	public List<UserMVo> getNotLoginSixMonth();
	
	//가입승인
	public int updSbscrbConfm(UserMVo vo);

	//비밀번호 초기화
	public int updResetPassword(UserMVo vo);
	
	//초기화 비밀번호 가져오기
	public String getIntlPw();
	
	public List<UserMVo> getAuthorSeCode(UserMVo vo);

	public List<InsttMVo> getInspctCode(InsttMVo vo);

	public List<UserMVo> getSignAtchmnflSeqno(UserMVo vo);

	public List<UserMVo> getUserNm(UserMVo vo);

	public int getLoginIdChk(UserMVo vo);

	public int insUserM(UserMVo vo);

	public int updUserM(UserMVo vo);

	public int deleteUserInfo(UserMVo vo);

	public List<UserMVo> getUserAuthList(UserMVo vo);

	public int insAuthorTrgter(UserMVo vo);

	//고객사권한이 아닌경우 SY부서별 권한 대상자 테이블 사용여부 'N'
	public void upd04LowerAuthorTrgter(UserMVo vo);

	//SY부서별 권한 대상자 테이블에 권한 추가
	public void updAuthorTrgter(UserMVo vo);

	/* 권한변경 팝업관련 DAO */
	//부서별 고객사  삭제
	public int delCustomerResult(UserMVo vo);

	//권한 삭제
	public int delAuthTrg(UserMVo removeGridDlivyMVo);

	//부서별 고객사 저장
	public int upCustomerResult(UserMVo vo);

	//기존에 등록되어있는 부서별 권한 사용여부 'N'
	public int useAuthTrg(UserMVo gridDlivyMVo);

	//권한 추가
	public int insAuthTrg(UserMVo gridDlivyMVo);

	//권한 수정
	public int upAuthTrg(UserMVo gridDlivyMVo);

}
