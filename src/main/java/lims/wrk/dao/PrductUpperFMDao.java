package lims.wrk.dao;

import java.util.List;

import lims.wrk.vo.PrductUpperMVo;

public interface PrductUpperFMDao {

	public List<PrductUpperMVo> getPrductUppFM(PrductUpperMVo prductUpperMVo);

	public int savePrductUppFM(PrductUpperMVo prductUpperMVo);
	
	public int upPrductUppFM(PrductUpperMVo prductUpperMVo);

	public int delPrductUppFM(PrductUpperMVo prductUpperMVo);
	
	public int chkNo(PrductUpperMVo prductUpperMVo);
	
	public PrductUpperMVo chkPrductUpp(PrductUpperMVo vo);

}
