package lims.req.vo;

import lims.com.vo.BaseDto;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ReceiptManageDto extends BaseDto {

	private Integer reqestSeqno;          	// 의뢰 일련번호
	private String bplcNm;            		// 사업장
	private String reqestNo;          		// 의뢰 번호
	private Integer mtrilSeqno;        		// 자재 일련번호
	private String mtrilNm; 		  		// 자재명
	private String inspctTyCode;      		// ZSY07 검사유형 코드
	private String inspctTyCodeNm;
	private String partclrMatterCode;		// ZIM99 특이사항 코드
	private String reqestDte;         		// 의뢰일자
	private String mnfcturDte;        		// 제조일자
	private String emrgncyAt;         		// 긴급여부
	private String mtrilEqpSeSeqno;   		// 자재 설비구분 일련번호
	private String mtrilVendorSeqno;  		// 자재 벤더 일련번호
	private String vendorEntrpsSeqno; 		// 벤더업체 일련번호
	private String vendorEntrpsNm; 			// 벤더업체 명
	private String vendorCoaAT; 			// 벤더 COA여부
	private String reqestDeptCode; 			// 의뢰부서 코드
	private String clientId; 				// 의뢰자 ID
	private String clientNm;
	private Integer rcepterId;          	// 접수자 ID
	private String rcepterNm;
	private String rceptDt; 		  		// 접수일자
	private String rereqestNum;      		// 재의뢰 건수
	private String progrsSittnCode; 		// ZIM03 진행상황 코드
	private String progrsSittnCodeNm;
	private String rm;   					// 비고
	private String ordr;                 	// 순서
	private String frstAnalsAt;       		// 최초분석 여부
	private String middleAnalsAt;     		// 중간분석 여부
	private String lastAnalsAt;       		// 최종분석 여부
	private Integer analsTeamSeqno; 		// 접수담당팀 코드
	private String chrgTeamNm;
	private String reqestDeptNm; 			// 의뢰부서
	private String prdlstNm; 				// 품목
	private String mtrilCode; 				// 자재코드
	private String prductTnkSeqno;          // 제품 탱크 일련번호
	private String rceptPcIp;       		// 담당팀 IP
	private Integer chrgTeamSeqno;      	// 담당팀 일련번호
	private Integer reqestExpriemSeqno;     // 의뢰 시험항목 일련번호
	private String analsComptPrearngeDt;    // 분석 완료예정일
	private float analsReqreTime;           // 분석소요시간
	private String sanctnProgrsSittnCode;   // 결재 진행상황 코드
	private String custlabNm;				// 분석실
	private String sploreNm;				// 시료명
	private String elctcQy;					// 충전량
	private String elctcCn;					// 충전정보
	private String rtnResn;                 // 반려사유

	private Integer[] reqestSeqnoList;

	// 조회조건
	private String reqestNoSch;		    // 의뢰번호
	private String inspctTyCodeSch;     // 검사유형
	private String progrsSittnCodeSch;  // 진행상황
	private String custlabSeqnoSch;		// 분석실
	private String reqestDeptCodeSch;	// 의뢰부서
	private String sploreNmSch;			// 분석내용
	private String reqBeginDte;
	private String reqEndDte;
	private String mnfBeginDte;
	private String mnfEndDte;
	private String key;
	private String value;

}
