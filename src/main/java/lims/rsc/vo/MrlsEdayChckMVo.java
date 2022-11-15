package lims.rsc.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MrlsEdayChckMVo {
	private String mhrlsEdayChckSeqno;            /* 기기 일상 점검 일련번호 */
	private String year;            /* 년도 */
	private String qu;            /* 분기 */
	private String inspctCrrctNm;            /* 검사 교정 명 */
	private String inspctCrrctSeCode;            /* ZIM10 검사 교정 구분 코드 */
	private String registerId;            /* 등록자 ID */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String yearSch;
	private String quSch;
	private String atchmnflSeqno;
	private String sdspcNm;
	private String type;

	String resultValue;            /* 결과 값 */
	
	String[] expriemArr;
	String[] expriemSeqnoArr;
	String[] expriemNmArr;
	String[] exprNumotArr;
	String[] resultValueArr;
	String[] reqestExpriemSeqnoArr;
	String[] reqestArr;

	
	String mhrlsSeqno;
	String reqestSeqno;
	String expriemNm;
	String expriemSeqno;
	String exprNumot; 
	String lotId;
	String resultRegisterId;
	String inspctCrrctSeCodeSch;
	String inspctCrrctNmSch;
	String calD; /*날짜 계산값*/
	String crrctCodeNm;
	String calcDate;
	String recentInspctCrrctDte;
	String reqestExpriemSeqno;
	String progrsSittnCode; /*의뢰 테이블 진행 사항 업데이트 시킬 값*/
	String reqestDte;
	String mhrlsNm;
	String mhEdayChckSeq;
	String resultRegisterNm;
	String MhrlsSeqnon;
	String inMhrlsNm;
	//메인 화면 알림 팝업 변수
	String inspctCrrctSeCodeNm;
	String inspctCrrctPrearngeDte;
	String mhrlsClCodeNm;
	String mhrlsClCode;
	
    String resultValueAvg;
	
	List<MrlsEdayChckMVo> requestaddedRowItems;
	String detectLimitApplcAt; // DL적용여부
	String applcBeginDte;
	String applcEndDte;
	String mhrlsNmSch;
	
	String chartGbn;
}
