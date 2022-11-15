package lims.wrk.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ChrgTeamMVo {
	private String chrgTeamSeqno; /* 담당 그룹 일련번호 */
	private String inspctInsttCode; /* 검사 기관 코드 */
	private String deptCode; /* 부서 코드 */
	private String deptNm; /* 부서 명 */
	private String chrgTeamNm; /* 담당 그룹 명   */
	private String rm; /* 비고 */
	private String useAt; /* 사용 여부 */
	private String teamChargerId; /* 그룹 담당자 ID */
	private String teamChargerNm; /* 그룹 담당자 명 */
	private String userId;
	private String userNm;

	private String lastChangerId; /* 최종 변경자 ID */
	private String lastChangeDt; /* 최종 변경 일시 */

	private String bestInspctInsttNm; /* 최상위기관명 */
	private String upperInspctInsttNm; /* 상위부서명 */
	private String abrv;	//약어
	private String rceptPcIp;	//접속 ip
	private String timhderAt; //팀장여부

	// 조회조건
	private String deptCodeSearch;
	private String chrgTeamNmSearch;
	private String useAtSearch;
	private String userNmSearch;
	private String mmnySeCode;
	private String analsAtSch;
	private String limsUseAtSch;

	//콤보박스 생성용
	private String key;
	private String value;
	
	//담당팀 검색조건
	private String mhrlsSeqno;
	
	private List<ChrgTeamMVo> addedIpList;
	private List<ChrgTeamMVo> editedIpList;
	private List<ChrgTeamMVo> removedIpList;
	private List<ChrgTeamMVo> userList;
	
	protected String chrgTeamIpSeqno; /* 담당 팀 IP 일련번호 */
	protected String chrgTeamSeNm; /* 담당 팀 구분 명 */
}
