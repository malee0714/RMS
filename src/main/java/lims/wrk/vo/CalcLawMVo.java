package lims.wrk.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Setter
@Getter
public class CalcLawMVo {

	/* SY 계산법 */
	private String calcLawSeqno; //계산 법 일련번호
	private String mtrilSeqno; //자재일련번호
	private String mtrilCode; //자재코드
	private String mtrilNm; //자재명
	private String expriemSeqno; //시험항목 일련번호
	private String calcLawNm; //계산 법 명
	private String nomfrmCn; //수식 내용
	private String rvsopCn; //역산 내용
	private String vriablId; //변수 ID

	/* SY 계산 수식 변수 */
	private String vriablSeqno; //변수 일련번호
	private String vriablNm; //변수 명
	private String vriablUnitNm; //변수 단위 명
	private String bassValue; //기본 값
	private String vriablDc; //변수 설명
	private String markCphr; //표기 자리수
	private String rdmsCntcAt; //RDMS 연계 여부
	private String lasCntcAt; //las 연계 여부
	private String dataChangeAt; //데이터 변경 여부

	/* 공통 */
	private String useAt; //사용 여부
	private String deleteAt; //삭제 여부
	private String lastChangerId; //최종 변경자 ID
	private String lastChangeDt; //최종 변경 일시
	private String gbnCrud;

	/* 조회조건 */
	private String bplcCodeSch;
	private String useSch;
	private String expriemNm;
	private String expriemClCode;
	private String calcLawNmSch;
	private String expriemSeqnoSch;
	private String expriemNmSch;
	private String processTyCodeSch;
	private String deptCodeSch;
	private String deptCode;
	private List<CalcLawMVo> list;
	private List<CalcLawMVo> calcGridList;
	private String mtrilNmSch;
	private String mtrilCodeSch;
	private String mtrilTyCodeSch;
	private String qcVriablValue;
	private String rvsopCphrRandomCreatAt;
	private String jdgmntFomCode;
	private String jdgmntFomNm;

	/* 출처 확인 필요 */
	private String vriablValue; //변수 값
	private String calcCnt;
	private String vriablDetailId;
	private String rdmsDocNo;
	private String rdmsRegistAt;
	private String validPdCycle; //유효 기간 주기
	private String validPdCycleCode; //ZSY14 유효 기간 주기 코드

	/* 자재 팝업 조회조건 */
	private String mmnySeCode;
	private String mtrilTyNm;
	private String mtrilTyCode;
	private String bplcCode;
	private String lotCode;
	private String cntnrSeNm;
	private String deptNm;
	private String lotMxtrRule1Code;
	private String lotMxtrRule2Code;
	private String lotMxtrRule3Code;
	private String lotMxtrRule4Code;
	private String lotMxtrRule5Code;
	private String lotMxtrRule1Digit;
	private String lotMxtrRule2Digit;
	private String lotMxtrRule3Digit;
	private String lotMxtrRule4Digit;
	private String lotMxtrRule5Digit;
	private String lotNoCphr;
	private String lblDcOutptAt;
	private String prductSeCodeNm;
	private String prductSeCode;
	
	//계산식 combo만들기 위한 vo
	private String key;
	private String value;
	
	//결과입력에서 계산식에 사용하기 위한 변수
	private String reqestExpriemSeqno;
	private String exprOdr;
	private String exprNumot;
	private String realAnalsAt;
	private String realAnalsDt;
	
}
