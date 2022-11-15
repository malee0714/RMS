package lims.sys.vo;

public class NoticeWriteMVo {
	/*  SY_BBS_SNTNC VO  */
	private int sntncSeqno;            /* 글 일련번호 */
	private String bbsCode;            /* 게시판 코드 */
	private String wrterId;            /* 작성자 ID */
	private String wrterNm;            /* 작성자 명 */
	private String writngDe;            /* 작성 일 */
	private String sj;            /* 제목 */
	private String cn;            /* 내용 */
	private byte[] blobCn;				/*blob 내용*/
	private String email;            /* 이메일 */
	private String inqireCnt;            /* 조회 카운트 */
	private String popupAt;            /* 팝업 여부 */
	private String popupBeginDe;            /* 팝업 시작 일 */
	private String popupEndDe;            /* 팝업 종료 일 */
	private String atchmnflSeqno;            /* 첨부파일 일련번호 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String authorCd;

	/* SY_BBS_ANSWER VO */
	//private String sntncCode;            /* 글 코드 */
	private String answerSeqno;            /* 답변 일련번호 */
	private String answrrId;            /* 답변자 ID */
	private String answerCn;            /* 답변 내용 */
	private byte[] blobAnswerCn;		/* BLOB 답변 */
	private String answerDe;            /* 답변 일 */
	//private String deleteAt;            /* 삭제 여부 */
	//private String lastChangerId;            /* 최종 변경자 ID */
	//private String lastChangeDt;            /* 최종 변경 일시 */


	/* 변수 */
	private String gridCrud; 	/*CRUD 구분*/
	private String bbsCodeSch; /* 게시판코드 검색어 */
	private String sjSch;  	/*제목 검색어*/
	private String wrterIdSch;  	/*작성자 검색어*/
	private String writngDeStart;  	/*시작일 검색어*/
	private String writngDeFinish;	/*종료일 검색어*/
	private String key;			/*콤보 바인드 key*/
	private String value;		/*콤보 바인드 value*/
	private String answerCnt; /* 답변 카운트 */
	private String answerAt;            /* 답변 여부 */
	private String userSntncwriteAt;            /* 이용자 글쓰기 여부 */
	private String atchmnflAt;            /* 첨부파일 여부 */

	public byte[] getBlobAnswerCn() {
		return blobAnswerCn;
	}
	public void setBlobAnswerCn(byte[] blobAnswerCn) {
		this.blobAnswerCn = blobAnswerCn;
	}
	public byte[] getBlobCn() {
		return blobCn;
	}
	public void setBlobCn(byte[] blobCn) {
		this.blobCn = blobCn;
	}
	public int getSntncSeqno() {
		return sntncSeqno;
	}
	public void setSntncSeqno(int sntncSeqno) {
		this.sntncSeqno = sntncSeqno;
	}
	public String getBbsCode() {
		return bbsCode;
	}
	public void setBbsCode(String bbsCode) {
		this.bbsCode = bbsCode;
	}
	public String getWrterId() {
		return wrterId;
	}
	public void setWrterId(String wrterId) {
		this.wrterId = wrterId;
	}
	public String getWrterNm() {
		return wrterNm;
	}
	public void setWrterNm(String wrterNm) {
		this.wrterNm = wrterNm;
	}
	public String getWritngDe() {
		return writngDe;
	}
	public void setWritngDe(String writngDe) {
		this.writngDe = writngDe;
	}
	public String getSj() {
		return sj;
	}
	public void setSj(String sj) {
		this.sj = sj;
	}
	public String getCn() {
		return cn;
	}
	public void setCn(String cn) {
		this.cn = cn;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getInqireCnt() {
		return inqireCnt;
	}
	public void setInqireCnt(String inqireCnt) {
		this.inqireCnt = inqireCnt;
	}
	public String getPopupAt() {
		return popupAt;
	}
	public void setPopupAt(String popupAt) {
		this.popupAt = popupAt;
	}
	public String getPopupBeginDe() {
		return popupBeginDe;
	}
	public void setPopupBeginDe(String popupBeginDe) {
		this.popupBeginDe = popupBeginDe;
	}
	public String getPopupEndDe() {
		return popupEndDe;
	}
	public void setPopupEndDe(String popupEndDe) {
		this.popupEndDe = popupEndDe;
	}
	public String getAtchmnflSeqno() {
		return atchmnflSeqno;
	}
	public void setAtchmnflSeqno(String atchmnflSeqno) {
		this.atchmnflSeqno = atchmnflSeqno;
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
	public String getAnswerSeqno() {
		return answerSeqno;
	}
	public void setAnswerSeqno(String answerSeqno) {
		this.answerSeqno = answerSeqno;
	}
	public String getAnswrrId() {
		return answrrId;
	}
	public void setAnswrrId(String answrrId) {
		this.answrrId = answrrId;
	}
	public String getAnswerCn() {
		return answerCn;
	}
	public void setAnswerCn(String answerCn) {
		this.answerCn = answerCn;
	}
	public String getAnswerDe() {
		return answerDe;
	}
	public void setAnswerDe(String answerDe) {
		this.answerDe = answerDe;
	}
	public String getGridCrud() {
		return gridCrud;
	}
	public void setGridCrud(String gridCrud) {
		this.gridCrud = gridCrud;
	}
	public String getBbsCodeSch() {
		return bbsCodeSch;
	}
	public void setBbsCodeSch(String bbsCodeSch) {
		this.bbsCodeSch = bbsCodeSch;
	}
	public String getSjSch() {
		return sjSch;
	}
	public void setSjSch(String sjSch) {
		this.sjSch = sjSch;
	}
	public String getWrterIdSch() {
		return wrterIdSch;
	}
	public void setWrterIdSch(String wrterIdSch) {
		this.wrterIdSch = wrterIdSch;
	}
	public String getWritngDeStart() {
		return writngDeStart;
	}
	public void setWritngDeStart(String writngDeStart) {
		this.writngDeStart = writngDeStart;
	}
	public String getWritngDeFinish() {
		return writngDeFinish;
	}
	public void setWritngDeFinish(String writngDeFinish) {
		this.writngDeFinish = writngDeFinish;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getAnswerCnt() {
		return answerCnt;
	}
	public void setAnswerCnt(String answerCnt) {
		this.answerCnt = answerCnt;
	}
	public String getAnswerAt() {
		return answerAt;
	}
	public void setAnswerAt(String answerAt) {
		this.answerAt = answerAt;
	}
	public String getUserSntncwriteAt() {
		return userSntncwriteAt;
	}
	public void setUserSntncwriteAt(String userSntncwriteAt) {
		this.userSntncwriteAt = userSntncwriteAt;
	}
	public String getAtchmnflAt() {
		return atchmnflAt;
	}
	public void setAtchmnflAt(String atchmnflAt) {
		this.atchmnflAt = atchmnflAt;
	}
	public String getAuthorCd() {
		return authorCd;
	}
	public void setAuthorCd(String authorCd) {
		this.authorCd = authorCd;
	}


}
