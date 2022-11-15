package lims.wrk.dao;

import java.util.List;

import lims.wrk.vo.PrductUpperMVo;

public interface PrductUpperMDao {

	public List<PrductUpperMVo> getPrductUpp(PrductUpperMVo vo);

	public int chkNo(PrductUpperMVo vo);

	public int savePrductUpp(PrductUpperMVo prductUpperMVo);

	public int upPrductUpp(PrductUpperMVo prductUpperMVo);

	public int delPrductUpp(PrductUpperMVo prductUpperMVo);

}
