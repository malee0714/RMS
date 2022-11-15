package lims.dly.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class DlivyMVo {

	private String dlivyOrdeSeqno; /* 출고 지시서 일련번호 */
	private String reqestSeqno; /* 의뢰 일련번호 */
	private String qlyhghDocNm; /* 품고 문서 명 */
	private String dvyfgEntrpsCode; /* 납품 업체 코드 */
	private String dvyfgEntrpsNm; /* 납품 업체 명 */
	private String prductSeqno; /* 제품 일련번호 */
	private String mtrilCode; /* 자재 코드 */
	private String ctmmnyMtrilCode; /* 고객사 자재 코드 */
	private String poNo; /* PO NO */
	private String mtrilNm; /* 자재 명 */
	private String batchNo; /* BATCH NO */
	private String dlivyQy; /* 출고 량 */
	private String unitNm; /* 단위 명 */
	private String rm; /* 비고 */
	private String updtCn; /* 수정 내용 */
	private String emailSndngAt; /* 이메일 발송 여부 */
	private String emailSndngTm; /* 이메일 발송 시각 */
	private String dlivyDte; /* 출고 일자 */
	private String dlivyHm; /* 출고 시분 */
	private String lastChangerId; /* 최종 변경자 ID */
	private String lastChangeDt; /* 최종 변경 일시 */
	private String lotId; /* LOT ID */
	private String deleteAt; /*삭제여부*/
	private String inspctInsttCode; /*부서*/
	private String deptNm;
	private String btchNo;
	private int dlivyQyCnt;
	private String vrifyAt; /* 검증여부 */
	private String orginlDlivyQy; /*원본 출고 량*/
	private String shrDvyfgEntrpsSeCode;
	private List<DlivyMVo> listGridData;
	private List<DlivyMVo> addListGridData;
	private List<DlivyMVo> removeListGridData;
	private String[] barcodeList;
	private String gubun;
	private String tot;

	private String emailSendDate; /* 메일 발송 날짜 */
	private String emailSendTime; /* 메일 발송 시간 */
	private String emailSndngDt;

	//출고 바코드 테이블
	private String dlivyBrcdSeqno; /* 출고 바코드 일련번호 */
	private String dlivyDocNm; /* 출고 문서 명 */
	private String dlivyBrcdSttusCode; /* ZIM16 출고 바코드 상태 코드 */
	private String mnfcturDte; /*제조일*/
	private String ordr; //순서
	private String brcd; //바코드
	private String repr; //개수
	private int topRepr; //총개수
	private String brcdCreatDte; //생성일

	private String userId; /*사용자 아이디*/
	private String userNm; /*사용자 명*/
	private String email;  /*이메일*/
	private String loginId;/*로그인아이디*/
	private String reqestDeptCode; /*제조*/
	private String reqestDeptNm; /*제조*/
	private String dlivyBrcdSttusNm; /*검증결과*/
	private String lastChangerNm; /*생성자*/
	private String deptCode; /*부서*/
	private String bplcCode; /*사업장코드*/
	private String progrsSittnCode; /*진행상태*/
	private String shrLotId;
	private int topReprCnt; /* 바코드 합격 갯수 */
	private int vrifyQy; /* 검증할 개 수 */
	private int vrifyCnt; /* 검증한 개 수 */
	private String vrifyDt; /*검증일시*/

	private String frstCrtrId;            /* 최초 생성자 ID */
	private String frstCreatDt;            /* 최초 생성 일시 */
	private String relcoDlivyDocNm;            /* 관계사 출고 문서 명 */
	private String relcoDlivyQy;            /* 관계사 출고 량 */
	private String unprogrsRequstDc;            /* 미진행 요청 설명 */
	private String invoiceNo;            /* full INVOICE NO */
	private String shipmntLcCode;            /* 출하 위치 코드 */
	private String errorAt;				/* 오류여부 */
	private String dispatch;			/* 배차  */
	private String carNo;				/* 차량번호 */
	private String invoice;				/* invoice */
	private String fillingMg;            /* FILLING 크기 */
	private String fillingMgUnitSeqno;            /* FILLING 크기 단위 일련번호 */
	private String bottleWt;            /* BOTTLE 무게 */
	private String bottleWtUnitSeqno;            /* BOTTLE 무게 단위 일련번호 */
	private String sellerName;
	private String poSeq;
	private String gbm;
	private String buyer;
	private String plantName;

	//변수로 사용
	private String hour;
	private String minute;

	//검색
	private String shrDeptCode; /*부서*/
	private String shrDlivyDteBeginDte; /*시작 날짜*/
	private String shrDlivyDteEndDte;   /*종료 날짜*/
	//검증일
	private String validateDteBeginDte; /*시작 날짜*/
	private String validateDteEndDte;   /*종료 날짜*/

	private String shrDlivyBrcdSttusCode; /*검증결과*/

	private String prductNm;

	private String brcd1;
	private String brcd2;
	private String brcd3;
	private String brcd4;
	private String brcd5;

	private String successResult; //합격 여부
	private String skAt;

	//부서별 알림대상자 조회
	private String schdulSeqno; /* 일정 일련번호 */
	private String ntcnSeCode; /* ZSY17 알림 구분 코드 */
	private String[] ntcnGrid;
	private String smsMsg; /* 문자내용 */

	private String auth; /*권한 확인*/
	private String reqAt; /*의뢰여부 확인*/

	private List<String> excelArr;

	private String authorSeCode; /*권한*/

	private String authorTrgterSeqno; /*권한테이블 일련번호*/
	private String useAt;

	private String customsClearance; /*제조일*/

	//물류엑셀 사용
	private String subMaterialType;
	private String valuationType;
	private String storageLocation;
	private String lotQuantity;
	private String vender;

	private String brValid; /*검증체크여부*/

	//Do 업데이트 사용
	private String doNo;

	private String chrctrRecptnAt;
	private String emailRecptnAt;

	private int resultCount;

}
