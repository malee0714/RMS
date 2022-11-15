package lims.req.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RohsRequestMVo {
	private String rohsReqestSeqno;            /* ROHS 의뢰 일련번호 */
	private String rohsSeqno;            /* ROHS 일련번호 */
	private String clientId;            /* 의뢰자 ID */
	private String analsReqestDte;            /* 분석 의뢰 일자 */
	private String atchmnflSeqno;            /* 첨부파일 일련번호 */
	private String useAt;            /* 사용 여부 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	
	//검색
	private String rohsNm;         
	private String analsReqestCycle;
	private String requestCycleNm; 
	private String rohsNmSch;
	private String calcDate;
	private String calD;
	private String analsReqestCycleCode;
	private String userNm;   
	private String clientIdSch;
	private String analsReqestDteSch;
	private String analsReqestDteFinish;

	
	
}
