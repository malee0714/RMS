package lims.rsc.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class EqpmnManageDto {

	private Integer eqpmnSeqno;				//장비 일련번호
	private String bplcCode;                //사업장
	private String eqpmnClCode;   			//ZRS02 장비 분류
	private String eqpmnClNm;
	private String eqpmnManageNo;			//장비 관리 번호
	private String eqpmnNm;					//장비 명
	private String mnfcturCmpnyNm;			//제조 회사 명
	private String modlNm;					//모델
	private String serialNo;				//SERIAL NO
	private String dvyfgofficNm;            //납품처
	private String purchsDte;				//구입 일자
	private String prpos;					//용도
	private Integer custlabSeqno;           //분석실
	private String custlabNm;               //분석실 명
	private String replcEqpmnNm;			//대체 장빔 명
	private String replcEqpmn;
	private String analsReqreTime;          //분석 소요 시간
	private String chrgDeptCode;			//담당 부서
	private String chrgDeptNm;
	private Integer manageRspnberJId;		//관리 책임자(정)
	private Integer manageRspnberBId;		//관리 책임자(부)
	private String manageRspnberJ;
	private String manageRspnberB;
	private String acqsSttusCode;			//ZRS03 취득 상태
	private String acqsSttus;
	private long acqsAmount;				//취득 금액
	private Integer cnYycnt;				//내용 년수
	private String wrhousngDte;				//입고 일자
	private String mhrlsSttusCode;			//ZRS04 장비 상태
	private String mhrlsSttus;
	private String dsuseDte;				//폐기 일자
	private String dsuseResn;				//폐기 사유
	private String oprAt;					//가동 여부
	private Integer atchmnflSeqno;		    //첨부파일
	private String lasUseAt;				//LAS 사용 여부
	private String mhrlsPcIp;				//장비 PC IP
	private String comPortNo;				//COM PORT NO
	private String commnVeValue;			//통신 속도 값
	private String dataBitValue;			//데이터 비트 값
	private String parityValue;				//PARITY 값
	private String dtrWireValue;            //DTR 회선 값
	private String rm;						//비고
	private String lasResultSeCode;         //ZRS18 LAS 결과 구분
	private String lasResult;
	private String useAt;					//사용 여부
	private String deleteAt;				//삭제 여부
	private String lastChangerId;			//최종 변경자 ID
	private String lastChangeDt;			//최종 변경 일시

	// 조회조건
	private String schEqpmnClCode;
	private String schCustLab;
	private String schEqpmnNm;
	private String schUseAt;

	// 관련 제품
	private Integer eqpmnAnalsPrductSeqno;  //장비분석제품 일렬번호
	private String mtrilSeqno;				//자재 일렬번호
	private String prductSeCodeNm;          //제품구분 명
	private String mtrilTyNm;
	private String mtrilCode;				//자재 코드
	private String mtrilNm;					//자재 명
	private String deptCode;				//부서 코드
	private String deptNm;

	// 관련 시험항목
	private Integer eqpmnAnalsIemSeqno;     //장비분석항목 일련번호
	private String expriemNm;

	// 검교정 주기정보
	private String inspctCrrctSeCode;       //ZRS24 검사 교정 구분 코드
	private String inspctCrrctSeNm;
	private Integer inspctCrrctCycle;       //검사 교정 주기
	private String recentInspctCrrctDte;    //최근 검사 교정 일자
	private String inspctCrrctPrearngeDte;  //검사 교정 예정 일자
	private String cycleCode;               //ZSY14 주기 코드
	private String cycleCodeNm;
	
	// 신뢰성평가 시험항목
	private Integer eqpmnRlabltyEvlExpriemSeqn;  //신뢰성평가 시험항목 일렬번호
	private Integer expriemSeqno;                //시험항목 일렬번호
	private int sortOrdr;                        //정렬 순서
	
	// 일상점검 시험항목
	private Integer eqpmnChckExpriemSeqno;  	//일상점검 시험항목 일렬번호
	private String jdgmntFomCode;               //ZIM06 판정 형식 코드
	private String jdgmntFomNm;
	private String mummValue;                   //LCL
	private String mummValueSeCode;             //ZIM08 최소 값 구분 코드
	private String mummValueNm;
	private String mxmmValue;                   //UCL
	private String mxmmValueSeCode;             //ZIM07 최대 값 구분 코드
	private String mxmmValueNm;
	private String unitSeqno;                   //단위 일련번호
	private String textStdr;                    //텍스트 기준

	// 그리드 리스트
	private List<EqpmnManageDto> relateMtrilGrid;      //관련 제품
	private List<EqpmnManageDto> relateExprGrid;       //관련 시험항목
	private List<EqpmnManageDto> inspctCrrctGrid; 	 //검교정 주기정보
	private List<EqpmnManageDto> rlbExpriemGrid;       //신뢰성평가 시험항목
	private List<EqpmnManageDto> edayExpriemGrid;      //일상점검 시험항목

}
