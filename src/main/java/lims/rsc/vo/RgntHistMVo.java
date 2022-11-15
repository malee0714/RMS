package lims.rsc.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class RgntHistMVo {
//  <===========RS_PRDUCT 테이블 ============>
private Integer prductSeqno;  		//제품 일련번호
private String custlabSeqno;
private String custlabNm;
private String bplcCode;			//사업장코드
private String bplcCodeNm;
private String prductClCode;		//제품 분류 코드
private String prductClCodeNmsch;
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


//  <===========검색용============>
private String bplcCodeSch;			//사업장 코드 검색
private String deleteAtSch;

	private String prductClCodeSch;		//제품분류 검색
	private String prductNmSch;			//제품명 검색
	private String departmentNmSch;		//담당부서 검색
	private String useAtSch;			//사용여부 검색
	private String wrhsdlvrSeCodeSch;
	private String useBeginDte;
	private String useEndDte;
// <-------------탭 3 검색용--------->	
	private String brcdSch;
	
//<------------그리드 사용-------------->
	private String prductClCodeNm;
	private String departmentCode;		//담당 부서 명
	private String validTmlmtTragetAt;	//유효기간 선택
	private Integer RgntSeqno; 			//시퀀스
	private String wrhsdlvrSeCode;		//입출고 구분 코드
	private String wrhsdlvrSeCodeNm;		//입출고 구분 코드
	private String key;
	private String value;
	private String prductCode; // 제품명 검색
	private Integer wrhsdlvrQy;
	private String validDate;
	private String wrhsdlvrDt;
	private String brcd;
	private String ordr;
	private String wrhsdlvrmanId;
	private String wrhsdlvrmanNm;
	private String prductWrhsdlvrBrcdSeqno;
	
	
}
