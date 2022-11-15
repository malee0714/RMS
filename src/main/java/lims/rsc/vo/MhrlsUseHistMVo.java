package lims.rsc.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class MhrlsUseHistMVo {
	private String mhrlsOprSploreSeqno;            /* 기기 가동 시료 일련번호 */
	private String mhrlsSeqno;            /* 기기 일련번호 */
	private String mhrlsNm;            /* 기기 명 */
	private String brcd;            /* 바코드 */
	private String expriemNm;            /* 시험항목 명 */
	private String oprDte;            /* 가동 일자 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String useCnt;
	private String chkStat;
	private String[] list;
	
	//조회 조건
	private String shrUseBeginDte;
	private String shrUseEndDte;
	private String shrMhrlsSeqno;
	private String shrMhrlsNm;
	private String schChrgTeamSeCode;
	private String type;

}
