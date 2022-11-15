package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.RgntHistMVo;



public interface RgntHistMDao {
	public List<RgntHistMVo> getPrduct(RgntHistMVo vo);
	public List<RgntHistMVo> getHistlist(RgntHistMVo vo);
}
