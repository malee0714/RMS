package lims.rsc.service;

import java.util.List;

import lims.rsc.vo.StdMttrMVo;

public interface StdMttrMService {
	public List<StdMttrMVo> getStdMttrList(StdMttrMVo vo);
	
	public StdMttrMVo saveStdMttrM(StdMttrMVo vo);
	
	/**
	 * 상위 표준 물질 조회
	 */
	public List<StdMttrMVo> getUpperStdMttr(StdMttrMVo vo);
	
}
