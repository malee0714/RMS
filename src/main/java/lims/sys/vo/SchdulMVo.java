package lims.sys.vo;

import java.util.List;

import lombok.Data;

@Data
public class SchdulMVo {
	private String schdulSeqno;            /* 일정 일련번호 */
	private String schdulSeCode;            /* ZSY16 일정 구분 코드 */
	private String schdulSeCodeNm;		//일정 구분 명
	private String chrctrNtcnAt;            /* 문자 알림 여부 */
	private String timhderNtcnAt;            /* 팀장 알림 여부 */
	private String indvdlNtcnAt;            /* 개인 알림 여부 */
	private String useAt;            /* 사용 여부 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String schdulCn;            /* 일정 내용 */
	private String chrctrCn;            /* 문자 내용 */

	private String userId;            /* 이용자 ID */
	private String userNm;
	private String deptCode;
	private String inspctInsttNm;

	//조회 조건
	private String schdulSeCodeSch;
	private String useAtSch;
	
	private List<SchdulMVo> userList;
}
