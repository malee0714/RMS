package lims.sys.service;

import java.util.List;

import lims.sys.vo.DvyfgMtrilsMVo;

public interface DvyfgMtrilsMService {
	
	/**
	 * ์กฐํ
	 * @param vo
	 * @return
	 */
	public List<DvyfgMtrilsMVo> getDvyfgMtrils(DvyfgMtrilsMVo vo);
	
	/**
	 * ์ ์ฅ
	 * @return
	 */
	public int saveDvyfgMtrils(DvyfgMtrilsMVo vo);
}
