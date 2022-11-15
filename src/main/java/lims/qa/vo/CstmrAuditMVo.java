package lims.qa.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CstmrAuditMVo {

	/*RS_AUDIT*/
	private String auditSeqno;            /* 감사 일련번호 */
	private String wdtbSeqno;
	private String entrpsSeCode;            /* ZSY08 업체 구분 코드 */
	private String sj;            /* 제목 */
	private String auditRceptNo;            /* 감사 접수 번호 */
	private String reformNo;            /* 개정 번호 */
	private String writngDeptCode;            /* 작성 부서 코드 */
	private String wrterId;            /* 작성자 ID */
	private String writngDte;            /* 작성 일자 */
	private String fdrmAt;            /* 정기 여부 */
	private String fdrmGubun;
	private String auditOprtnMthCode;            /* ZRS11 감사 실시 방법 코드 */
	private String entrpsSeqno;            /* 업체 일련번호 */
	private String entrpsNm;
	private String mtrilSeqno;            /* 자재 일련번호 */
	private String mtrilNm;
	private String auditCn;            /* 감사 내용 */
	private String auditPurps;            /* 감사 목적 */
	private String adtrNm;            /* 감사관 명 */
	private String visitBeginDte;            /* 방문 시작 일자 */
	private String visitEndDte;            /* 방문 종료 일자 */
	private String lgstrMatterNum;            /* 지적 사항 건수 */
	private String lgstrMatterSemiNum;            /* 지적 사항 SEMI 건수 */
	private String lgstrMatterSum;
	private String rcmndMatterNum;            /* 권고 사항 건수 */
	private String auditSumry;            /* 감사 요약 */
	private String chklstAtchmnflSeqno;            /* 체크리스트 첨부파일 일련번호 */
	private String atchmnflSeqno;            /* 첨부파일 일련번호 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */

	/*검색조건*/
	private String schEntrpsNm;
	private String schWritngStDte;
	private String schWritngEndDte;
	private String schMtrilNm;
	private String schAuditRceptNo;
}
