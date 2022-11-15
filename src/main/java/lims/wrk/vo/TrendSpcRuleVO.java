package lims.wrk.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * SPC 기준별 SPC rule
 * 
 * @author shs
 * @table SY_SPC_RULE
 */
@Getter
@Setter
@ToString
public class TrendSpcRuleVO {
	//SY_SPC_RULE
	private String spcManageSeqno;	// spc 관리 seqno
	private String ordr; 			// 순서
	private String spcRuleCode; 	// ZSY04 SPC 규칙 코드
	private String spcRuleCodeNm; 	// ZSY04 SPC 규칙 코드 명
	private String nvalue; 			// N 값
	private String lastChangerId; 	// 최종 변경자 ID
	private String lastChangeDt; 	// 최종 변경 일시

	public Integer parseIntegerN() {
		return (this.nvalue != null && !"".equals(this.nvalue)) ? Integer.parseInt(this.nvalue) : 0;
	}
}
