package lims.rsc.vo;

import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Data
@ToString
public class CmpdsUseMVo {
	
	
	
//  <===========RS_PRDUCT 테이블 ============>
	private Integer prductSeqno;  		//제품 일련번호
	private String bplcCode;			//사업장코드
	private String prductClCode;		//제품 분류 코드
	private String prductNm;			//제품명
	private String usePurps;			//사용 목적
	private String recmndUseTime;		//권장 사용시간
	private String reWrhousngAt;		//재입고 여부
	private String rm;					//비고
	private String deleteAt;			//삭제 여부
	
	//RS_PRDUCT_WRHSDLVR_BRCD 테이블
	private Integer prductWrhsdlvrBrcdSeqno;	//		제품 입출고 바코드 일련번호
	private Integer prductWrhsdlvrSeqno;	//		제품 입출고 일련번호
//  private	Integer prductSeqno;	//		제품 일련번호
	private String wrhsdlvrSeCode;	//		ZRS08 입출고 구분 코드
	private String wrhsdlvrDT;	//		입출고 일시
	private String brcd;	//		바코드
	private String validDte;	//		유효 일자

	private Integer ordr;
	private Integer maxOrdr;
	private String cycle;
	
	//DB 검색
	private String prductClCodeSch;
	private String prductNmSch;
	private String bplcCodeSch;
	private String brcdSch;
	//DB 그리드 DATA
	private String useBeginDt;
	private String useEndDt;
	private Integer CmpdsUseSeqno;
	
	private Integer wrhsdlvrQy;
	private String crud;
//	private String mhrlsCmpdsSeqno;            /* 기기 소모품 일련번호 */
//	private String chrgTeamSeqno;            /* 담당 팀 일련번호 */
//	private String mhrlsSeqno;            /* 기기 일련번호 */
//	private String mhrlsCmpdsSeCode;            /* ZRS14 기기 소모품 구분 코드 */
//
//	private String wrhousngDte;            /* 입고 일자 */
//	private String dsuseAt;				//폐기 여부
//	private String dsuseDte;            /* 폐기 일자 */
//	private String totUseTime;            /* 총 사용 시간 */
	private String lastChangerId;            /* 최종 변경자 ID */
//	private String lastChangeDt;            /* 최종 변경 일시 */
//	private String cmpdsNm;            /* 소모품 명 */ 
//	private String useTimePer;			//가용률
//
//	private String inspctCrrctCycleCode;
//	private String chrgTeamSeCodeNm;
//	private String chrgTeamSeCode;
//	private String prductStndrdSeqno;
//	private String prductStndrdNm;
//	private String prductStndrdCnt;
//	private String mhrlsClCode;
//	private String mhrlsClCodeNm;
//	private String useDte;
//	
//	private String deptNm;
//	private String chrgTeamNm;
//	private String mhrlsCmpdsSeCodeNm;
//	private String mhrlsNm;
//	private String deptCode;
//	private String stepNo;
//	private String manageRspnberJId;            /* 관리 책임자_정 ID */
//	private String manageRspnberBId;            /* 관리 책임자_부 ID */
//	private String analsteamSeCode;            /* ZRS19 분석팀 구분 코드 */
	
	
	



}
