package lims.com.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lims.util.CustomException;
import lombok.*;

import java.util.List;

@Getter @Setter
@Builder @AllArgsConstructor @NoArgsConstructor
public class CmSanctn extends BaseDto {
	private Integer sanctnSeqno; // 결재 일련번호
	private Integer sanctnRecommanId; // 결재 상신자 ID
	private String sanctnRecommanNm; // 결재 상신자
	private String sanctnRecomDte; // 결재 상신 일자
	private String sanctnKndCode; // ZCM05 결재 종류 코드
	private String sanctnKndCodeNm; // ZCM05 결재 종류 코드 명
	private String sanctnProgrsSittnCode; // ZCM01 결재 진행 상황 코드
	private String sanctnProgrsSittnCodeNm; // ZCM01 결재 진행 상황 코드 명
	private Integer cnSeqno; // 내용 일련번호
	private String sanctnerNm; // 결재자
	
	// cm cn table
	private String sj;  // cm 제목
	private String cn;  // cm 내용

	private List<CmSanctnInfo> sanctnInfoList; // 결재자 리스트

	@JsonIgnore
	public boolean isSanctnNew() {
		this.saveValidation();
		return this.sanctnSeqno == null;
	}

	@JsonIgnore
	public boolean cnInsertAble() {
		return (this.sj != null && !this.sj.equals("")) && (this.cn != null && !this.cn.equals(""));
	}
	
	@JsonIgnore
	public Integer progrsToNumber() {
		return Integer.valueOf(this.sanctnProgrsSittnCode.substring(this.sanctnProgrsSittnCode.length() - 2));
	}
	
	@JsonIgnore
	public void sanctnApprovalValidation() {
		// 진행상황이 작성중 이후인데 반려가 아니면
		final Integer progrsToNumber = this.progrsToNumber();
		if (progrsToNumber > 1 && progrsToNumber != 4) {
			throw new CustomException("이미 결재상신 되었습니다. 다시 조회해 주세요.");
		}
		
		// 내용이 없으면
		if (this.cnSeqno == null) {
			throw new CustomException("결재상신시 제목, 내용 데이터는 필수 입력값 입니다.");
		}
	}

	@JsonIgnore
	public void sanctnConfirmValidation() {
		
		if (this.cnSeqno == null) {
			throw new CustomException("결재 내용 없이는 결재상신할 수 없습니다.");
		}
		
		// 진행상황이 반려이거나, 결재완료이면
		if (this.progrsToNumber() != 2) {
			throw new CustomException("이미 결재 되었거나, 반려 되었습니다. 다시 조회해 주세요.");
		}
	}

	@JsonIgnore
	public void sanctnRevertValidation() {
		// 진행상황이 결재대기가 아니면
		if (this.progrsToNumber() != 2) {
			throw new CustomException("결재 진행상태가 '결재대기'일 때 회수할 수 있습니다. 다시 조회해 주세요.");
		}
	}

	// 저장 validation
	@JsonIgnore
	public void saveValidation() {
		if (this.sanctnKndCode == null) {
			throw new IllegalStateException("결재 종류 코드는 필수 입력값 입니다.");
		}
	}
}
