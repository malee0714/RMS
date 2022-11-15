package lims.adm.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ErrorLogMVo {
	private String excpLogSeqno;            /* 예외 로그 일련번호 */
	private String url;                     /* URL */
	private String dvlprDc;                 /* 개발자 설명 */
	private String excpNm;                  /* 예외 명 */
	private String excpCn;                  /* 예외 내용 */
	private String excpTraceCn;             /* 예외 추적 내용 */
	private String vriablCn;                /* 변수 내용 */
	private String lastChangerId;           /* 최종 변경자 ID */
	private String lastChangerNm;           /* 최종 변경자명 */
	private String lastChangeDt;            /* 최종 변경 일시 */
	
	/* 조회폼 */
	private String changeDteSch;            /* 발생 시작일 */
	private String changeDteFinish;         /* 발생 종료일 */
	private String excpLogSeqnoSch;         /* 에러 번호 */
}
