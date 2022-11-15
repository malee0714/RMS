package lims.rsc.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PurchsRequestFixMVo {
	/* RS_PURCHS 테이블*/
	private String purchsSeqno;            /* 구매 일련번호 */
	private String purchsNm;            /* 구매 명 */
	private String purchsDte;            /* 구매 일자 */
	private String purchsDeptCode;            /* 구매 부서 코드 */
	private String purchsrId;            /* 구매자 ID */
	private String totAmount;            /* 총 금액 */
	private String acptncComptAt;            /* 검수 완료 여부 */
	private String rgntProgrsSittnCode;            /* ZRS05_시약 진행 상황 코드 */
	private String rm;            /* 비고 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	
	/* RS_PURCHS_ISESTATN 테이블*/
	private String prductSeqno;            /* 제품 일련번호 */
	private String wrhsdlvrSeqno;            /* 입출고 일련번호 */
	private String requstQtt;            /* 요청 수량 */
	private String purchsQtt;            /* 구매 수량 */
	private String untpc;            /* 단가 */
	private String acptncQtt;            /* 검수 수량 */
	private String acptncDte;            /* 검수 일자 */
	private String acptncRm;            /* 검수 비고 */
	
	/* 변수 */
	private String gbnCrud;	
	private String gridCrud;
	private String purchsNmSch;
	private String purchsRequstSeqno;            /* 구매 요청 일련번호 */
	private String price;
	private String requstDeptCodeSch; /* 부서코드 검색어 */
	private String inspctInsttCode;
	private String loginId;
	
	/* JSONObject 변수 */
	private String requstDeptCode;
	private String rqesterId;
	private String key;
	private String value;
	private String requstNum; /* 구매요청 건수 */
	private String rqesterNm; /* 요청자명 */
	private String requstDeptNm; /* 구매 요청 부서 */
	private String rgntProgrsSittnNm; /* 진행 상황 */
	private String prductSeNm;/* 제품 구분 */
	private String prductClNm;/* 제품 분류명 */
	private String prductNm; /* 제품명 */
	private String prposNm; /* 용도 */
	private String cstdysttusNm; /* 보관상태 */
	private String prductunitNm; /* 제품 단위 */
	private String requstDteStart; /*구매 요청 시작일 검색어*/
	private String requstDteFinish; /*구매 요청 종료일 검색어*/
	private String purchsRequstNmSch; /*구매 요청명 검색어*/
	private String rgntProgrsSittnCodeSch; /*진행 상황 검색어*/
	private String rqesterLoginId; /* 구매요청자 로그인 ID */
	private String pc;
	private String ctlgNo;
	private String casNo;
	private String stndrdDc;
	private String prtdgDc;
	private String prductClNmSch;
	private String prductNmSch;
	private String useAtSch;
	private String prposCode;
	private String cstdySttusCode;
	private String prductUnitCode;
	private String prductClSeqno;         
	private String entrpsSeqno;       
	private String prductSeCode;
	private String purchsRequstDte;
	private String purchsRequstNm;
	private String prductSeqnoSch;
	private String purchsRequstSeqnoSch;
	private String mySeqno;
	
}
