package lims.qa.vo;

import lims.com.vo.CmSanctn;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class SanctnManageDto extends CmSanctn {
	private Integer ordr; // 순서 
	private Integer sanctnOrdr; // 결재 순서 
	private String sanctnRecomBeginDte; // 결재 상신 시작일
	private String sanctnRecomEndDte; // 결재 상신 종료일
	private String rtnResn; // 반려사유
	
	
	public boolean validation() {
		if (this.ordr == null || this.sanctnOrdr == null) {
			throw new IllegalStateException("결재상신 정보가 정확하지 않습니다. 관리자에게 문의하세요.");
		}
		return true;
	}
}
