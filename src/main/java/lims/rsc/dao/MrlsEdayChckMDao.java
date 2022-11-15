package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.MrlsEdayChckMVo;
import lims.req.vo.RequestMVo;

public interface MrlsEdayChckMDao {
	//검사 교정 조회
	public List<MrlsEdayChckMVo> searchMrlsChk(MrlsEdayChckMVo vo);
	//의뢰 헤더 조회
	public List<MrlsEdayChckMVo> searchReqVal(MrlsEdayChckMVo vo);
	//의뢰 결과값 조회
	public List<MrlsEdayChckMVo> searchValDetail(MrlsEdayChckMVo vo);
	//검사교정 저장			
	public int saveMrlsChk(MrlsEdayChckMVo vo);
	//검사교정 수정
	public int upMrlsChk(MrlsEdayChckMVo vo);
	
	//검사 교정 저장에 따른 기기일자 업데이트
	public int upMhrlsDate(MrlsEdayChckMVo vo);
	//검사교정 의뢰 추가 저장
	public int saveMrlsChkReq(MrlsEdayChckMVo vo);
	
	//검사 교정 저장에 따른 의뢰 진행 사항 업데이트 
	public int upImReqDate(MrlsEdayChckMVo vo);
	//의뢰 추가 조회
	public List<MrlsEdayChckMVo> searchReqList(MrlsEdayChckMVo vo);
	
	//의뢰 목록 삭제
	public int delReqDetail(MrlsEdayChckMVo mrlsEdayChckMVo);
	//차트 조회
	public List<MrlsEdayChckMVo> MecChartList(MrlsEdayChckMVo vo);
	
	public int updEdayChckInfo(MrlsEdayChckMVo vo);
	
	public int updDelReqDetail(MrlsEdayChckMVo vo);
	
	public int saveMhrlsDl(MrlsEdayChckMVo vo);
	
	public int upMhrlsDl(MrlsEdayChckMVo vo);

}
