package lims.com.vo;

public class CmFileInfoVo {

	private int fileIdx;/*첨부파일IDX*/
	private int fileSeq;/*일련번호*/
	private String fileCtg;/*첨부파일구분*/
	private String fileNm;/*파일명*/
	private long fileSize;/*파일사이즈*/
	private String filePath;/*저장파일경로*/
	private String delYn;/*삭제여부YN_Y삭제*/
	private String udtId;/*수정자ID*/
	private String udtDate;/*수정일*/
	private int ord;/*파일정렬순서*/
	private String uuid;
	
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public int getFileIdx() {
		return fileIdx;
	}
	public void setFileIdx(int fileIdx) {
		this.fileIdx = fileIdx;
	}
	public int getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(int fileSeq) {
		this.fileSeq = fileSeq;
	}
	public String getFileCtg() {
		return fileCtg;
	}
	public void setFileCtg(String fileCtg) {
		this.fileCtg = fileCtg;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getUdtId() {
		return udtId;
	}
	public void setUdtId(String udtId) {
		this.udtId = udtId;
	}
	public String getUdtDate() {
		return udtDate;
	}
	public void setUdtDate(String udtDate) {
		this.udtDate = udtDate;
	}
	public int getOrd() {
		return ord;
	}
	public void setOrd(int ord) {
		this.ord = ord;
	}
}
