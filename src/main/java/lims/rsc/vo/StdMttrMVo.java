package lims.rsc.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class StdMttrMVo {
	private String stdMttrSeqno;            /* 표준 물질 일련번호 */
	private String chrgTeamSeqno;            /* 담당 팀 일련번호 */
	private String rgntSeCode;            /* ZRS15 시약 구분 코드 */
	private String rgntKndCode;            /* ZRS16 시약 종류 코드 */
	private String rgntNm;            /* 시약 명 */
	private String UpperRgntNm;            /* 시약 명 */
	private String wrhousngDte;            /* 입고 일자 */
	private String validDte;            /* 유효 일자 */
	private String brcd;            /* 바코드 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String rgntKndCodeNm;
	private String rgntSeCodeNm;
	private String dsuseDte;			//폐기일자
	private String dsuseAt;			//폐기여부
	private String cycle;
	private String inspctCrrctCycleCode;
	private String chrgTeamSeCode;
	private String chrgTeamSeCodeNm;
	private String manageRspnberJId;            /* 관리 책임자_정 ID */
	private String manageRspnberBId;            /* 관리 책임자_부 ID */
	private String inspctInsttCode;            /* 검사 기관 코드 */
	private String prductStndrdSeqno;
	private String UpperStndrdNm;
	private String prductStndrdNm;
	
	private String deptNm;
	private String chrgTeamNm;
	private String stdMttrSeCodeNm;
	private String mhrlsNm;
	private String deptCode;
	
	private String upperStdMttrNm;
	private String upperStdMttrSeqno;
	
	private String ordr;
	
	//조회조건
	private String deptCodeSch;		//부서
	private String chrgTeamSeqnoSch;	//담당 팀
	private String rgntKndCodeSch;	//시약 종류
	private String rgntSeCodeSch;	//시약 구분
	private String rgntNmSch;		//시약명
	private String validDteSch;
	private String pChrgTeamSeCode;
	private String manageRspnberJNm;
	private String manageRspnberBNm;
	private String inspctInsttNm;
	private String prductStndrdCnt;
	private String chrgTeamSeCodeSch;
	private String searchPop;
	private String upperStdMttrSch;
	
	private List<StdMttrMVo> addGridListData;
	private List<StdMttrMVo> removeGridListData;
	private List<StdMttrMVo> gridListData;
	
	

}
