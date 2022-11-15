package lims.wrk.vo;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Getter;
import lombok.Setter;

@JsonInclude(Include.NON_NULL)
@Getter
@Setter
public class SanctnLineMVo {

	private String sanctnLineSeqno; //결재 라인 일련번호
	private String deptCode; //부서 코드
	private String deptNm; //부서 명
	private String bpclCodeNm; //사업장 명
	private String sanctnKndCode; //ZSY05 결재 종류 코드
	private String sanctnKndNm; //ZSY05 결재 종류 명
	private String sanctnLineNm; //결재 라인 명
	private String useAt; //사용 여부
	private String deleteAt; //삭제여부
	private String lastChangerId; //최종 변경자 ID
	private String lastChangeDt; //최종 변경 일시

	private String sanctnerId; //결재자 ID
	private String sanctnSeCode; //ZIM10 결재 구분 코드
	private String sanctnSeNm; //ZIM10 결재 구분 코드 명
	private String sanctnOrdr; //결재 순서

	private String sanctnSeqno; //결재 일련번호
	private String inspctInsttCode; //검사 기관 코드
	private String inspctInsttNm; //부서명
	private String sanctnProgrsSittnCode; //ZCM01 결재 진행 상황 코드
	private String[] sanctnLineUser;
	private String userId; //User ID
	private String userNm; //사용자명
	private String userNmSch; //사용자명 검색
	private String totSanctnerCo; //총 결재자수
	private String auth; //권한 확인
	private String analsAt; //분석여부

	private String key, value;

	/* 조회조건 */
	private String cboDeptS;
	private String cboSanctnKndS;
	private String sanctnLineNmSch;
	private String useYnS;
	private String userNmS;
	private String cboSanctnerNm;
	private String userDeptCode;
	private String mmnySeCode;
	private String limsUseAtSch;
	private String bplcCodeSearch;
	
	private int count;

	private SanctnLineMVo sanctnLineVo;
	private List<SanctnLineMVo> sanctnLineList;

}
