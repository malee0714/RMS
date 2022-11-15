package lims.wrk.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
/***
 * 
 * 자재별 CL, UCL, LCL을 산정하기위한 <br>
 * 산정 정보와 함께 version별 시험항목 <i>산정 결과값</i> List를 가지고 있다.
 * 
 * @author shs
 * @table SY_MTRIL_CL_VER <br>
 * @page CLSearchM.jsp 등
 */
@Getter
@Setter
@ToString
public class CLVersionVO {
	private String mtrilClVerSeqno; // 자재 CL 버전 일련번호
	private String bplcCode; 		// 사업장 코드
	private String mtrilSeqno; 		// 자재 일련번호
	private String ver; 			// 버전
	private String lotNum; 			// LOT 건수
	private String searchCycle; 	// 검색 주기
	private String searchBeginDte; 	// 검색 시작 일자
	private String searchEndDte; 	// 검색 종료 일자
	private String executCycle; 	// 실행 주기
	private String cycleCode; 		// ZSY14 주기 코드
	private String lastVerAt; 		// 최종 버전 여부
	private String deleteAt; 		// 삭제 여부
	private String lastChangerId; 	// 최종 변경자 ID
	private String lastChangeDt; 	// 최종 변경 일시
	
	private List<CLVersionResultVO> clVersionResultList; // version별 산정결과 List 
}