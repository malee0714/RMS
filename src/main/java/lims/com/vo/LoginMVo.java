package lims.com.vo;

public class LoginMVo {
//	String jntIdx; // 접속이력 idx
//	String jntIo; // 접속구분IO_I로그인O로그아웃
//	String jntUserId; // 접속아이디
//	String jntDate;	//접속일시
//	String jntIp;	//ip
	
	String histSeqNo;
	String userId;
	String loginId;
	String loginIp;
	String loginDt;
	String logoutDt;
	String lastChangerId;
	String lastChangerDt;
	
	
	public String getHistSeqNo() {
		return histSeqNo;
	}
	public void setHistSeqNo(String histSeqNo) {
		this.histSeqNo = histSeqNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getLoginIp() {
		return loginIp;
	}
	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}
	public String getLoginDt() {
		return loginDt;
	}
	public void setLoginDt(String loginDt) {
		this.loginDt = loginDt;
	}
	public String getLogoutDt() {
		return logoutDt;
	}
	public void setLogoutDt(String logoutDt) {
		this.logoutDt = logoutDt;
	}
	public String getLastChangerId() {
		return lastChangerId;
	}
	public void setLastChangerId(String lastChangerId) {
		this.lastChangerId = lastChangerId;
	}
	public String getLastChangerDt() {
		return lastChangerDt;
	}
	public void setLastChangerDt(String lastChangerDt) {
		this.lastChangerDt = lastChangerDt;
	}
	
}
