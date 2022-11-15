package lims.rsc.service;

import java.util.List;

import lims.rsc.vo.CndtnCheckMVo;

public interface CndtnCheckMService {
	//상단 그리드 조회
	public List<CndtnCheckMVo> getcndtn(CndtnCheckMVo vo);
	//하단 그리드 조회
	public List<CndtnCheckMVo> getCnd(CndtnCheckMVo vo);

	//테이블값 저장
	public int saveCndtnDetail(CndtnCheckMVo list);
	
	//상단 그리드 클릭시 하단 그리드 조회(디테일)
	public List<CndtnCheckMVo> getCndVal(CndtnCheckMVo vo);
	
	//그리드 조회(기기값 및 날짜 값이 있을 경우 보여주기 위함)
	public List<CndtnCheckMVo> selectmhr(CndtnCheckMVo vo);
	
	//수치 차트 조회
	public List<CndtnCheckMVo> getchValueList(CndtnCheckMVo vo);
	
	// 넘어온 값으로 차트 조회
	public CndtnCheckMVo getchkValueList(CndtnCheckMVo vo);
	





}
