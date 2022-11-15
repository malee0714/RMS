package lims.sys.vo;

public class CanisterNoMVo {
	private String canNoSeqno;            /* CAN NO 일련번호 */
	private String deptCode;            /* 부서 코드 */
	private String canNo;            /* CAN NO */
	private String useAt;            /* 사용 여부 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	
	//검색조건
	private String deptCodeSch;
	private String canNoSch;
	private String useAtSch;
	
	//저장 중복 리턴값
	private String canNoChk;
	
	
		
	

	
	
	public String getCanNoChk() {
		return canNoChk;
	}
	public void setCanNoChk(String canNoChk) {
		this.canNoChk = canNoChk;
	}
	public String getDeptCodeSch() {
		return deptCodeSch;
	}
	public void setDeptCodeSch(String deptCodeSch) {
		this.deptCodeSch = deptCodeSch;
	}
	public String getCanNoSch() {
		return canNoSch;
	}
	public void setCanNoSch(String canNoSch) {
		this.canNoSch = canNoSch;
	}
	public String getUseAtSch() {
		return useAtSch;
	}
	public void setUseAtSch(String useAtSch) {
		this.useAtSch = useAtSch;
	}
	public String getCanNoSeqno() {
		return canNoSeqno;
	}
	public void setCanNoSeqno(String canNoSeqno) {
		this.canNoSeqno = canNoSeqno;
	}
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	public String getCanNo() {
		return canNo;
	}
	public void setCanNo(String canNo) {
		this.canNo = canNo;
	}
	public String getUseAt() {
		return useAt;
	}
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	public String getDeleteAt() {
		return deleteAt;
	}
	public void setDeleteAt(String deleteAt) {
		this.deleteAt = deleteAt;
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

	
}
