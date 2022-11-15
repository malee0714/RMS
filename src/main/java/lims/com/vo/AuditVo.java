package lims.com.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;


@Setter @Getter @Builder
@AllArgsConstructor
public class AuditVo {

	public AuditVo() {
	}

	private String histSeqno;            /* 이력 일련번호 */
	private String inspctInsttCode;      /* 검사 기관 코드 */
	private String histSeCode;           /* ZIM11_이력 구분 코드 */
	private String changeBfeCn;          /* 변경 전 내용 */
	private String changeAfterCn;        /* 변경 이후 내용 */
	private String changerId;            /* 변경자 ID */
	private String histPblicteDt;        /* 이력 발행 일시 */
	private String reqestSeqno;          /* 의뢰 일련번호 */
	private String sploreSeqno;          /* 시료 일련번호 */
	private String expriemSeqno;         /* 시험항목 일련번호 */
	private String testrgSeqno;          /* 시험기록부 일련번호 */
	private String conectIp;             /* 접속IP */
	private String rm;            		 /* 비고 */
	private String lastChangerId;        /* 최종 변경자 ID */
	private String lastChangeDt;         /* 최종 변경 일시 */
	private String histSeDetailCode;     /* ZIM35_이력 구분 상세 코드 */
	private String menuUrl;              /* 메뉴 URL */
	private String expriemCode;
	private String exprOdr;				 /* 시험 차수 */
	private String exprNumot;			 /* 시험 횟수*/
	private String processNm;			 /* 이벤트 명*/
	private String bplcCode;             /* 사업장  */
	
	private String key1;
	private String key2;
	private String key3;
	private String key4;
	private String key5;
	
	private String roaDataCnvrHistSeqno; /* ROA 데이터 변환 이력 일련번호 */
	private String roaDataCn; /* ROA 데이터 내용 */
	private String errorAt; /* 오류 여부 */


}
