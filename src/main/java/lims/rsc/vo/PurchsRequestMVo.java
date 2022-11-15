package lims.rsc.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PurchsRequestMVo {
	/* RS_PURCHS_REQUST 테이블 */
	private String purchsRequstSeqno;            /* 구매 요청 일련번호 */
	private String purchsRequstDte;            /* 구매 요청 일자 */
	private String purchsRequstNm;            /* 구매 요청명 */
	private String requstDeptCode;            /* 요청 부서 코드 */
	private String rqesterId;            /* 요청자 ID */
	private String purchsSeqno;            /* 구매 일련번호 */
	private String rgntProgrsSittnCode;            /* ZRS05_시약 진행 상황 코드 */
	private String rm;            /* 비고 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */

	/* RS_PURCHS_REQUST_ISESTATN 테이블 */
	private String prductSeqno;            /* 제품 일련번호 */
	private String requstQtt;            /* 요청 수량 */

	/* 변수 */
	private String gbnCrud;	/*Input CRUD 구분*/
	private String gridCrud;    /*Grid CRUD 구분*/
	private String key;			/*콤보 바인드 key*/
	private String value;		/*콤보 바인드 value*/
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
	private String untpc;            /* 단가 */
	private String requstDeptCodeSch; /* 부서코드 검색어 */
	private String inspctInsttCode;
	private String loginId;
	
	/* JSONObject 변수 */
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
	private String prductSeqnoSch;
	private String purchsRequstSeqnoSch;
	private String mySeqno;
	
	
}
