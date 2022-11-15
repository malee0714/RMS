package lims.com.vo;

public class EmailVo {
	String cc; // 참조
	String to; // 보낼사람
	String smpIdx;
	int entSeq;
	String orgCd; // 의뢰기관 코드
	String orgNm;
	String reqNm;
	String sexMfc;
	String reqDt;
	String smpMngNo;
	String cstMngNo;
	
	String subject;
	String msg;
	
	public int getEntSeq() {
		return entSeq;
	}
	public void setEntSeq(int entSeq) {
		this.entSeq = entSeq;
	}
	public String getSmpIdx() {
		return smpIdx;
	}
	public void setSmpIdx(String smpIdx) {
		this.smpIdx = smpIdx;
	}
	public String getOrgNm() {
		return orgNm;
	}
	public void setOrgNm(String orgNm) {
		this.orgNm = orgNm;
	}
	public String getReqNm() {
		return reqNm;
	}
	public void setReqNm(String reqNm) {
		this.reqNm = reqNm;
	}
	public String getSexMfc() {
		return sexMfc;
	}
	public void setSexMfc(String sexMfc) {
		this.sexMfc = sexMfc;
	}
	public String getReqDt() {
		return reqDt;
	}
	public void setReqDt(String reqDt) {
		this.reqDt = reqDt;
	}
	public String getSmpMngNo() {
		return smpMngNo;
	}
	public void setSmpMngNo(String smpMngNo) {
		this.smpMngNo = smpMngNo;
	}
	public String getCstMngNo() {
		return cstMngNo;
	}
	public void setCstMngNo(String cstMngNo) {
		this.cstMngNo = cstMngNo;
	}
	public String getOrgCd() {
		return orgCd;
	}
	public void setOrgCd(String orgCd) {
		this.orgCd = orgCd;
	}
	public String getCc() {
		return cc;
	}
	public void setCc(String cc) {
		this.cc = cc;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	
}
