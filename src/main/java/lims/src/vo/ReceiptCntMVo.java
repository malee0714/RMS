package lims.src.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ReceiptCntMVo {
	private int analsTeamSeqno; /*분석 팀 일련번호 */
	private String analsTeamNm; /*담당팀*/
	private String hour;		/*시간*/
	private int rceptCnt;       /*건수*/
	private String chrgTeamIpSeqno;
	
	//검색
	private String shrAnalsTeam; /*담당팀*/
	private String shrAnalsTeamIp; /*담당팀*/
	private String shrDeptCode; /*부서*/
	private String shrReqestBeginDte; /*의뢰일자 시작*/
	private String shrReqestEndDte; /*의뢰일자 종료*/
	private String shrRceptBeginDt; /*접수일자 시작*/
	private String shrRceptEndDt; /*접수일자 종료*/
	private String shrReqestDeptCode;
	private String srchType;
	private String authorSeCode;
	
}
