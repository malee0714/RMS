package lims.wrk.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 
 * Spc 관리 기준그룹별, 자재별 기준규격.
 * 
 * @author shs
 * @table SY_SPS_MANAGE_EXPRIEM
 * 
 */
@Getter
@Setter
@ToString
public class TrendSpcExprVO {
	private String spcManageSeqno; 	// SPC 관리 일련번호
	private String mtrilSdspcSeqno; // 자재 기준 seano
	private String sdspcNm;			// 기준 명
	private String expriemNm;		// 시험항목 명
	private String lastChangerId;
	private String lastChangeDt;
}
