package lims.rsc.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ProductMVo {
	private String prductSeqno;            /* 제품 일련번호 */
	private String prductClSeqno;            /* 제품 분류 일련번호 */
	private String entrpsSeqno;            /* 업체 일련번호 */
	private String prductNm;            /* 제품 명 */
	private String prposCode;            /* ZRS06_용도 코드 */
	private String cstdySttusCode;            /* ZRS07_보관 상태 코드 */
	private String prductUnitCode;            /* ZRS08_제품 단위 코드 */
	private Integer pc;            /* 가격 */
	private String ctlgNo;            /* 카탈로그 번호 */
	private String casNo;            /* CAS 번호 */
	private String stndrdDc;            /* 규격 설명 */
	private String prtdgDc;            /* 순도 설명 */
	private String rm;            /* 비고 */
	private String useAt;            /* 사용 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String useQySeCode;		//사용량 구분 코드
	private String prductDetailNm;   //제품 상세 명
	private String deptCode; //부서코드
	private String deptNm; //부서명
	private String processTyNm; //프로세스타입
	private String processTyCode; //프로세스타입
	private String mmnySeCode; //자사구분
	private String prductNo; //제품번호
	private String mtrilNm; //자재명
	private String mtrilCode; //자재코드
	private String prductUpperNm;
	private String cntnrTy;		//용기타임
	
	/* 변수 */
	private String gbnCrud;	/*CRUD 구분*/
	private String gridCrud;    /*Grid CRUD 구분*/
	private String entrpsNm; 	/* 업체 명 */
	private String prductClNm;/* 제품 분류 명 */
	private String prposNm;	 /* ZRS06_용도 명 */
	private String cstdysttusNm; /* ZRS07_보관 상태명 */
	private String prductunitNm; /* ZRS08_제품 단위명 */
	private String key;			/*콤보 바인드 key*/
	private String value;		/*콤보 바인드 value*/
	private String prductClNmSch; /* 제품 분류명 검색어*/
	private String prductNmSch; /* 제품 분류명 검색어*/
	private String useAtSch; /* 사용유무 검색어*/
	private String prductSeNm; /* 제품 구분 명 */
	private String prductSeCode; /* 제품 구분 코드 */
	private String purchsRequstSeqno;
	private String prductSeqnoSch;
	private String useQySeNm;
	private String prductUpperSeqno;
	private String prductCode;
	
	/* 검색 */
	private String[] shrPrductSdspcArray;
	
}
