package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.SanctnLineMVo;

public interface SanctnLineMService {

	//결재종류목록 콤보박스
	public List<SanctnLineMVo> getSanctnKndList();

	//결재라인목록 Grid
	public List<SanctnLineMVo> getSanctnLineList(SanctnLineMVo vo);

	//사용자목록 Grid
	public List<SanctnLineMVo> getUserAList(SanctnLineMVo vo);

	//결재자목록 Grid
	public List<SanctnLineMVo> getSanctnerList(SanctnLineMVo vo);

	//저장
	public int saveSanctnLine(SanctnLineMVo vo);

	//알림대상자 전체사용자 목록조회
	public List<SanctnLineMVo> getUserNtncList(SanctnLineMVo vo);
}
