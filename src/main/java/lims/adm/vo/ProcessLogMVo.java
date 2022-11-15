package lims.adm.vo;

import lombok.Data;

@Data
public class ProcessLogMVo {

	private String histSeqno;            /* 이력 일련번호 */
	private String histSeCode;            /* ZCM03 이력 구분 코드 */
	private String histSeNm;            /* ZCM03 이력 구분 명 */
	private String menuUrl;            /* 메뉴 URL */
	private String changeAfterCn;            /* 변경 이후 내용 */
	private String changerId;            /* 변경자 ID */
	private String histPblicteDt;            /* 이력 발행 일시 */
	private String reqestSeqno;            /* 의뢰 일련번호 */
	private String expriemSeqno;            /* 시험항목 일련번호 */
	private String conectIp;            /* 접속IP */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String exprOdr;            /* 시험 차수 */
	private String exprNumot;            /* 시험 횟수 */
	private String processNm;            /* 처리 명 */
	
	//조회조건
	private String histSeCodeSch;
	private String processNmSch;
	private String lotIdSch;
	private String histPblicteStartDt;
	private String histPblicteEndDt;
	private String inspctInsttCode;
	
	//기타 변수
	private String lotNo;
	private String mtrilNm;
	private String userNm;

}
