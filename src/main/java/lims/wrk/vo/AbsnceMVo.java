package lims.wrk.vo;

import java.util.List;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AbsnceMVo {
	private String absnceSeqno;		/* 부재 일련번호 */
	private String absntId;			/* 부재자 ID */
	private String absntNm;			/* 부재자 명 */
	private String absntDeptNm;			/* 부서자 부서 */
 	
	private String agncymanId;			/* 대리자 ID */
	private String agncymanDeptNm;		/* 대리자 부서 */
	private String agncymanNm;			/* 대리자 명 */
	private String absnceSttusNm;		

	private String absnceSttusCode;			/* ZIM15_부재 상태 코드 */
	private String absnceBeginDt;			/* 부재 시작 일시 */
	private String absnceEndDt;			/* 부재 종료 일시 */
	private String absnceResn;			/* 부재 사유 */
	private String deleteAt;			/* 삭제 여부 */
	private String lastChangerId;			/* 최종 변경자 ID */
	private String lastChangeDt;			/* 최종 변경 일시 */

	private String txtabsntNm, absnceSttus, absnceSttusCodee ;
	

}
