package lims.src.dao;

import java.util.List;

import lims.rsc.vo.RgntHistMVo;

public interface UseProductLogMDao {
	public List<RgntHistMVo> getUseBacode(RgntHistMVo vo);
}
