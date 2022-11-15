package lims.rsc.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter @Setter
public class CustlabEdayChckRegistDto extends BaseCustlabDto{

	private Integer custlabEdayChckRegistSeqno;
	private Integer insctrId;
	private String insctrNm;
	private String chckDte;
	private String jdgmntWordCode;
	private String jdgmntWordCodeNm;
	private String rm;
	
	private String startChckDte;
	private String endChckDte;
	private String custlabNm;
	private String mtrilNm;
	private String manageRspnberJungNm; // 관리 책임자_정 이름
	private String manageRspnberBuNm;   // 관리 책임자_부 이름
	private Integer exprCount;

	private List<CustlabEdayChckResultDto> everyDayExprResultList;
	
	@JsonIgnore
	public boolean isNew() {
		super.custlabValidation();
		return this.custlabEdayChckRegistSeqno == null;
	}
	
	public void deleteValidation() {
		if (this.custlabEdayChckRegistSeqno == null) {
			throw new IllegalStateException("분석실 일상 점검 정보 없이 삭제할 수 없습니다.");
		}
	}

	@Override
	public String toString() {
		return super.toString() +
				"\nCustlabEdayChckRegistDto{" +
				"custlabEdayChckRegistSeqno=" + custlabEdayChckRegistSeqno +
				", insctrId=" + insctrId +
				", chckDte='" + chckDte + '\'' +
				", jdgmntWordCode='" + jdgmntWordCode + '\'' +
				", rm='" + rm + '\'' +
				", startChckDte='" + startChckDte + '\'' +
				", endChckDte='" + endChckDte + '\'' +
				", everyDayExprResultList=" + everyDayExprResultList +
				'}';
	}
}
