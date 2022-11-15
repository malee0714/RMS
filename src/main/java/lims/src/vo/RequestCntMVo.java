package lims.src.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class RequestCntMVo {

	private String reqestDeptCode;          // 의뢰부서 코드
	private String reqestDeptNm; 			// 의뢰부서 명
	private String reqestCnt; 				// 의뢰건수
	private String reqestDte; 				// 의뢰일
	
	// 조회폼
	private String shrDeptCode;   			// 부서
	private String shrReqestBeginDte; 		// 의뢰일자 시작
	private String shrReqestEndDte;   		// 의뢰일자 종료
	private String shrInspctTyCode;         // 검사 유형
	private String bplcCodeSch;             // 사업장
	private String type;
	private List<RequestCntMVo> list;       // 부서별 의뢰건수
	private List<RequestCntMVo> listDate;   // 범례 리스트 (일자)
	private String authorSeCode;
	private String shrMtrilNm;				// 자재 이름
}
