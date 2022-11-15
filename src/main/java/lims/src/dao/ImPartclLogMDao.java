package lims.src.dao;

import java.util.List;

import lims.src.vo.ImpartclLogMVo;

public interface ImPartclLogMDao {
	/**
	 * 
	 * @param vo
	 * @return 먼지리스트
	 */
	public List<ImpartclLogMVo> getParticleList(ImpartclLogMVo vo);
	
	/**
	 * 
	 * @return 장비리스트
	 */
	public List<ImpartclLogMVo> getMhrlsList();
}
