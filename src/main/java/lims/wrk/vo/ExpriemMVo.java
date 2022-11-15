package lims.wrk.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ExpriemMVo {

	private String expriemSeqno; //시험항목 일련번호
	private String expriemClCode; //ZSY05 시험항목 분류 코드
	private String expriemNm; //시험항목 명
	private String koreanNm; //한글 명
	private String engNm; //영문 명
	private String rdmsNm; //RDMS 명
	private String abrv; //약어
	private String rm; //비고
	private String useAt; //사용 여부
	private String deleteAt; //삭제 여부
	private String lastChangerId; //최종 변경자 ID
	private String lastChangeDt; //최종 변경 일시
	private String bplcCode; //사업장코드
	private String sortOrdr; //정렬 순서
	private Integer eqpmnEdayChckExpriemSeqno;

	private String upperKoreanNm;
	private String fee; //항목 수수료
	private String feeSeqno; //항목 수수료 일련번호
	private String prdlstCode; //품목코드
	private String cnt;
	private String expriemClCodeNm;

	// 조회용
	private String expriemNmSearch;
	private String useAtSearch;
	private String jobRealmCode;
	private String inspctInsttCode;
	private String sdspcSeqno;
	private String expriemClCodeSch;
	private String expriemCl; //검사항목 그룹명
	private String testCodeSch; //팝업조회
	private String mmnySeCode;
	private String inClCode;
	private String notInClCode;

	//시험항목 기준규격
	private String jdgmntFomCode; //ZIM06_판정 형식 코드
	private String jdgmntFomNm; //판정 기준명
	private String mxmmValue; //최대 값
	private String mxmmValueSeCode; //ZIM07_최대 값 구분 코드
	private String mxmmValueNm;
	private String mummValue; //최소 값
	private String mummValueSeCode; //ZIM08_최소 값 구분 코드
	private String mummValueNm;
	private String stbltChoiseCode; //ZIM21_적합 선택 코드
	private String improptChoiseCode; //ZIM21_부적합 선택 코드
	private String markCphr; //표기 자리수
	private String unitCode; //단위 코드
	private String chrgGroupSeqno; //담당 그룹 일련번호
	private String chargerId; //담당자 명
	private String textStdr;

	//처리기한
	private String processTmlmtDe;

	private int atchmnflSeqno;
	private int fileSeqno;

	private String exprNumot; //시험횟수
}
