package lims.src.dao;

import java.util.List;

import lims.src.vo.QCostMVo;

public interface QCostMDao {
	/**
	 * 부서별 의뢰건수 조회
	 * @param vo
	 * @return
	 */
	public List<QCostMVo> getQCostList(QCostMVo vo);
	public List<QCostMVo> getCost(QCostMVo vo);
	public List<QCostMVo> getCostYear(QCostMVo vo);
	public List<QCostMVo> getCapa(QCostMVo vo);
	
	
}
