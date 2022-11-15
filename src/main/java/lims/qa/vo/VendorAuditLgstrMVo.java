package lims.qa.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class VendorAuditLgstrMVo {
	private String auditCarSeqno;            /* 감사 CAR 일련번호 */
	private String auditSeqno;            /* 감사 일련번호 */
	private String carNo;            /* CAR NO */
	private String pblicteDte;            /* 발행 일자 */
	private String pblshrNm;            /* 발행자 명 */
	private String entrpsSeqno;            /* 업체 일련번호 */
	private String suplyEntrpsNm;            /* 공급 업체 명 */
	private String openAt;            /* OPEN 여부 */
	private String openAtNm;            /* OPEN 여부 */
	private String mngtDeptNm;            /* 주관 부서 명 */
	private String chckerNm;            /* 검토자 명 */
	private String pblicteEntrpsNm;            /* 발행 업체 명 */
	private String improptCn;            /* 부적합 내용 */
	private String improptCause;            /* 부적합 원인 */
	private String improptAtchmnflSeqno;            /* 부적합 첨부파일 일련번호 */
	private String imprvmBfeCn;            /* 개선 전 내용 */
	private String imprvmAfterCn;            /* 개선 후 내용 */
	private String corecManagtDte;            /* 시정 조치 일자 */
	private String corecChargerNm;            /* 시정 담당자 명 */
	private String effectVrifyCn;            /* 효과 검증 내용 */
	private String prevntManagtCn;            /* 예방 조치 내용 */
	private String managtResultDte;            /* 조치 결과 일자 */
	private String managtChargerNm;            /* 조치 담당자 명 */
	private String managtResultAtchmnflSeqno;            /* 조치 결과 첨부파일 일련번호 */
	private String managtResultChargerNm;            /* 조치 결과 담당자 명 */
	private String managtResultChckerNm;            /* 조치 결과 검토자 명 */
	private String managtResultConfmerNm;            /* 조치 결과 승인자 명 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */

	private String schEntrpsNm;
	private String schPblicteStDte;
	private String schPblicteEndDte;
	private String schMtrilNm;
	private String schAuditRceptNo;
}
