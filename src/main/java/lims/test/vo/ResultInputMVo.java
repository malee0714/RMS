package lims.test.vo;

import lims.wrk.vo.CalcLawMVo;
import lombok.Data;
import lombok.ToString;

import java.util.List;

@Data
@ToString
public class ResultInputMVo {
	/*******************************
	 * 
	 * 의뢰 테이블 컬럼 vo 모음
	 * 
	*******************************/
	private String reqestSeqno;			/* 의뢰 일련번호 */
	private String bplcCode;			/* 사업장 코드 */
	private String reqestDeptCode;			/* 의뢰 부서 코드 */
	private String reqestDeptCodeNm;			/* 의뢰 부서 코드 */
	private String clientId;			/* 의뢰자 ID */
	private String clientNm;			/* 의뢰자 ID */
	private String reqestDte;			/* 의뢰 일자 */
	private String reqestNo;			/* 의뢰 번호 */
	private String inspctTyCode;			/* ZSY07 검사 유형 코드 */
	private String inspctTyCodeNm;			/* ZSY07 검사 유형 코드 */
	private String custlabSeqno;			/* 분석실 일련번호 */
	private String custlabNm;			/* 분석실 일련번호 */
	private String mtrilSeqno;			/* 자재 일련번호 */
	private String mtrilNm;			/* 자재 일련번호 */
	private String mnfcturDte;			/* 제조 일자 */
	private String sploreNm;			/* 시료 명 */
	private String mtrilCylndrSeqno;			/* 자재 실린더 일련번호 */
	private String mtrilCylndrNm;			/* 자재 실린더 일련번호 */
	private String mtrilItmSeqno;			/* 자재 아이템 일련번호 */
	private String mtrilItmNm;			/* 자재 아이템 일련번호 */
	private String elctcQy;			/* 충전 량 */
	private String elctcCn;			/* 충전 내용 */
	private String entrpsSeqno;			/* 업체 일련번호 */
	private String entrpsNm;			/* 업체 일련번호 */
	private String prductDc;			/* 제품 설명 */
	private String eqpmnSeqno;			/* 장비 일련번호 */
	private String eqpmnNm;			/* 장비 일련번호 */
	private String rcepterId;			/* 접수자 ID */
	private String rceptDt;			/* 접수 일시 */
	private String expriemCo;			/* 시험항목 수 */
	private String rereqestNum;			/* 재의뢰 건수 */
	private String roaCreatAt;			/* ROA 생성 여부 */
	private String ctmmnyOthbcAt;			/* 고객사 공개 여부 */
	private String lastAnalsDt;			/* 최종 분석 일시 */
	private String vendorReqestAt;			/* 벤더 의뢰 여부 */
	private String vendorLotNo;			/* 벤더 Lot No. */
	private String vendorCoaReqestSeqno;			/* 벤더 COA 의뢰 일련번호 */
	private String jdgmntWordCode;			/* ZIM05 판정 용어 코드 */
	private String progrsSittnCode;			/* ZIM03 진행 상황 코드 */
	private String progrsSittnCodeNm;			/* ZIM03 진행 상황 코드 */
	private String rm;			/* 비고 */
	private String lockAt;			/* 잠금 여부 */
	private String deleteAt;			/* 삭제 여부 */
	private String prductSeCodeNm; //제품 구분


	//IM_REQEST_EXPRIEM
	private String reqestExpriemSeqno;			/* 의뢰 시험항목 일련번호 */
	private String expriemSeqno;			/* 시험항목 일련번호 */
	private String expriemNm;			/* 시험항목 일련번호 */
	private String mtrilSdspcSeqno;			/* 자재 기준규격 일련번호 */
	private String sdspcNm;			/* 기준규격 명 */
	private String jdgmntFomCode;			/* ZIM06 판정 형식 코드 */
	private String lclValue;			/* LCL 값 */
	private String lclValueSeCode;			/* ZIM08 LCL 값 구분 코드 */
	private String uclValue;			/* UCL 값 */
	private String uclValueSeCode;			/* ZIM07 UCL 값 구분 코드 */
	private String lslValue;			/* LSL 값 */
	private String lslValueSeCode;			/* ZIM08 LSL 값 구분 코드 */
	private String uslValue;			/* USL 값 */
	private String uslValueSeCode;			/* ZIM07 USL 값 구분 코드 */

	private String markCphr;			/* 표기 자리수 */
	private String textStdr;			/* 텍스트 기준 */
	private String unitSeqno;			/* 단위 일련번호 */
	private String unitNm;			/* 단위 일련번호 */
	private String lastResultRegisterId;			/* 최종 결과 등록자 ID */
	private String lastResultRegisterNm;			/* 최종 결과 등록자 ID */
	private String lastResultRegistDte;			/* 최종 결과 등록 일자 */
	private String lastQcResultRegisterId;			/* 최종 QC 결과 등록자 ID */
	private String lastQcResultRegisterNm;			/* 최종 QC 결과 등록자 ID */
	private String lastQcResultRegistDte;			/* 최종 QC 결과 등록 일자 */
	private String eqpmnClCode;			/* ZRS02 장비 분류 코드 */
	private String eqpmnClCodeNm;			/* ZRS02 장비 분류 코드 */
	private String analsOpinion;			/* 분석 의견 */
	private String coaUpdtPosblAt;			/* COA 수정 가능 여부 */
	private String coaUseAt;			/* COA 사용 여부 */
	private String lastExprOdr;			/* 최종 시험 차수 */
	private String sortOrdr;			/* 정렬 순서 */
	private String lclUcl;	//lcl ~ ucl
	private String lslUsl;	//lcl ~ ucl
	private String ctmmnyLslUsl;
	private String ctmmnyLslValue;
	private String ctmmnyUslValue;
	private String ctmmnyLslValueSeCode;
	private String ctmmnyUslValueSeCode;
	private String ctmmnyTextStdr;
	private String ctmmnyEntrpsSeqno;
	private String prductCtmmnySeqno;



	//IM_REQEST_EXPRIEM_rESULT
	private String exprOdr;			/* 시험 차수 */
	private String calcLawSeqno;			/* 계산 법 일련번호 */
	private String nomfrmNm;			/* 수식 명 */
	private String nomfrmCn;			/* 수식 내용 */
	private String rvsopCn;			/* 역산 내용 */
	private String vriablId;			/* 변수 ID */
	private String resultValue;			/* 결과 값 */
	private String markValue;			/* 표기 값 */
	private String rvsopCphrRandomCreatAt;			/* 역산 자리수 무작위 생성 여부 */
	private String resultRegisterId;			/* 결과 등록자 ID */
	private String resultRegistDte;			/* 결과 등록 일자 */
	private String qcResultValue;			/* QC 결과 값 */
	private String qcMarkValue;			/* QC 표기 값 */
	private String qcResultRegisterId;			/* QC 결과 등록자 ID */
	private String qcResultRegistDte;			/* QC 결과 등록 일자 */
	private String rdmsUuid;			/* RDMS UUID */
	private String rdmsDocNo;			/* RDMS 문서 번호 */
	private String updtRdmsDocNo;			/* 수정 RDMS 문서 번호 */
	private String realAnalsAt;			/* 실제 분석 여부 */
	private String realAnalsDt;			/* 실제 분석 일시 */
	private String rdmsRegistAt;			/* RDMS 등록 여부 */
	private String orginlRdmsDocNo;			/* 원본 RDMS 문서 번호 */
	private String orginlUpdtRdmsDocNo;			/* 원본 수정 RDMS 문서 번호 */
	private String lastResultInputAt;			/* 최종 결과 입력 여부 */
	private String lasRegistAt;			/* LAS 등록 여부 */
	private String lasCn;			/* LAS 내용 */
	private String lastChangerNm;

	//IM_REQEST_EXPRIEM_VRIABL
	private String vriablNm;			/* 변수 명 */
	private String vriablUnitNm;			/* 변수 단위 명 */
	private String bassValue;			/* 기본 값 */
	private String vriablDc;			/* 변수 설명 */
	private String rdmsCntcAt;			/* RDMS 연계 여부 */
	private String lasCntcAt;			/* LAS 연계 여부 */
	private String vriablValue;			/* 변수 값 */
	private String qcVriablValue;			/* QC 변수 값 */
	private String dataChangeAt;			/* 데이터 변경 여부 */

	//그외 변수
	private String[] arrayExpriem;
	private String type;
	private String binderitemvalueIdStr;
	private String binderitemvalueId;
	private String authorSeCode;
	private String lastExprOdrAt;

	private List<ResultInputMVo> editSaveData;
	private ResultInputMVo calcItem;
	private List<CalcLawMVo> calcGridList;


	//조회조건
	private String reqestBeginDte;
	private String reqestEndDte;
	private String mnfcturBeginDte;
	private String mnfcturEndDte;
	private String showExpriemSch;
}
