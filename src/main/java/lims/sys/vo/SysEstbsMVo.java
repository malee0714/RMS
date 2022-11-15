package lims.sys.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class SysEstbsMVo {
	private int bplcCo;                       // 사업장 수
	private String loginFailrLockAt;		  // 로그인 실패 잠금 여부
	private int loginFailrLockNumot;   		  // 로그인 실패 잠금 횟수
	private String initlPassword;			  // 초기화 비밀번호
	private String passwordPolicyExecutAt;    // 비밀번호 정책 실행 여부
	private int passwordMxmmCphr;             // 비밀번호 최대 자리수
	private String passwordSpclChrctrInclsAt; // 비밀번호 특수 문자 포함 여부
	private String passwordNumberInclsAt;     // 비밀번호 숫자 포함 여부
	private String passwordUpprsInclsAt;      // 비밀번호 대문자 포함 여부
	private String ctmmnyCntrmsrAt;			  // 고객사 대응 여부
}
