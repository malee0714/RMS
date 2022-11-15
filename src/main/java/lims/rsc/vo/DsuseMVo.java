package lims.rsc.vo;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@JsonInclude(Include.NON_NULL)

@Setter
@Getter
@ToString
public class DsuseMVo {
	// RS_WRHSDLVR 테이블
//  <===========RS_PRDUCT 테이블 ============>
	private String custlabSeqno;        //분석실 일련번호
	private Integer prductSeqno;  		//제품 일련번호
	private String bplcCode;			//사업장코드
	private String prductClCode;		//제품 분류 코드
	private String prductNm;			//제품명
	private Integer proprtInvntryQy;	//적정 재고량
	private Integer nowInvntryQy;		//현재 재고량
	private String prductPrpos;			//제품 용도
	private String cpcty;				// 용기
	private String usePurps;			//사용 목적
	private String rm;					//비고
	private String wrhsdlvrSeBeforeCode; // 처리전 입출고 상태
//   RS_PRDUCT_WRHSDLVR 테이블   
	private	String packngSttus;	//	포장 상태
	//RS_PRDUCT_WRHSDLVR_BRCD 테이블
	private Integer prductWrhsdlvrBrcdSeqno;	//		제품 입출고 바코드 일련번호
	private Integer prductWrhsdlvrSeqno;	//		제품 입출고 일련번호
	private String wrhsdlvrSeCode;	//		ZRS08 입출고 구분 코드
	private String wrhsdlvrSeCodeNm;	//		ZRS08 입출고 구분 코드
	private String exceptionCode;	//		폐기용 입출고 구분 코드
	
	private String brcd;	//		바코드
	private String validDte;	//		유효 일자
	private String validDate;	//		유효 일자
	private Integer ordr;

	private String brcdChk;				//바코드 예외처리용
	private String[] brcdList;			//바코드 예외처리 배열 변환
	private Integer brcdChkval;			//유효기간 짧은 갯수
	private Integer flog;				//구분용 숫자
	
	private String lastChagerId;
	private String lastChangeDt;
	private String wrhsdlvrSeqno;            /* 입출고 일련번호 */
	
	private String validTmlmtMthdCode;
	private Integer unsealAfterTmlmt;
	private String cycleCode;
	
	private String wrhsdlvrDt; // 입출고 일자
	private String lastChangerId;
	private String userId;
	private String prductClCodeNm;
	private String bplcCodeSch; // 사업장 검색
}
