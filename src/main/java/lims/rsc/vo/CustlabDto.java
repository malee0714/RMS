package lims.rsc.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter @Setter
public class CustlabDto extends BaseCustlabDto {
	
	private String custlabNm;           // 분석실 명
	private String creatYear;           // 생성 년도
	private Integer manageRspnberJId;   // 관리 책임자_정 ID
	private Integer manageRspnberBId;   // 관리 책임자_부 ID
	private String manageRspnberJungNm; // 관리 책임자_정 이름
	private String manageRspnberBuNm;   // 관리 책임자_부 이름
	private String workersNm;           // 근무자
	private String chrgDeptCode;        // 관리 부서 코드
	private String opratnAt;            // 운용 여부
	private Integer atchmnflSeqno;      // 첨부파일 일련번호
	private String rm;                  // 비고

	private String chrgDeptNm;
	private Integer yearCnt;

	private List<CustlabWorkerDto> workers;
	private List<CustlabWorkerDto> removedWorkers;
	private List<CustlabProductDto> products;
	private List<CustlabProductDto> removedProducts;
	private List<CustlabExpriemDto> dayExpriems;
	private List<CustlabExpriemDto> removedDayExpriems;
	
	private String mtrilNm;             // 제품 명
	private String prductSeCode;        // 제품 구분
	private Integer exprCount;          // 일상점검 시험항목 수
	
	@JsonIgnore
	public boolean isNew() {
		return super.getCustlabSeqno() == null;
	}

	@Override
	public String toString() {
		return super.toString() +
				"\nCustlabDto{" +
				"custlabNm='" + custlabNm + '\'' +
				", creatYear='" + creatYear + '\'' +
				", manageRspnberJId=" + manageRspnberJId +
				", manageRspnberBId=" + manageRspnberBId +
				", manageRspnberJungNm='" + manageRspnberJungNm + '\'' +
				", manageRspnberBuNm='" + manageRspnberBuNm + '\'' +
				", workersNm='" + workersNm + '\'' +
				", chrgDeptCode='" + chrgDeptCode + '\'' +
				", opratnAt='" + opratnAt + '\'' +
				", atchmnflSeqno=" + atchmnflSeqno +
				", rm='" + rm + '\'' +
				", workers=" + workers +
				", removedWorkers=" + removedWorkers +
				", products=" + products +
				", removedProducts=" + removedProducts +
				", dayExpriems=" + dayExpriems +
				", removedDayExpriems=" + removedDayExpriems +
				", mtrilNm='" + mtrilNm + '\'' +
				", prductSeCode='" + prductSeCode + '\'' +
				'}';
	}
}
