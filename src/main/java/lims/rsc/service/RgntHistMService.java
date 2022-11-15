package lims.rsc.service;

import java.util.HashMap;
import java.util.List;


import lims.rsc.vo.RgntHistMVo;

public interface RgntHistMService {
	public List<RgntHistMVo> getPrduct(RgntHistMVo vo);
	public List<RgntHistMVo> getHistlist(RgntHistMVo vo);
}
