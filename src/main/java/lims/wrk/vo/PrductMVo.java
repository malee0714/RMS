package lims.wrk.vo;

import lombok.Data;
import lombok.ToString;

import java.util.List;

@Data
@ToString
//@JsonInclude(Include.NON_NULL)
public class PrductMVo {
	//---------------SY_PRDUCT 제품 테이블------------------------------------------
	String prductNo; /* 제품 번호 */
	String processTyCode; /* ZSY02 프로세스 타입 코드 */
	String processTy;	//이건 프로세스타입 공통코드에서풀어쓴거
	String upperLotCo; /* 상위 LOT 수 */
	String upperLotCphr; /* 상위 LOT 자리수 */
	String prductSeqno; /* 제품 일련번호 */
	String deptCode; /* 부서 코드 */
	String deptNm;   /* 부서 명 */
	String prductNm; /* 제품 명 */
	String prductDetailNm; /* 제품 상세 명 <--- pname으로 쓰면됨.*/
	String mnfcturAnalsAt;	// 제조분석여부
	String limsUseAt;	//림스사용여부
	String extrlMummValue;
	String extrlMummValueSeCode;
	String extrlMxmmValue;
	String extrlMxmmValueSeCode;


	//---------------SY_PRDUCT_MTRIL 자재 테이블--------------------------------------------------------
	String prductMtrilSeqno; /* 제품 자재 일련번호 */

	//--------------SY_INSPCT_INSTT 부서 테이블 ----------------------------------------------
	String mmnySe;	//저위에 공통코드 한글로 풀은것임
	String inspctInsttNm;	//부서명

	//--------------SY_PRDUCT_SDSPC 기쥰규격 테이블 ----------------------------------------------
	String prductSdspcSeqno; /* 제품 기준규격 일련번호 */


	String jdgmntFomNm; /* ZIM06 판정 형식 코드 명 */
	String firstMummValue; /* 1차 최소 값 */
	String firstMummValueSeCode; /* ZIM08 1차 최소 값 구분 코드 */
	String firstMummValueSe;
	String firstMxmmValue; /* 1차 최대 값 */
	String firstMxmmValueSeCode; /* ZIM07 1차 최대 값 구분 코드 */
	String firstMxmmValueSe;
	String scdMummValue; /* 2차 최소 값 */
	String scdMummValueSeCode; /* ZIM08 2차 최소 값 구분 코드 */
	String scdMummValueSe;
	String scdMxmmValue; /* 2차 최대 값 */
	String scdMxmmValueSeCode; /* ZIM07 2차 최대 값 구분 코드 */
	String scdMxmmValueSe;

	String unitNm;    /*단위 일련번호 명*/
	String realMesureMhrlsClCode; /* ZRS01 실제 측정 기기 분류 코드 */
	String realMesureMhrlsCl;
	String replcMesureMhrlsClCode; /* ZRS01 대체 측정 기기 분류 코드 */
	String replcMesureMhrlsCl;
	String processTime; /* 처리 시간 */
	String coaOutptAt; /* COA 출력 여부 */
	String exprNumot; /* 시험 횟수 */
	String erorScope; // 오차 범위
	String emailSndngAt;	//이베일 발송여부
	String chrctrSndngAt;	// 문자 발송여부
	String prductUpperSeqno; //상위 제품키
	String prductSeEmailUserSeqno;	// 제품구분이메일사용자일련번호
	String schdulSeCode;	//일정 구분코드

	String userNm; //유저 명
	String upperMtrilCode;	//상위 자재코드
	String ctmmnyMummValue; //고객사 미니멈
	String ctmmnyMxmmValue; // 고객사 맥시험
	String ctmmnyMummValueSeCode; // 미니멈 단위
	String ctmmnyMxmmValueSeCode; // 맥심원 단위
	String srchCntnrTyCode; //용기타입 검색
	//--------------------------상위 로트 테이블 정보--------------------------------------------

	String prductUpperLotSeqno; // 상위로트 키값
	String upperLotDc;	// 상위로트 메모장
	String lotDc;	// 상위로트 메모장

	//--------------------------담당 팀 테이블 정보--------------------------------------------

	String prductChrgTeamSeqno;	// 제품 담당팀 번호
	String chrgTeamNm;		//담당 팀명
	String chrgTeamSeqno;	//담당 팀 키값

	//--------------------------제품 탱크 테이블 정보--------------------------------------------//

	String prductTnkSeqno; //탱크키
	String tankNm;	//탱크명
	String tankDc;	//탱크 설명


	//--------------------------기타 정보--------------------------------------------
	String expriemNm;	// 시헝항목 명
	String expriemCl; // 시험항목그룹
	String abrv;	//약어

	String cntnrTyCode; // 용기타임 brave type
	String ctmmnyLineDc;	//고객사 라인 설명

	String key;	//콤보 키
	String value; // 콤보 밸유

	//---------------------------고객사 규격관리에 쓸거임-------------------------------------------
	private String spsMarkCphr; //제품 표기 자리수
	private String spsTextStdr; //텍스트 기준
	private String shrExpriemClCode; //시험항목 분류 코드 검색
	private String shrExpriemNm; //시험항목명 검색
	private String[] shrPrductSdspcArray;
	private String[] gridDataExpriemArray;
	private String koreanNm; //시험항목 한글명
	private String engNm; //시험항목 영문명
	private String firstMummValueSeNm; //1차 LSL 코드명
	private String firstMxmmValueSeNm; //1차 USL 코드명
	private String secMummValueSeNm; //1차 LCL 코드명
	private String secMxmmValueSeNm; //1차 UCL 코드명
	private String scdMummValueSeNm;   //2차 LCL 코드명
	private String scdMxmmValueSeNm;   //2차 UCL 코드명
	String analsAt; //분석 여부

	//---------------------------의뢰에서 씀-------------------------------------------
	String reqestAt; //분석에서 쓸건지 여부 가져오는거임. 시험항목 고객사 붙여서 가져오는 단순 셀렉트용.
	String prductCtmmnySeqno; //자재별 고객사 코드
	String ver;	//버전.
	String reqestSeqno; // 의뢰키

	String frstAnalsOutptNum;
	String middleAnalsOutptNum;
	String lastAnalsOutptNum;
	String etcAnalsOutptNum;
	String etcAnalsAt;


	String realMesureMhrlsClCodeNm;

	String analsTeamSeqno;

	String upperMtrilCodeBasis;
	String reqestDeptCode;


	String flag; // 새로저장여부

	String realMhrlsNm;

	String mesJdgmntTrnsmisAt; // mes전송여부
	String realLotInputAt;
	
	// 공통코드
	private String cmmnCode;
	private int tmprField1Value;  // 임시 필드1 값 (자릿수)
	
	//-----------------------------------------------------------------------------------------------ENF
	// 2021-06-18 추가
	// sy_mtril (자재)
	private String mtrilSeqno;            /* 자재 일련번호 */
	private String bplcCode;            /* 사업장 코드 */
	private String mtrilCode;            /* 자재 코드 */
	private String mtrilNm;            /* 자재 명 */
	private String mtrilTyCode;            /* ZSY02 자재 유형 코드 */
	private String metalMarkValue;            /* METAL 표기 값 */
	private String detectLimitApplcAt;            /* 검출 한계 적용 여부 */
	private String rm;            /* 비고 */
	private String useAt;            /* 사용 여부 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private float analsReqreTime;            /* 분석 소요 시간 */
	private String mmnySeCode;            /* ZSY01 자사 구분 코드 */
	private String mmnySeCodeNm;            /* 자사 구분명 */
	private String bplcCodeSch;            /* 사업장 조회 */
	private String deptCodeSch;             /* 부서 조회 */
	private String mtrilTyCodeSch;			/*자재유형 조회*/
	private String prductSeCodeSch;			//제품 구분 조회
	private String mtrilCodeSch;
	private String mtrilNmSch;
	private String mtrilTyCodeNm;			/*자재유형명 조회 */
	private String lblDcOutptAt; /*라벨설명 출력여부*/
	private String sdRegistAt;   // 기준 등록 여부 
	private String prductSeCode; // 제품 구분
	private String prductSeCodeNm;
	private String sanctnSeqno;
	private String eqpmnClCodeNm;
	private String resultRangef;
	// 고객사 자재팝업 사용
	private String mtrilTyNm;
	private String[] shrMtrilSdspcArray;

	// sy_mtril_sdspc (자재 기준규격)
	private String mtrilSdspcSeqno;            /* 자재 기준규격 일련번호 */
	private String sdspcNm;            /* 기준규격 명 */
	private String expriemSeqno;            /* 시험항목 일련번호 */
	private String jdgmntFomCode;            /* ZIM06 판정 형식 코드 */
	private String lclValue;            /* LCL 값 */
	private String lclValueSeCode;            /* ZIM08 LCL 값 구분 코드 */
	private String uclValue;            /* UCL 값 */
	private String uclValueSeCode;            /* ZIM07 UCL 값 구분 코드 */
	private String lslValue;            /* LSL 값 */
	private String lslValueSeCode;            /* ZIM08 LSL 값 구분 코드 */
	private String uslValue;            /* USL 값 */
	private String uslValueSeCode;            /* ZIM07 USL 구분 코드 */
	private String markCphr;            /* 표기 자리수 */
	private String textStdr;            /* 텍스트 기준 */
	private String unitSeqno;            /* 단위 일련번호 */
	private String unitSeCode;
	private String eqpmnClCode;            /* ZRS02 장비 분류 코드 */
	private String sortOrdr;            /* 정렬 순서 */
	private String updtResn;            /* 수정 사유 */
	private String coaUpdtPosblAt;            /* COA 수정 가능 여부 */
	private String frstAnalsAt;            /* 최초 분석 여부 */
	private String middleAnalsAt;            /* 중간 분석 여부 */
	private String lastAnalsAt;            /* 최종 분석 여부 */
	private String lclValueSeNm;		/* IM08구분코드명 */
	private String uclValueSeNm;		/* IM07구분코드명 */
	private String lslValueSeNm;		/* IM08구분코드명 */
	private String uslValueSeNm;		/* IM07구분코드명 */
	private String coaUseAt;			  /* COA 사용여부 */

	// SY_MTRIL_BOM_EXTRL (외부)
	private String mtrilBomExtrlSeqno;            /* 자재 BOM 외부 일련번호 */
	private String dc;            /* 설명 */

	// SY_MTRIL_BOM_INNER (내부)
	private String mtrilBomInnerSeqno;            /* 자재 BOM 내부 일련번호 */

	// SY_MTRIL_EQP_SE (설비구분)
	private String mtrilEqpSeSeqno;            /* 자재 설비 구분 일련번호 */
	private String eqpSeNm;            /* 설비 구분 명 */
	private String eqpSeCode;            /* 설비 구분 코드 */

	// SY_MTRIL_NTCN_USER (Warning Mail)
	private String mtrilNtcnUserSeqno;            /* 자재 알림 이용자 일련번호 */
	private String userId;            /* 이용자 ID */
	private String emailRecptnAt;            /* 이메일 수신 여부 */
	private String chrctrRecptnAt;            /* 문자 수신 여부 */
	private String psexamRecptnAt;            /* 합격 수신 여부 */
	private String dsqlfcRecptnAt;            /* 불합격 수신 여부 */
	private String allRecptnAt;            /* 전체 수신 여부 */

	// SY_MTRIL_VENDOR (납품처)
	private String mtrilVendorSeqno;            /* 자재 벤더 일련번호 */
	private String vendorNm;            /* 벤더 명 */
	private String vendorSeCode;            /* 벤더 구분 코드 */

// 위험코드	
	private String upperCmmnCode;     // 상위 공통 코드 
	private String tmprField3Value ;  // 임시 필드 값3 
	private String tmprField2Value;   // 임시 필드 값2
	private String cmmnCodeNm;		  // 상세 코드 명
	private String cmmnCodeRm;		  // 상세 코드 설명
	private String prductClCodeNm;    // 
	
	// 쿼츠 CL VERSION 마지막 수정일자
	private String lastExecutDte;

	//실린더
	private String cylndrNm;
	private String mtrilCylndrSeqno;
	private String cylndersql;// selectkey
	private String cylndrNo;

	// 아이템 NO

	private String mtrilItmSeqno;
	private String itmNo;

	// 그리드  리스트 모음
	// 자재
	List<PrductMVo> addedMtrilGrid;
	List<PrductMVo> editedMtrilGrid;
	List<PrductMVo> removedMtrilGrid;

	// 기준규격
	List<PrductMVo> addedExpriemGrid;
	List<PrductMVo> editedExpriemGrid;
	List<PrductMVo> removedExpriemGrid;

	// bom 내부
	List<PrductMVo> addedBomInnerGrid;
	List<PrductMVo> editedBomInnerGrid;
	List<PrductMVo> removedBomInnerGrid;

	//bom 외부
	List<PrductMVo> addedBomExtrlGrid;
	List<PrductMVo> editedBomExtrlGrid;
	List<PrductMVo> removedBomExtrlGrid;

	//설비구분
	List<PrductMVo> addedEqpSeGrid;
	List<PrductMVo> editedEqpSeGrid;
	List<PrductMVo> removedEqpSeGrid;

	//warning mail
	List<PrductMVo> addedWarnGrid;
	List<PrductMVo> editedWarnGrid;
	List<PrductMVo> removedWarnGrid;

	//납품처 구분
	List<PrductMVo> addedVendorGrid;
	List<PrductMVo> editedVendorGrid;
	List<PrductMVo> removeVendorGrid;

	//리스트 두개는 자재일괄추가때씀
	List<PrductMVo> mtrilList;
	List<PrductMVo> sdspcList;
	
	List<PrductMVo> addedPrevntMaster;
	List<PrductMVo> editedPrevntMaster;
	List<PrductMVo> removePrevntMaster;


	private List<PrductMVo> addedCylinderList;
	private List<PrductMVo> editedCylinderList;
	private List<PrductMVo> removedCylinderList;

	private List<PrductMVo> addedItemNoList;
	private List<PrductMVo> editedItemNoList;
	private List<PrductMVo> removedItemNoList;


}
