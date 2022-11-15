package lims.wrk.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 시험항목별 
 * 
 * @author shs
 */
@Getter
@Setter
@ToString
public class MhrlsDetectLimitMVo {
	private String detectLimitSeqno; 			// 검출 한계 일련번호
	private String bplcCode; 					// 사업장 코드
	private String eqpmnClCode; 				// ZRS02 장비 분류 코드
	private String eqpmnClCodeNm; 				// ZRS02 장비 분류 명
	private String expriemSeqno; 				// 시험항목 일련번호
	private String expriemNm; 					// 시험항목 명
	private String detectLimitBeloValue; 		// 검출 한계 미만 값
	private String coaMarkValue; 				// COA 표기 값
	private String applcBeginDte; 				// 적용 시작 일자
	private String applcEndDte; 				// 적용 종료 일자
	private String eqpmnInspctCrrctSeqno; 	// 장비 등록 일련번호
	private String rm; 							// 비고(장비 신뢰성평가(DL) 자동입력)
	private String useAt; 						// 사용 여부
	private String deleteAt; 					// 삭제 여부
	private String lastChangerId; 				// 최종 변경자 ID
	private String lastChangeDt; 				// 최종 변경 일시
	
	//조회
	private String bplcCodeSch; 				// 사업장코드
	private String eqpmnClCodeSch; 				// ZRS02 장비 분류 코드
	private String expriemNmSch; 				// 시험항목 명
	private String detectLimitBeloValueSch; 	// 검출 한계 미만 값
	private String coaMarkValueSch; 			// COA 표기 값
	private String applcBeginDteSch; 			// 적용 시작 일자
	private String applcEndDteSch; 				// 적용 종료 일자
	private String useAtSch;					// 사용 여부

	@JsonIgnore
	public boolean isNew(){
		return this.detectLimitSeqno == null || "".equals(this.detectLimitSeqno);
	}
}
