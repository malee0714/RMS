package lims.rsc.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CndtnCheckMVo {
	
	//검색조건
	private String cndtnInspctIemCodeSch; 	/*기기검색*/
	private String writngDeStart;			/*시작 점검일자*/
	private String writngDeFinish;			/*종료 점검일자*/
	private String repairDeStart;			/*시작 수리일자*/
	private String repairDeFinish;			/*종료 수리일자*/
	private String mhrlsNm;
	private String userNm;
	private String mhrlsClNm;				/*기기분류*/
	private String mhrlsManageNo;			/*기기관리번호*/
	private String mnfcturCmpnyNm;			/*제조회사명*/
	private String manageDeptNm;			/*관리부서*/
	private String messAges;
	private String countVal;
	private String detailSeq;
	private String mhrlsSeqnoSch;		/*팝업 기기 조회*/
	private String langCode;
	
	//공통코드 테이블
	private String cmmnCode;            /* 공통 코드 */
	private String upperCmmnCode;            /* 상위 공통 코드 */
	private String cmmnCodeNm;            /* 공통 코드 명 */
	private String cmmnCodeRm;            /* 공통 코드 비고 */
	private String sortOrdr;            /* 정렬 순서 */
	private String useAt;            /* 사용 여부 */
	private String scrinUseAt;            /* 화면 사용 여부 */

	
	// 저장테이블 테이블
	private String cndtnChckSeqno;            /* 공조기 점검 일련번호 */
	private String cndtnInspctIemCode;            /* ZRS13 공조기 검사 항목 코드 */
	private String tmprField1Value;            /* 임시 필드1 값 */
	private String tmprField2Value;            /* 임시 필드2 값 */
	private String tmprField3Value;            /* 임시 필드3 값 */
	private String tmprField4Value;            /* 임시 필드4 값 */
	private String tmprField5Value;            /* 임시 필드5 값 */
	private String chckResultValue;            /* 점검 결과 값 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	
	//저장테이블 점검항목
	private String mhrlsSeqno;            /* 기기 일련번호 */
	private String insctrId;            /* 점검자 ID */
	private String chckDte;            /* 점검 일자 */
	private String chckItem;		/* 점검 항목 */
	private String chckWeek;            /* 점검 주 */
	private String deleteAt;            /* 삭제 여부 */
	private String genDate;

	private String mhrlsClCode;
	
	private List<CndtnCheckMVo> list;
	private List<CndtnCheckMVo> listDate;
	
	
	
}
