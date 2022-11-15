package lims.src.vo;

import lombok.*;

@Data @ToString
@NoArgsConstructor
@AllArgsConstructor
public class PedigeeMVo {
	private String reqestSeqno;            /* 의뢰 일련번호 */
	private String upperReqestSeqno;		//상위 의뢰 일련번호
	private String bplcCode;            /* 사업장 코드 */
	private String bplcNm;            /* 사업장 명 */
	private String reqestNo;            /* 의뢰 번호 */
	private String mtrilSeqno;            /* 자재 일련번호 */
	private String mtrilNm;            /* 자재 명 */
	private String mtrilCode;		//자재코드
	private String mtrilSdspcSeqno;		/* 자재 기준규격 일련번호 */
	private String inspctTyCode;            /* ZSY07 검사 유형 코드 */
	private String inspctTyNm;            /* ZSY07 검사 유형 */
	private String reqestDte;            /* 의뢰 일자 */
	private String mnfcturDte;            /* 제조 일자 */
	private String emrgncyAt;            /* 긴급 여부 */
	private String ordr;            /* 순서 */
	private String lotNo;            /* LOT NO */
	private String frstLotNo;            /* 최초 LOT NO */
	private String vendorLotNo;            /* 벤더 LOT NO */
	private String reqestDeptCode;            /* 의뢰 부서 코드 */
	private String reqestDeptNm;            /* 의뢰 부서 명 */
	private String clientId;            /* 의뢰자 ID */
	private String clientNm;            /* 의뢰자 명 */
	private String rm;            /* 비고 */
	private String virtlLotAt;            /* 가상 LOT 여부 */
	private String reReqestAt;            /* 재 의뢰 여부 */
	private String jdgmntWordCode;            /* ZIM05 판정 용어 코드 */
	private String jdgmntWordCodeNm;			//판정 명
	private String progrsSittnCode;            /* ZIM03 진행 상황 코드 */
	private String progrsSittnCodeNm;            /* ZIM03 진행 상황 코드 */
	private String progrsSittnNm;            /* ZIM03 진행 상황 명 */
	private String lastAnalsDt;            /* 최종 분석 일시 */
	private String rereqestNum;            /* 재의뢰 건수 */
	private String ctmmnyOthbcAt;            /* 고객사 공개 여부 */
	private String vendorEntrpsSeqno;            /* 벤더 업체 일련번호 */
	private String authorSeCode;

	//조회조건
	private String deptCodeSch;
	private String mtrilCodeSch;
	private String reqestBeginDte;
	private String reqestEndDte;
	private String mnfcturBeginDte;
	private String mnfcturEndDte;
	private String progrsSittnCodeSch;
	private String lotTrace;
}
