package lims.src.dao;

import java.util.List;

import lims.src.vo.RequestCntMVo;

public interface RequestCntMDao {
	/**
	 * 부서별 의뢰건수 조회
	 * @param vo
	 * @return
	 */
	public List<RequestCntMVo> getRequestCntList(RequestCntMVo vo);
	
}
