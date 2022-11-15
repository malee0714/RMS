package lims.sys.vo;

import java.util.List;

import lombok.Data;

@Data
public class InsttMVo {

	private String inspctInsttCode;            		/* 검사 기관 코드 */
	private String bestInspctInsttCode;             /* 최상위 검사 기관 코드 */
	private String upperInspctInsttCode;            /* 상위 검사 기관 코드 */
	private String inspctInsttNm;           		/* 검사 기관 명 */
	private String telno;            				/* 전화번호 */
	private String fxnum;            				/* 팩스번호 */
	private String email;            				/* 이메일 */
	private String hmpg;            				/* 홈페이지 */
	private String zip;            					/* 우편번호 */
	private String adres;            				/* 주소 */
	private String detailAdres;           			/* 상세 주소 */
	private String dc;            					/* 설명 */
	private String deptAt;            				/* 부서 여부 */
	private String useAt;           				/* 사용 여부 */
	private String sortOrdr;            			/* 정렬 순서 */
	private String logoFileSeqno;            		/* 로고 파일 일련번호 */
	private String offcsFileSeqno;            		/* 직인 파일 일련번호 */
	private String delngBankNm;            			/* 거래 은행 명 */
	private String acnutNo;            				/* 계좌 번호 */
	private String dpstrNm;            				/* 예금자 명 */
	private String rprsntvNm;            			/* 대표자 명 */
	private String bsnmRegistNo;            		/* 사업자 등록 번호 */
	private String rqstdocRm;            			/* 의뢰서 비고 */
	private String prqudoRm;            			/* 견적서 비고 */
	private String rdmsGroupId;            			/* RDMS 그룹 ID */
	private String dprlrId;            				/* 부서장 ID */
	private String lastChangerId;            		/* 최종 변경자 ID */
	private String lastChangeDt;            		/* 최종 변경 일시 */
	private String stbltJdgmntNm;            		/* 적합 판정 명 */
	private String improptJdgmntNm;            		/* 부적합 판정 명 */
	private String cnfirmJdgmntNm;            		/* 확인 판정 명 */
	private String value;							/* 콤보박스 value값 */
	private String key;								/* 콤보박스 key값 */
	private int level;								/* 콤보박스 계층*/
	private String insttMLv;						/* 기관 분류 */
	private String ocslFileSeqno;
	private String deptYn;

	private String mmnySeCode; 						/* 자사구분코드 */
	private String ifObjtid;						/*IF OBJTID*/
	private String analsAt;            /* 분석 여부 */
	private String qualfmanManageAt;            /* 자격자 관리 여부 */
	private String deleteAt;            /* 삭제 여부 */
	private String deptCode;
	private String abrv;            /* 약어 */

	//검색
	private String inspctInsttNmSch;
	private String useLa;
	private String useLy;
	private String useLn;
	private String secodea;
	private String secodey;
	private String secoden;
	private String upperInspctInsttCodeSch;
	private String bestInspctInsttCodeSch;
	private String isleaf;
	private String mmnySeCodeSch;
	private String useAtSch;
	private String qualfmanManageAtSch;
	private String bestInspctInsttCodeNm;
	private String upperInspctInsttCodeNm;
	private String analsAtSch;
	

	private List<InsttMVo> helpTeamGrid;

	private String chrgTeamSeqno; /* 담당 팀 일련번호 */
	private String chrgTeamNm; /* 담당 팀 명 */
	private String rceptPcIp; /* 접수 PC IP */
	private String rm; /* 비고 */

	//검색
	private String shrDeptCode;
	private String chk;
	private String limsUseAt;
	private String limsUseAtSch;
	private String qualfmanManageAtOr;
	private String bestInspctInsttAt; //사업장 여부
	private Boolean isRdmsIp;         //rdms ip 존재 여부
}
