package lims.req.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class PartnersCoaMVo {
	
	//의뢰정보
	private String mhrlsSeqno; /* 기기 일련번호 */
	private String exprTyCode; /* ZIM09 시험 유형 코드 */
	private String smpleNo; /* 샘플 번호 */
	private String histNo; /* 이력 번호 */
	private String inspctCrrctSeCode; /* ZIM10 검사 교정 구분 코드 */
	private String frstLotId; /* 최초 LOT ID */
	private String prductCtmmnySeqno; /* 제품 고객사 일련번호 */
	private String ver; /* 버전 */
	private String lastProcessDt; /* 최종 처리 일시 */
	private String lockAt; /* 잠금 여부 */
	private String coaVrifyAt; /* COA 검증 여부 */
	private String jdgmntWordCode; /* ZIM05 판정 용어 코드 */
	private String progrsSittnCode; /* ZIM03 진행 상황 코드 */
	private String deleteAt; /* 삭제 여부 */
	private String lastChangerId; /* 최종 변경자 ID */
	private String lastChangeDt; /* 최종 변경 일시 */
	private String prductSeqno; /* 제품 일련번호 */
	private String prductTnkSeqno; /* 제품 탱크 일련번호 */
	private String virtlLotSeCode; /* ZIM02 가상 LOT 구분 코드 */
	private String cntnrTyCode; /* ZSY10 용기 타입 코드 */
	private String upperReqestSeqno; /* 상위 의뢰 일련번호 */
	private String reqestSeqno; /* 의뢰 일련번호 */
	private String processTyCode; /* ZSY02 프로세스 타입 코드 */
	private String reqestSeText; /* 의뢰 구분 텍스트 */
	private String prdlstNm; /* 품목 명 */
	private String prductSeqnoText; /*저장되는 품목명 파라미터*/
	private String mtrilCode; /* 자재 코드 */
	private String prductMtrilSeqno; /* 제품 자재 일련번호 */
	private String tankNo; /* TANK NO */
	private String batchCo; /* 배치 수 */
	private String prductSeCode; /* 제품 구분 코드 */
	private String lotId; /* LOT ID */
	private String mnfcturDte; /* 제조 일자 */
	private String reqestDeptCode; /* 의뢰 부서 코드 */
	private String clientId; /* 의뢰자 ID */
	private String expriemCo; /* 시험항목 수 */
	private String rm; /* 비고 */
	private String tyDc; /* 타입 설명 */
	private String reqestSeDc; /* 의뢰 구분 설명 */
	private String virtlDc; /* 가상 설명 */
	private String virtlLotAt; /* 가상 LOT 여부 */
	private String reReqestAt; /* 재 의뢰 여부 */
	private String sanctnSeqno; /* 결재 일련번호 */
	private String rtnSeqno; /* 반려 일련번호 */
	
	private String reqestDeptNm; /*부서명*/
	private String processTyNm;	 /*프로세스 타입명*/
	private String mtrilNm;		 /*자재 명*/
	
	//시험항목 정보
	private String mtrilSdspcSeqno;            /* 자재 기준규격 일련번호 */
	private String sdspcNm;            /* 기준규격 명 */
	private String expriemSeqno;            /* 시험항목 일련번호 */
	private String jdgmntFomCode;            /* ZIM06 판정 형식 코드 */
	private String rangeValue;
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
	private String eqpmnClCode;            /* ZRS02 장비 분류 코드 */
	private String sortOrdr;            /* 정렬 순서 */
	private String updtResn;            /* 수정 사유 */
	private String coaUpdtPosblAt;            /* COA 수정 가능 여부 */
	private String frstAnalsAt;            /* 최초 분석 여부 */
	private String middleAnalsAt;            /* 중간 분석 여부 */
	private String lastAnalsAt;            /* 최종 분석 여부 */
	private String frstAnals;            /* 최초 분석 값 */
	private String middleAnals;            /* 중간 분석 값 */
	private String lastAnals;            /* 최종 분석 값 */
	private String lclValueSeNm;		/* IM08구분코드명 */
	private String uclValueSeNm;		/* IM07구분코드명 */
	private String lslValueSeNm;		/* IM08구분코드명 */
	private String uslValueSeNm;		/* IM07구분코드명 */
	private String coaUseAt;			  /* COA 사용여부 */
	private String jdgMntFomCode;
	private String lastQcResultRegisterId;
	private String lastQcResultRegistDte;
	
	//시험결과 정보, 시험결과 편균 정보
	private String lasRegistAt; /* LAS 등록 여부 */
	private String rdmsUuid; /* RDMS UUID */
	private String rdmsRegistAt; /* RDMS 등록 여부 */
	private String lasCn; /* LAS 내용 */
	private String realAnalsAt; /* 실제 분석 여부 */
	private String updtRdmsDocNo; /* 수정 RDMS 문서 번호 */
	private String exprOdr; /* 시험 차수 */
	private String calcLawSeqno; /* 계산 법 일련번호 */
	private String nomfrmNm; /* 수식 명 */
	private String nomfrmCn; /* 수식 내용 */
	private String rvsopCn; /* 역산 내용 */
	private String resultValue; /* 결과 값 */
	private String markValue; /* 표기 값 */
	private String rdmsDocNo; /* RDMS 문서 번호 */
	private String vriablId; /* 변수 ID */
	private String lastResultInputAt; /* 최종 결과 입력 여부 */
	private String qcResultValue; /* QC 결과 값 */
	private String qcMarkValue; /* QC 표기 값 */
	
	private List<PartnersCoaMVo> reqestExpriemGrid; /*시험항목 정보 그리드 데이터*/
	
	private List<PartnersCoaMVo> addExpriemGrid;    /*시험항목 추가된 데이터*/
	private List<PartnersCoaMVo> editedExpriemGrid; /*시험항목 수정된 데이터*/
	private List<PartnersCoaMVo> removeExpriemGrid; /*시험항목 삭제된 데이터*/
	
	
	//검색
	private String shrReqestDeptCode;  /*부서*/
	private String shrProcessTyCode;   /*타입*/
	private String shrPrductSeqno;     /*제품 명*/
	private String shrMtrilCode;       /*자재 코드*/
	private String shrReqestBeginDte;  /*의뢰 일자 start*/
	private String shrReqestEndDte;    /*의뢰 일자 end*/
	private String shrMnfcturBeginDte; /*제조일자 start*/
	private String shrMnfcturEndDte;   /*제조일자 end*/
	private String shrLotId;           /*LOT ID*/
	private String authorSeCode;
	private String bplcCode;			/*사업장 코드*/
	private String reqestNo;			/*의뢰 번호*/
	private String mtrilSeqno;			/*장비 일련번호*/
	private String inspctTyCode;		/*검사 유형 코드*/
	private String vendorLotNo;			/*협력업체 LOT NO*/

	
	
	private String expriemNm;			/*시헙 항목명*/
	private String expriemCl;			/*검사항목 그룹명*/
	private Integer exprNumot;		
	private String emailSndngAt;
	private String chrctrSndngAt;
	private String useAt;
	// IM_REQEST_EXPRIEM 테이블
	private String reqestExpriemSeqno;
	private String lastResultRegistDte;
	private String lastResultRegisterId;
	private String lastQcresultRegistDte;
	private String lastQcresultRegisterId;
	private String eqpmnSeqno;
	private String analsOpinion;
	private String lastExprOdr;
	private String mnfcturAnalsAt;
	private String entrpsSeqno;
	private String entrpsNm;
	private String venderLotNo;
	private String inspctTyCodeNm;
	private String bplcNm;
	// 검색 
	private String bplcCodeSch;
	private String mtrilNmSch;
	private String reqestNoSch;
	private String inspctTyCodeSch;
	private String stMnfcturDteSch;
	private String enMnfcturDteSch;
	private String vendorCoaAT;
	private String stReqestDteSch; //접수시작일
	private String enReqestDteSch; //접수종료일
	private String reqestDeptCodeSch; //의뢰팀
	
	
}
