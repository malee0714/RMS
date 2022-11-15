package lims.wrk.vo;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lims.com.vo.CmSanctn;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class EntrpsSpecMVo extends CmSanctn {
	private String entrpsNm;				/*업체 명*/
	private String prductSeqno; 			/*제품 일련번호 */
	private String prductNm;				/*제품 명*/
	private String prductNo;


	private String sanctnSeCode; 			/*ZCM02 결재 구분 코드*/
	private String lastChangerNm; 			/*변경자*/
	private String sanctnerNmRev; 			/*검토자 */
	private String sanctnerNmCon; 			/*협의자 */
	private String sanctnerNmAck; 			/*승인자  */                                                          
	private String changerNm; 				/* 변경자 Nm */
	private String prductCtmmnyMtrilSeqno;  /* 제품 고객사 자재 일련번호 */
	private String prductMtrilSeqno; 		/* 제품 자재 일련번호 */
	private String ctmmnyMummValueSeCode; 	/* ZIM08 고객사 최소 값 구분 코드 */
	private String ctmmnyMxmmValue; 		/* 고객사 최대 값 */
	private String ctmmnyMxmmValueSeCode;	/* ZIM07 고객사 최대 값 구분 코드 */
	private String extrlMummValue; 			/* 외부 최소 값 */
	private String extrlMummValueSeCode;	/* ZIM08 외부 최소 값 구분 코드 */
	private String extrlMxmmValue; 			/* 외부 최대 값 */
	private String extrlMxmmValueSeCode; 	/* ZIM07 외부 최대 값 구분 코드 */
	private String textStdr; 				/* 텍스트 기준 */

	private String ctmmnyMummValue; 		/* 고객사 최소 값 */
	private String dsuseResn;               /* 변경 사유 */
	private String markCphr;			    /* 표기 자리수 */
	private String sanctnProgrsAt;			/* 결재 진행 여부 */
	private String ctmspcMarkCphr;			/* 고객사 제품표기 */
	private String ctmspcUnitSeqno;			/* 고객사 단위 */
	private String sanctnLineNm;			/* 결재 라인명 */
	//private String sanctnKndCode;			/* ZCM05 결재 종류 코드 */
	private String totSanctnerCo;           /* 총 결재자수 */
	private String chckerSumry; 			/* 검토자 요약 */
	private String spprtrSumry; 			/* 협조자 요약 */
	
	//private String sanctnRecomDte;			/* 등록일자(결재일자) */
	private String sanctnProgrsSittnCod;	/* 진행상황 코드 */
	private String sanctnProgrsSittnNm;	    /* 진행상황 명 */

	
	
	private String prductSdspcSeqno;		/* 제품 기준규격 일련번호 */
	private String expriemSeqno;			/* 시험항목 일련번호 */
	private String expriemCl;				/* 검사항목 그룹명 */
	private String expriemNm;				/* 시험항목 명 */
	private String unitNm;					/* 제품 단위 */
	private String jdgmntFomNm;				/* 판정 형식 */
	private String firstMummValue;			/* 1차 LCL */
	private String firstMummValueSeNm;		/* 1차 LCL 단위 */
	private String scdMummValue;			/* 2차 LCL */
	private String scdMummValueSeNm;		/* 2차 LCL 단위 */
	private String firstMxmmValue;			/* 1차 UCL */
	private String firstMxmmValueSeNm;		/* 1차 UCL 단위 */
	private String scdMxmmValue;			/* 2차 UCL */
	private String scdMxmmValueSeNm;		/* 2차 UCL 단위 */
	private String spsTextStdr;				/* 텍스트 기준 */
	private String spsMarkCphr;				/* 제품 표기 자리수 */
	
	private String resultRangef;				/*1차 합산 결과*/
	private String resultRanges;				/*2차 합산 결과*/
	
	private String mtrilCode;		/* 자재 코드 */
	private String mtrilNm;			/* 자재 명 */
	private String prductSeCode;	/* 자재구분 */
	private String ctmmnyMtrilAt;   /* 제품 고객사 자재 일련번호 확인  */ 
	
	private String sanctnOrdr;		/* 결재 순서 */
	private String userNm;			/* 결재자 명 */
	
	//결재 배포
	private String sanctnSj;
	private String sanctnCn;
	private String wdtbPrearngeDt;
	private String wdtbDt;
	private String wdtbSeqno;
	
	
	private List<EntrpsSpecMVo> requestGridData;	/* 시험항목 그리드 데이터 */
	private List<EntrpsSpecMVo> sanctnInfoGridData; /* 결재정보 그리드 데이터 */
	private List<EntrpsSpecMVo> materialGridData;	/* 시험항목 그리드 데이터 */
	private List<EntrpsSpecMVo> requestRemove;		/* 시험항목 삭제 그리드 데이터 */
	private List<EntrpsSpecMVo> requestEdite;		/* 시험항목 수정 그리드 데이터 */
	private List<EntrpsSpecMVo> requestAdd;		/* 시험항목 추가 그리드 데이터 */
	private String crud;
	
	private String requestCnt;		/* 시험항목 정보 수정 여부 */
	private String materialCnt;		/* 자재 정보 수정 여부 */
	private String sanctnInfoCnt;	/* 결재 정보 수정 여부 */
	
	private String shrMmnySeCode;		/* 자사구분	*/
	private String shrInspctInsttCode;  /* 부서		*/
	private String shrPrductNm;         /* 제품 명		*/
	private String shrPrductNo;         /* 제품 번호	*/
	private String shrProcessTyCode;    /* 프로세스 타입 */
	private String shrEntrpsNm;         /* 업체 명        */

	private String shrHis;              /* 이력 조회 구분 */
	private String prductUpperSeqno;
	private String shrLastVerAt;        /* 최종버전 여부 */
	
	/* 21-07-09 */
	//SY_PRDUCT_CTMMNY
	private String prductCtmmnySeqno;            /* 제품 고객사 일련번호 */
	private String ver;            /* 버전 */
	private String entrpsSeqno;            /* 업체 일련번호 */
	private String stdrNm;            /* 기준 명 */
	private String changerId;            /* 변경자 ID */
	private String changeDte;            /* 변경 일자 */
	private String updtResn;            /* 수정 사유 */
	//private String sanctnSeqno;            /* 결재 일련번호 */
	private String beginDte;            /* 시작 일자 */
	private String endDte;            /* 종료 일자 */
	private String atchmnflSeqno;            /* 첨부파일 일련번호 */
	private String lastVerAt;            /* 최종 버전 여부 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String bplcCode;
	private String useAt;				/* 사용여부 */
	private String shrMtrilCode;
	// SY_PRDUCT_CTMMNY_SDSPC
	private String prductCtmmnySdspcSeqno;            /* 제품 고객사 기준규격 일련번호 */
	private String mtrilSdspcSeqno;            /* 자재 기준규격 일련번호 */
	private String lslValue;            /* LSL 값 */
	private String lslValueSeCode;            /* ZIM08 LSL 값 구분 코드 */
	private String uslValue;            /* USL 값 */
	private String uslValueSeCode;            /* ZIM07 USL 값 구분 코드 */
	private String unitSeqno;            /* 단위 일련번호 */

	// SY_PRDUCT_CTMMNY_MTRIL
	private String mtrilSeqno;            /* 자재 일련번호 */

	//
	
	//private String sanctnerNm;
	private String sanctnLineSeqno;
	private String sanctnerId;
	//private String sanctnProgrsSittnCode; 	/*진행상황*/
	//private String sanctnProgrsSittnCodeNm;
	private String sanctnDte; 				/*등록일자(결재일자)*/
	private String confmerSumry; 			/* 승인자 요약 */
	private String bplcCodeSch; /*사업장 조회*/
	private String mtrilTyCodeSch; /*자재유형 조회*/
	private String prductSeCodeSch; /*자재코드 조회*/
	private String shrUseAt;            /* 사용 여부 조회      */
	private String shrMtrilNm;			/* 자재명 조회 */
	private String loginId;
	private int ordr;
	//상신
	List<EntrpsSpecMVo> SanctnerList;
	//결재
	private int sanctnNextCnt;
	//반려
	private String rtnResn;
	private String returnerId;
	List<EntrpsSpecMVo> rtnList;
	
	private String insApp; // 저장 하지않고 바로 상신할경우 사용

	private List<EntrpsSpecMVo> RequestListData;


}
