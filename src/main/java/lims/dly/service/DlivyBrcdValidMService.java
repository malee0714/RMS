package lims.dly.service;

import java.util.HashMap;

import lims.dly.vo.DlivyMVo;

public interface DlivyBrcdValidMService {
	/**
	 * 바코드 검증 조회
	 * @param vo
	 * @return
	 */
	public HashMap<String, Object> getBrcdVal(DlivyMVo vo);
}
