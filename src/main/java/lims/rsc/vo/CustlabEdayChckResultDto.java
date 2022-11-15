package lims.rsc.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lims.com.vo.BaseDto;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CustlabEdayChckResultDto extends BaseDto {

	private Integer custlabEdayChckRegistSeqno; // 분석실 일상 점검 등록 일련번호
	private Integer expriemSeqno; // 시험항목 일련번호
	private Integer unitSeqno; // 단위 일련번호
	private String jdgmntFomCode; // ZIM06 판정 형식 코드
	private String mummValue; // 최소 값
	private String mummValueSeCode; // ZIM08 최소 값 구분 코드
	private String mxmmValue; // 최대 값
	private String mxmmValueSeCode; // ZIM07 최대 값 구분 코드
	private String resultValue; // 결과 값
	private String jdgmntWordCode; // ZIM05 판정 용어 코드
	private String textStdr; // 텍스트 기준
	private String partclrMatter; // 특이 사항
	private String sortOrdr; // 정렬 순서

	private String unitNm;
	private String jdgmntFomCodeNm;
	private String jdgmntWordCodeNm;
	private String expriemSdspc;
	private String expriemNm;
	private String chckDte;
	private String rm;
	
	@JsonIgnore
	public boolean valid() {
		if (this.custlabEdayChckRegistSeqno == null) {
			throw new IllegalStateException("분석실 일상 점검 정보 없이 시험항목 결과값을 저장할 수 없습니다.");
		}
		if (this.expriemSeqno == null) {
			throw new IllegalStateException("시험항목 정보 없이 결과값을 저장할 수 없습니다.");
		}
		
		return true;
	}

	@Override
	public String toString() {
		return super.toString() + "\nCustlabEdayChckResultDto{" +
				"custlabEdayChckRegistSeqno=" + custlabEdayChckRegistSeqno +
				", expriemSeqno=" + expriemSeqno +
				", unitSeqno=" + unitSeqno +
				", jdgmntFomCode='" + jdgmntFomCode + '\'' +
				", mummValue='" + mummValue + '\'' +
				", mummValueSeCode='" + mummValueSeCode + '\'' +
				", mxmmValue='" + mxmmValue + '\'' +
				", mxmmValueSeCode='" + mxmmValueSeCode + '\'' +
				", resultValue='" + resultValue + '\'' +
				", jdgmntWordCode='" + jdgmntWordCode + '\'' +
				", textStdr='" + textStdr + '\'' +
				", partclrMatter='" + partclrMatter + '\'' +
				", sortOrdr='" + sortOrdr + '\'' +
				", unitNm='" + unitNm + '\'' +
				", jdgmntFomCodeNm='" + jdgmntFomCodeNm + '\'' +
				", expriemSdspc='" + expriemSdspc + '\'' +
				", expriemNm='" + expriemNm + '\'' +
				'}';
	}
}
