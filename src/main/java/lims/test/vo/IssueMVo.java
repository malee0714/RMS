package lims.test.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class IssueMVo {
	private String issueSeqno;		/*이슈번호*/
	private String issueSj;			/*제목*/
	private String reqestDeptCode;	/*제조*/
	private String reqestDeptNm;	/*제조 명*/
	private String processTyCode;	/*프로세스 타입*/
	private String processTyNm;		/*프로세스 타입 명*/
	private String prductSeqno;		/*제품 번호*/
	private String prductNm;		/*제품 명*/	
	private String expriemCn;		/*검사항목 명*/
	private String sanctnSeqno;		/*상태*/
	private String jdgmntWordCode;  /*이슈유형 코드*/ 
	private String jdgmntWordNm;	/*이슈유형 명*/
	private String lastChangerId;	/*등록자 ID*/
	private String lastChangerNm;	/*등록자 명*/
	private String issueRegistDt;	/*등록일*/
	private String lotId; /*lot id*/
	private String reqestSeqno; /*의뢰 일련번호*/
	private String issueCn; /*이슈 처리 내용*/
	private String issueProgrsSittnNm; /*상태*/
	private String issueConfmerId; /*이슈 승인자 아이디*/
	private String issueConfmerNm; /*이슈 승인자 명*/
	private String prductUpperNm;
	private String firstAvgValue; //cl값
	
	private String innerIssueAt; /*내부 이슈 여부*/
	private String improptTyCode; /*부적합 유형*/
	private String issueSeCode;   /*이슈 구분*/
	private String lotIdText;
	private String appAt;
	private String appCnt;
	
	private String innerIssueNm; /*내부 이슈 여부*/
	private String improptTyNm;  /*부적합 유형*/
	private String issueSeNm;    /*이슈 구분*/
	private String issueRegisterId; /*이슈 등록자*/
	private String issueRegisterNm; /*이슈 등록자 명*/
	private String issueCnHis; /*처리이력*/
	
	private String reqestExpriemSeqno;  /* 의뢰 시험항목 일련번호 */
	private String exprOdr; 			/* 시험 차수 */
	private String exprNumot; 			/* 시험 횟수 */
	private String graphSeCode; 		/* ZIM04 그래프 구분 코드 */
	private String no; 					/* NO */	
	private String lastChangeDt;		/* 최종 변경 일시 */
	
	private Object emailParam;
	private String c;
	private String email;
	private String crud;
	private String issueProgrsSittnCode;
	private String emailSndngComptAt;
	private String issueProgrsSittnCodeIns;
	private String lockAt; /*잠금 여부*/
	
	//검색
	private String shrReqestDeptCode; 	/*제조*/
	private String shrProcessTyCode; 	/*프로세스타입*/
	private String shrPrductNm; 		/*제품*/
	private String shrIssueProgrsSittnCode; /*상태*/
	private String shrIssueRegistBeginDt; 	/*기간 시작*/
	private String shrIssueRegistEndDt;     /*기간 종료*/
	private String shrInnerIssueAt;	 	/*내부 이슈 여부*/
	private String shrImproptTyCode; 	/*부적합 유형*/
	private String shrIssueSeCode; 		/*이슈구분*/
	private String shrIssueSeqno;
	private String shrLotId;
	private String deptCodeSch;
	private String prductSeqnoSch;
	private String issueStDte;
	private String issueEnDte;
	private String expriemSeqno;
	private String shrConfmer; /*승인자*/
	private String authorSeCode;
	
	//통계
	private String processEa;
	private String registEa;
	private String acceptEa;
	private String innerIssue;
	private String outerIssue;
	
	private String[] stringIssue;
	
	private String chartData;
	
	private String emailCn;
	
	private String deptSchCode;
}
