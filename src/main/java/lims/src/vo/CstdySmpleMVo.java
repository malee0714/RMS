package lims.src.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CstdySmpleMVo {


	private String reqestSeqno; // 의뢰일련번호
	private String bplcCode; // 사업장 코드
	private String bplcNm;
	private String upperReqestSeqno; // 상위 의뢰일련번호
	private String reqestNo; //의뢰 번호
	private String mtrilSeqno; // 자재 일련번호
	private String mtrilNm; //자재명
	private String lotCode; // 랏트코드
	private String inspctTyCode; //검사유형코드
	private String inspctTyCodeNm; // 검사유형코드명
	private String partclrMatterCode;//특이사항코드
	private String reqestDte;//의뢰일자
	private String mnfcturDte; // 제조 일자
	private String emrgncyAt;//긴급여부
	private String ordr; //순서
	private String mrtilEqpSeSeqno; //자재 설비 구분 일련번호
	private String mrtilVendorSeqno; //자재 밴더 일련번호
	private String lotNo; //랏트번호
	private String frstLotNo; //최초 랏트번호
	private String vendorLotNo; //밴더 랏트번호
	private String reqestDeptCode;// 의뢰 부서 코드	
	private String reqestDeptNm; //의뢰부서명
	private String clientId; //의뢰자 ID
	private String clientNm; // 의뢰자명
	private String expriemCo; // 시험항목수
	private String rm; //비고
	private String virtlLotAt; //가상 랏트여부
	private String reReqestAt; //재의뢰여부
	private String jdgmntWordCode; //판정 용어 코드
	private String progrsSittnCode; // 진행 상황코드
	private String progrsSittnCodeNm; //진행 상황코드명
	private String lastAnalsDt; // 최종분석일시
	private String rereqestNum; // 재의뢰건수
	private String roaCreatAt; // ROA생성 여부
	private String ctmmnyOthbcAt; //고객사 공개 여부
	private String lockAt; // 잠금여부
	private String deleteAt; //삭제 여부
	private String lastChangerId; //최종변경자 ID
	private String lastChangeDt; //최종변경일시
	private String validPdCycle; //유효 기간주기
	private String validPdCycleCode; //유효기간 주기 코드
	private String validDte; // 유효일자
	private String dsuseDte; // 페기 일자
	private String duspsnId; // 폐기자 ID
	private String duspsnNm;
	
	
	/*검색 */
	private String bplcCodeSch;
	private String mtrilSch;
	private String lotNoSch;
	private String reqestNoSch;
	private String inspctTyCodeSch;
	private String schDteID;
	private String schBeginDte;
	private String schEndDte;
	private String dsuseAtSch;
	private String progrsSittnCodeSch;
	
	
	
	
}
