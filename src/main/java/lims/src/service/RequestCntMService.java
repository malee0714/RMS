package lims.src.service;

import java.util.List;

import lims.src.vo.RequestCntMVo;

public interface RequestCntMService {
	/**
	 * 부서별 의뢰건수 조회
	 * @param vo
	 * @return
	 */
	public RequestCntMVo getRequestCntList(RequestCntMVo vo);
}
