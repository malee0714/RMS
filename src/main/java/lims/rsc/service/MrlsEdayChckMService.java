package lims.rsc.service;

import java.util.List;
import lims.rsc.vo.MrlsEdayChckMVo;

public interface MrlsEdayChckMService {
	
	//검사 교정 조회
	public List<MrlsEdayChckMVo> searchMrlsChk(MrlsEdayChckMVo vo);
	//의뢰 결과 헤더값 조회
	public List<MrlsEdayChckMVo> searchReqVal(MrlsEdayChckMVo vo);
	// 의뢰 결과 값 조회
	public List<MrlsEdayChckMVo> searchValDetail(MrlsEdayChckMVo vo);
	//검사 교정 저장
	public int saveMrlsChk(MrlsEdayChckMVo vo);
	//의뢰추가 조회
	public List<MrlsEdayChckMVo> searchReqList(MrlsEdayChckMVo vo);
	
	//의뢰목록 삭제
	public int delReqDetail(List<MrlsEdayChckMVo> list);
	//차트 조회
	public List<MrlsEdayChckMVo> MecChartList(MrlsEdayChckMVo vo);

	public int delReqAll(MrlsEdayChckMVo vo);

}
