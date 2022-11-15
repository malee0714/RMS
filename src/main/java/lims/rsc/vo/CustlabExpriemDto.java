package lims.rsc.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CustlabExpriemDto extends BaseCustlabDto {
	private Integer custlabChckExpriemSeqno;    // 분석실 점검 시험항목 일련번호
	private Integer expriemSeqno;               // 시험항목 일련번호
	private String jdgmntFomCode;               // ZIM06 판정 형식 코드
	private String mummValue;                   // 최소 값
	private String mummValueSeCode;             // ZIM08 최소 값 구분 코드
	private String mxmmValue;                   // 최대 값
	private String mxmmValueSeCode;             // ZIM07 최대 값 구분 코드
	private String textStdr;                    // 텍스트 기준
	private String unitSeqno;                   // 단위 일련번호
	private Integer sortOrdr;                   // 정렬 순서
	private String expriemNm;                   // 시험항목 명

	private String unitNm;
	private String jdgmntFomCodeNm;
	private String expriemSdspc;

	@JsonIgnore
	public boolean isNew() {
		super.custlabValidation();
		return this.custlabChckExpriemSeqno == null;
	}
	
	@Override
	public String toString() {
		return super.toString() + 
				"\nCustlabCheckExpriemDto{" +
				"custlabChckExpriemSeqno=" + custlabChckExpriemSeqno +
				", expriemSeqno=" + expriemSeqno +
				", jdgmntFomCode='" + jdgmntFomCode + '\'' +
				", mummValue='" + mummValue + '\'' +
				", mummValueSeCode='" + mummValueSeCode + '\'' +
				", mxmmValue='" + mxmmValue + '\'' +
				", mxmmValueSeCode='" + mxmmValueSeCode + '\'' +
				", textStdr='" + textStdr + '\'' +
				", unitSeqno='" + unitSeqno + '\'' +
				", sortOrdr=" + sortOrdr +
				", expriemNm='" + expriemNm + '\'' +
				'}';
	}
}
