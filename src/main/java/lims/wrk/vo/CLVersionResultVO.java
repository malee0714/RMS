package lims.wrk.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/***
 * 
 * 자재별 > 버전별 > 시험항목별 산정 결과값을 가지고 있다. <br>
 * UCL, CL, LCL등의 결과값들이 여러가지 기간, 수식을 통해 생성된다.
 * 
 * @author shs
 * @table SY_MTRIL_CL_VER_RESULT <br>
 * @page CLSearchM.jsp 등
 */
@Getter
@Setter
@ToString
public class CLVersionResultVO {
	private Integer ordr; 				// 순서
	private String mtrilClVerSeqno; 	// 자재 CL 버전 일련번호
	private String bplcCode; 			// 사업장 코드
	private String expriemSeqno; 		// 시험항목 일련번호
	private String mtrilSdspcSeqno; 	// 자재 기준규격 일련번호
	private String useAt; 				// 사용 여부
	private String lastChangerId; 		// 최종 변경자 ID
	private String lastChangeDt; 		// 최종 변경 일시
	private String expriemNm; 			// 시험항목 명
	
	// 결과값
	private Double uclValue; 			// UCL 값
	private Double clValue; 			// CL 값
	private Double lclValue; 			// LCL 값
	private Double stdDclnValue;        // 표준편차
}
