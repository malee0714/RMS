package lims.wrk.dao;

import java.util.List;

import lims.wrk.vo.SanctnLineMVo;

public interface SanctnLineMDao {

	//결재종류목록 콤보박스
	public List<SanctnLineMVo> getSanctnKndList();

	//결재라인목록 Grid
	public List<SanctnLineMVo> getSanctnLineList(SanctnLineMVo vo);

	//사용자목록 Grid
	public List<SanctnLineMVo> getUserAList(SanctnLineMVo vo);

	//결재자목록 Grid
	public List<SanctnLineMVo> getSanctnerList(SanctnLineMVo vo);

	//결재라인 등록
	public int insertSanctnLine(SanctnLineMVo vo);

	//결재라인 수정
	public int updateSanctnLine(SanctnLineMVo vo);

	//결재라인 결재자 삭제
	public int deleteSanctner(SanctnLineMVo vo);

	//결재라인 결재자 등록
	public int insertSanctner(SanctnLineMVo vo);

	//알림대상자 전체사용자 목록조회
	public List<SanctnLineMVo> getUserNtncList(SanctnLineMVo vo);

}
