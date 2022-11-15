package lims.rsc.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class MhrlsUnInspctMVo {
	
	private String unregistEqpSeqno; /* 미등록 설비 일련번호 */
	private String deptCode; /* 부서 코드 */
	private String deptNm; /* 부서명 */	
	private String mhrlsNm; /* 기기 명 */
	private String inspctCrrctChargerNm; /* 검사 교정 담당자 명 */
	private String mhrlsManageNo; /* 기기 관리 번호 */
	private String inspctCrrctMthCode; /* ZRS12 검사 교정 방법 코드 */
	private String inspctCrrctCycle; /* 검사 교정 주기 */
	private String inspctCrrctDte; /* 검사 교정 일자 */
	private String inspctCrrctPlanDte; /* 검사 교정 계획 일자 */
	private String nextInspctCrrctDte; /* 다음 검사 교정 일자 */
	private String sanctnDrftDte; /* 결재 기안 일자 */
	private String inspctCrrctOpertnAt; /* 검사 교정 시행 여부 */
	private String deleteAt; /* 삭제 여부 */
	private String lastChangerId; /* 최종 변경자 ID */
	private String lastChangeDt; /* 최종 변경 일시 */
	
	private String shrDeptCode;
	private String shrInspctCrrctMthCode;
	private String shrInspctCrrctOpertnAt;
	private String shrInspctCrrctBeginDte;
	private String shrInspctCrrctEndDte;
	
	private List<MhrlsUnInspctMVo> addGridData;
	private List<MhrlsUnInspctMVo> editGridData;
	private List<MhrlsUnInspctMVo> removeGridData;
	
	private String month;
	private String monthData;
	private String implement;
	private String deptMonthData;
	private String deptImplement;
}
