package lims.adm.vo;

public class LoginLogMVo {

	private String histSeqno;            /* 이력 일련번호 */
	private String loginId;            /* 로그인 ID */
	private String loginIp;            /* 로그인IP */
	private String loginDt;            /* 로그인 일시 */
	private String logoutDt;            /* 로그아웃 일시 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	
	private String inspctInsttCode;            /* 검사 기관 코드 */
	private String deptNm;            /* 검사 기관 명 */
	
	private String userNm;           /* 사용자명 */
	private String rcpDt1;			 /* 로그일자 시작일*/
	private String rcpDt2;			 /* 로그일자 종료일 */
	
	private String inspctInsttNm;
	
	public String getHistSeqno() {
		return histSeqno;
	}
	public void setHistSeqno(String histSeqno) {
		this.histSeqno = histSeqno;
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
	public String getLastChangeDt() {
		return lastChangeDt;
	}
	public void setLastChangeDt(String lastChangeDt) {
		this.lastChangeDt = lastChangeDt;
	}
	public String getInspctInsttCode() {
		return inspctInsttCode;
	}
	public void setInspctInsttCode(String inspctInsttCode) {
		this.inspctInsttCode = inspctInsttCode;
	}
	
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getRcpDt1() {
		return rcpDt1;
	}
	public void setRcpDt1(String rcpDt1) {
		this.rcpDt1 = rcpDt1;
	}
	public String getRcpDt2() {
		return rcpDt2;
	}
	public void setRcpDt2(String rcpDt2) {
		this.rcpDt2 = rcpDt2;
	}
	public String getInspctInsttNm() {
		return inspctInsttNm;
	}
	public void setInspctInsttNm(String inspctInsttNm) {
		this.inspctInsttNm = inspctInsttNm;
	}
	
	
	
	
	
}
