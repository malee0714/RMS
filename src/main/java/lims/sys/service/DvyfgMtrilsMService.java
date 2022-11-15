package lims.sys.service;

import java.util.List;

import lims.sys.vo.DvyfgMtrilsMVo;

public interface DvyfgMtrilsMService {
	
	/**
	 * 조회
	 * @param vo
	 * @return
	 */
	public List<DvyfgMtrilsMVo> getDvyfgMtrils(DvyfgMtrilsMVo vo);
	
	/**
	 * 저장
	 * @return
	 */
	public int saveDvyfgMtrils(DvyfgMtrilsMVo vo);
}
