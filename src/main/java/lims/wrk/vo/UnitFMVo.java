package lims.wrk.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UnitFMVo {
	
	private String unitSeqno;			/* 단위 코드 */
	private String unitNm;			/* 단위 명 */
	private String unitSeCode;			/* ZSS02_단위 구분 코드 */
	private String unitSe;			/* 단위 구분 */
	private String useAt;			/* 사용 여부 */
	private String lastChangerId;			/* 최종 변경자 ID */
	private String lastChangeDt;			/* 최종 변경 일시 */
	
	private String cboUnitSe, txtUnitNM, useAtSearch;
	
}
