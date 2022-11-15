package lims.com.vo;

public class ExcpLogVo {
	private String excpLogSeqno;			/* 예외 로그 일련번호 */
	private String url;			/* URL */
	private String excpNm;			/* 예외 명 */
	private String excpCn;			/* 예외 내용 */
	private String excpTraceCn;			/* 예외 추적 내용 */
	private String lastChangerId;			/* 최종 변경자 ID */
	private String lastChangeDt;			/* 최종 변경 일시 */
	public String getExcpLogSeqno() {
		return excpLogSeqno;
	}
	public void setExcpLogSeqno(String excpLogSeqno) {
		this.excpLogSeqno = excpLogSeqno;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getExcpNm() {
		return excpNm;
	}
	public void setExcpNm(String excpNm) {
		this.excpNm = excpNm;
	}
	public String getExcpCn() {
		return excpCn;
	}
	public void setExcpCn(String excpCn) {
		this.excpCn = excpCn;
	}
	public String getExcpTraceCn() {
		return excpTraceCn;
	}
	public void setExcpTraceCn(String excpTraceCn) {
		this.excpTraceCn = excpTraceCn;
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
