package lims.wrk.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
/***
 * 
 * @author shs
 * @table 
 * 			SY_MTRIL_CL_MANAGE - 자재CL관리 <br>
 * 			SY_MTRIL - 자재
 * 
 */
@Getter
@Setter
@ToString
public class CLManageMVo {
	
	private String mtrilClManageSeqno;	// 자재 CL 관리 일련번호
	private String mtrilSeqno;			// 자재 일련번호
	private String lotNum;				// LOT 건수
	private String searchCycle;         // 검색 주기
	private String sgmLevl;				// 시그마 수준
	private String lastExecutDte;		// 최종 실행 일자
	private String nextExecutDte;		// 다음 실행 일자
	private String executCycle;			// 실행 주기
	private String cycleCode;			// ZSY14 주기 코드
	private String mtrilCode;			// 자재 코드
	private String mtrilNm;				// 자재 명	
	private String useAt;				// 사용 여부
	private String mmnySeCode; 			// ZSY01 자사 구분 코드
	private String mmnySeCodeNm;		// ZSY01 자사 구분 코드 명
	private String lastChangerId;		// 최종 변경자 ID
	private String lastChangeDt;		// 최종 변경 일시
	private String prductSeCode;

	//조회조건
	private String bplcCodeSch;			// 사업장 코드
	private String mtrilCodeSch;		// 자재 코드
	private String mtrilNmSch;			// 자재 명

	private String useAtSch;			// 사용 여부
	private String prductSeCodeSch;
	//Spc ryle 검색 시작일 종료일
	private String searchBeginDte;      // 검색 시작일 (제조일자)
	private String searchEndDte;        // 검색 종료일 (제조일자)
}