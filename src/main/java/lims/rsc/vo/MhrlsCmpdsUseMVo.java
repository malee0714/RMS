package lims.rsc.vo;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class MhrlsCmpdsUseMVo {
	private double useTime; /* 사용 시간 */
	private int mhrlsCmpdsSeqno; /* 기기 소모품 일련번호 */
	private int ordr; /* 순서 */
	private String userId; /* 이용자 ID */
	private String useDte; /* 사용 일자 */	
	private String useBeginDt; /* 사용 시작 일시 */
	private String useEndDt; /* 사용 종료 일시 */
	private String usePurps; /* 사용 목적 */
	private String rm; /* 비고 */
	private String lastChangerId; /* 최종 변경자 ID */
	private String lastChangeDt; /* 최종 변경 일시 */
	private String recmndUseTime; /* 권장 사용 시간 */
	private String cmpdsNm; /* 소모품 명 */	
	private String chrgTeamSeqno; /* 담당 팀 일련번호 */
	private String mhrlsSeqno; /* 기기 일련번호 */
	private String mhrlsCmpdsSeCode; /* ZRS14 기기 소모품 구분 코드 */
	private String brcd; /* 바코드 */
	private String wrhousngDte; /* 입고 일자 */
	private String dsuseDte; /* 폐기 일자 */
	private String validDte; /* 유효 일자 */
	private String nowUseAt; /* 현재 사용 여부 */
	private String deleteAt; /* 삭제 여부 */
	private String mhrlsClCode;
	private String mhrlsClCodeNm;
	private String validChk;
	
	private String chrgTeamNm;
	private String mhrlsCmpdsSeNm;
	private String mhrlsNm;
	private String deptNm;
	
	
	//검색
	private String shrBrcd; /* 바코드 */
	private String shrDeptCode;
	private String shrChrgTeamSeqno;
	private String shrMhrlsCmpdsSeCode;
	private String shrMhrlsNm;
	private String shrCmpdsNm;
	private String shrMhrlsClCode;
	//저장
	private String crud; /*신규 수정여부*/
	private int succesAt; /* 저장 성공 여부*/
}
