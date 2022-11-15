package lims.rsc.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class WrhousngMVo {
	
//  <===========RS_PRDUCT 테이블 ============>
	private Integer prductSeqno;  		//제품 일련번호
	private String bplcCode;			//사업장코드
	private String prductClCode;		//제품 분류 코드
	private String prductNm;			//제품명
	private String validTmlmtTrgetAt;	//유효기한 대상 여부
	private String validTmlmtMthdCode;	//유효기한 방식 코드
	private Integer unsealAfterTmlmt;	//개봉후 기한
	private String cycleCode;			//주기코드
	private Integer proprtInvntryQy;	//적정 재고량
	private Integer nowInvntryQy;		//현재 재고량
	private String prductPrpos;			//제품 용도
	private String cntnrQy;				// 용기량
	private String cpcty;				//용량
	private String prtdg;				//순도
	private String casNo;				//casNO
	private String ctlgNo;				//카탈로그 NO
	private String usePurps;			//사용 목적
	private String prductSttusCode;		//제품 상태 코드
	private String entrpsNm;			//업체명
	private String entrpsChargerNm;		//업체담당자명
	private String entrpsChargerCttpc;	//엡체 담당자 연락처
	private String recmndUseTime;		//권장 사용시간
	private String reWrhousngAt;		//재입고 여부
	private Integer atchmnflSeqno;		//첨부파일 일련번호
	private String rm;					//비고
	private String useAt;				//사용 여부
	private String deleteAt;			//삭제 여부
	private String lblDcOutptAt;
	private String wrhsdlvrSeBeforeCode;
	private String wrhsdlvrSeNm;
	private String custlabSeqno;

	//expriemGird
	private String sortOrdr;
	private String expriemSeqno;
	private String expriemNm;   // 시험항목명
	private String dnstyValue;  // 농도값
/*   RS_PRDUCT_WRHSDLVR 테이블   */
	//private Integer prductWrhsdlvrSeqno;	//	제품 입출고 일련번호
	//private String bplcCode;	//	사업장 코드
	//private Integer prductSeqno;	//	제품 일련번호
	private	Integer wrhsdlvrQy;	//	입출고 량
	private	String wrhsdlvrDte;	//	입출고 일자
	private	Integer wrhsdlvrmanId;	//	입출고자 ID
	private	String cstdyPlace;	//	보관 장소
	private	String packngSttus;	//	포장 상태
	private	String purchsDte;	//	구매 일자
	private	String mnfcturRgntJdgmntValue;	//	제조 시약 판정 값
	//private Integer atchmnflSeqno;	//	첨부파일 일련번호
	//private String rm;	//	비고

	//RS_PRDUCT_WRHSDLVR_BRCD 테이블
	private Integer prductWrhsdlvrBrcdSeqno;	//		제품 입출고 바코드 일련번호
	private Integer prductWrhsdlvrSeqno;	//		제품 입출고 일련번호
//  private	Integer prductSeqno;	//		제품 일련번호
	private String wrhsdlvrSeCode;	//		ZRS08 입출고 구분 코드
	private String wrhsdlvrDT;	//		입출고 일시
	private String brcd;	//		바코드
	private Integer brcdNo;	//		바코드
	private String validDte;	//		유효 일자

	
	
	private Integer ordr;
	private String wrhsdlvrmanNm;
	private String brcdCreatAt;            /* 바코드 생성 여부 */
	private String validdate;
	// ----------------------- 검색용	
	private String prductNmSch; 
	private String bplcCodeSch;
	private String prductClCodeSch;
	private String useAtSch;
	private String wrhsdlvrBeginDte;
	private String wrhsdlvrEndDte;
	
	
	private List<WrhousngMVo> addedBrcdList; //추가된 
	private List<WrhousngMVo> editedBrcdList; //수정된 
	private List<WrhousngMVo> removedBrcdList; //삭제된

	private List<WrhousngMVo> addedExpriemList;
	private List<WrhousngMVo> EditedExpriemList;
	private List<WrhousngMVo> removedExpriemList;
}
