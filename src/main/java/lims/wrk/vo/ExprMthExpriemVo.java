package lims.wrk.vo;

public class ExprMthExpriemVo extends ExprMthMVo {
	private String expriemCode;			/* 시험항목 코드 */
	private String sortOrdr;			/* 정렬 순서 */
	
	public String getExpriemCode() {
		return expriemCode;
	}
	public void setExpriemCode(String expriemCode) {
		this.expriemCode = expriemCode;
	}
	public String getSortOrdr() {
		return sortOrdr;
	}
	public void setSortOrdr(String sortOrdr) {
		this.sortOrdr = sortOrdr;
	}

}
