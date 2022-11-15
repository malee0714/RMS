package lims.test.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResultInputPfileMVo {
	private String lotId;  				/* LOT ID */
	private String resultValue; 		/* 결과 값 */
	private String progrsSittnCode; 	/* 의뢰 진행상황 */
	private String testNm;				 /*시험항목명*/ 
	private String reqestSeqno; 	/*의뢰 일련번호*/
	private String reqestExpriemSeqno; 	/*시험항목일련번호*/
	private String reqExpriemSeqno;
	private String idChk;
	private String msg;
}
