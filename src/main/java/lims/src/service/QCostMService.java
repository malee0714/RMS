package lims.src.service;

import java.util.List;

import lims.src.vo.QCostMVo;
import lims.src.vo.RequestCntMVo;

public interface QCostMService {
	/**
	 * 부서별 의뢰건수 조회
	 * @param vo
	 * @return
	 */
	public List<QCostMVo> getQCostList(QCostMVo vo);
	public List<QCostMVo> getCost(List<QCostMVo> list);
	public List<QCostMVo> getCostYear(QCostMVo vo);
	public List<QCostMVo> getCapa(List<QCostMVo> list);
	
	
}
