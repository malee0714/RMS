package lims.com.vo;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;

import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@JsonInclude(Include.NON_NULL)
public class MainVo {

	private String orgNm; //의뢰기관명
	private String orgAbbr; //의뢰기관 약칭
	private String smpMngNo; //관리번호
	private String rdtDate; //서류 반송 요청 일시
	private String srcDate; //검체 재접수 요청 일시
	private String newRcpDt;
	private String rcpDt; /*접수일자*/

	private String countOrgApr;
	private String countPkgApr;
	private String countOrgPkgApr;
	private String countRcpApr;
	private String countDcsApr;
	private String countIneApr;
	
	private String orgAprUrl; //의뢰기관 결재
	private String pkgAprUrl; //패키지 결재
	private String orgPkgAprUrl; //의뢰기관 패키지 결재 
	private String rcpAprUrl; // 접수 대기 
	private String dcsAprUrl; // 농도 판정 
	private String ineAprUrl; // 결과 검토
	private String newOrgUrl; //신규 의뢰기관 
	private String docReturnUrl; // 서류 반송대장 
	private String sampleReturnUrl; //검체 재접수
	private String prtHisUrl; //결과보고서 내역
	
	private String cntDayRcp;//일일 접수건수
	private String cntDayComp;//일일 출력완료 건수
	private String cntDeliv; //출고 예정 건수
	private String avgAitm; //일일 의뢰평균 검사항목 갯수
	
	private String oupDate; //출력일
	private String rspbReaCdNm; //귀책사유명
	
	private String total;
	private String seoul;
	private String gyeonggi;
	private String gangwon;
	private String chungBuk;
	private String chungNam;
	private String jeolBuk;
	private String jeolNam;
	private String gyeongBuk;
	private String gyeongNam;
	private String cheju;
	
	private String userId;
	
	private String brdSeq;
	private String content;
	
	// 메인 공지사항 변수
	private String sntncSeqno;            /* 글 일련번호 */
	private String bbsCode;            /* 게시판 코드 */
	private String wrterId;            /* 작성자 ID */
	private String wrterNm;            /* 작성자 명 */
	private String writngDe;            /* 작성 일 */
	private String sj;            /* 제목 */
	private String cn;            /* 내용 */
	private byte[] blobCn;			//에디터 blob
	private String email;            /* 이메일 */
	private String inqireCnt;            /* 조회 카운트 */
	private String popupAt;            /* 팝업 여부 */
	private String popupBeginDe;            /* 팝업 시작 일 */
	private String popupEndDe;            /* 팝업 종료 일 */
	private String atchmnflSeqno;            /* 첨부파일 일련번호 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String ordNo;


	//메인 팀별 의뢰건수
	private String reqestSeqno;            /* 의뢰 일련번호 */
	private String processTyCode;            /* ZSY02 프로세스 타입 코드 */
	private String reqestSeText;            /* 의뢰 구분 텍스트 */
	private String prdlstNm;            /* 품목 명 */
	private String mtrilCode;            /* 자재 코드 */
	private String prductMtrilSeqno;            /* 제품 자재 일련번호 */
	private String tankNo;            /* TANK NO */
	private String batchCo;            /* 배치 수 */
	private String prductSeCode;            /* 제품 구분 코드 */
	private String lotId;            /* LOT ID */
	private String reqestDte;            /* 의뢰 일자 */
	private String mnfcturDte;            /* 제조 일자 */
	private String reqestDeptCode;            /* 의뢰 부서 코드 */
	private String clientId;            /* 의뢰자 ID */
	private String expriemCo;            /* 시험항목 수 */
	private String rm;            /* 비고 */
	private String tyDc;            /* 타입 설명 */
	private String reqestSeDc;            /* 의뢰 구분 설명 */
	private String virtlDc;            /* 가상 설명 */
	private String virtlLotAt;            /* 가상 LOT 여부 */
	private String reReqestAt;            /* 재 의뢰 여부 */
	private String sanctnSeqno;            /* 결재 일련번호 */
	private String rtnSeqno;            /* 반려 일련번호 */
	private String jdgmntWordCode;            /* ZIM05 판정 용어 코드 */
	private String progrsSittnCode;            /* ZIM03 진행 상황 코드 */
	private String prductSeqno;            /* 제품 일련번호 */
	private String prductTnkSeqno;            /* 제품 탱크 일련번호 */
	private String virtlLotSeCode;            /* ZIM02 가상 LOT 구분 코드 */
	private String cntnrTyCode;            /* ZSY10 용기 타입 코드 */
	private String upperReqestSeqno;            /* 상위 의뢰 일련번호 */
	
	private String lNum; /*전월 팀별 의뢰 건수*/
	private String cNum; /*당월 팀별 의뢰 건수*/
	private String manageDeptNm; /*팀명*/

	//이상목록발생
	private String issueSeqno;            /* 이슈 일련번호 */
	private String issueSj;            /* 이슈 제목 */
	private String issueRegistDt;            /* 이슈 등록 일시 */
	private String emailSndngComptAt;            /* 이메일 발송 완료 여부 */
	private String chrctrSndngComptAt;            /* 문자 발송 완료 여부 */
	private String expriemCn;            /* 시험항목 내용 */
	
	private String lCount; /* 전월 이상목록 건수*/
	private String cCount; /* 당월 이상목록 건수*/
	private String deptSchCode; /*부서코드*/
	
	
	// 이번달 의뢰건수 변수
	private String jobRealmCtn;
	private String jobRealmNm;
	private String jobRealmCode;
	private String timeLimit;
	private String request;
	private String collect;
	private String receipt;
	private String analysis;
	private String approval;
	private String receiptDteStart;
	private String receiptDteFinish;
	private String selectedClass;
	//private String reqestSeqno;
	private String reqestNo;
	//private String reqestDte;
	private String exprPurpsNm;
	private String prqudoNm;
	private String ipcssBsnsNm;
	private String reqestDeptNm;
	//private String clientId;
	private String totFee;
	private String bsrpFee;
	private String progrsSittnNm;
	private String timelimitCtn;
	
	private String waterQuality;
	private String waste;
	private String air;
	private String stink;
	private String noise;
	private String indoorair;
	private String dioxin;
	private String earth;
	private String ocean;
	private String pcbs;
	private String asbestos;
	private String other;
	private String deptCode;
	
	
	//엑셀 테스트
	private String fileName;
	private String fullPath;
	
	private String one;
	private String two;
	private String thr;
	private String fou;
	private String fiv;
	private String six;
	private String proDdEa;
	private String bplcCodeSch;
	private String custlabSeqno;
	
	private List<MainVo> bbsList;
	private List<MainVo> tcmList;
	private List<MainVo> isscList;
	private MainVo selProEa;
	// 알림 현황
	private String eqpmnSeqno;
	private String eqpmnNm;
	private String cycleNm;
	private String inspctCrrctPrearngeDte;
	private String inspctCrrctSeNm;
	private String tab2Begindte;
	private String tab2Enddte;
	private String tab4Begindte;
	private String tab4Enddte;
	
	private String inspctTyNm ;
	private String lotNo ;
	private String emrgncyAt ;
	private String rceptDt ;
	private String analsComptPrearngeDt;
	private String progrsSittn;
	
	private String bplcCode;
	private String prductClNm;
	private String prductNm;
	private String proprtinvntryQy;
	private String nowInvntryQy;
	
	private String wrhsdlvrSeNm;
	private String brcd;
	private String validDte;
	
	private String deptNm;
	private String bplcCodeNm;
	private String userNm;
	private String reformDte;
	
	//차기 교육 대상자

	private String edcSj;
	private String edcSeCode;
	private String edcSeCodeNm;
	private String nxttrmEdcDte;
	private String edcInsttNm;
	private String custlabSeqnoNm;
	
	
}
	
	
	
