package lims.src.service;

import java.util.List;

import lims.src.vo.ImpartclLogMVo;

public interface ImPartclLogMService {
	/**
	 * 
	 * @param vo
	 * @return 먼지리스트
	 */
	public List<ImpartclLogMVo> getParticleList(ImpartclLogMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 장비리스트
	 */
	public List<ImpartclLogMVo> getMhrlsList();
}
