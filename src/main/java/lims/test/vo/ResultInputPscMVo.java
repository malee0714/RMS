package lims.test.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ResultInputPscMVo {
	
	private String lotId;  				/* LOT ID */
	private String expriemNm; 			/* 시험항목 명 */
	private String resultValue; 		/* 결과 값 */
	private String qcResultValue; 		/* qc 결과 값 */
	private String reqestExpriemSeqno;  /* 의뢰 시험항목 일련번호 */
	private String progrsSittnCode; 	/* 의뢰 진행상황 */
	private String jdgmntWordCode; 		/* ZIM05 판정 용어 코드 */
	private String cnt;	//항목 개수
	
}
