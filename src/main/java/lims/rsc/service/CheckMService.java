package lims.rsc.service;

import java.util.HashMap;
import java.util.List;

import lims.rsc.vo.CheckMVo;
import lims.rsc.vo.PurchsRequestFixMVo;
import lims.rsc.vo.PurchsRequestMVo;

public interface CheckMService {
	public List<CheckMVo> getCheckMList(CheckMVo vo);
	public List<CheckMVo> getCheckDetailMList(CheckMVo vo);
	public HashMap<String,Object> saveCheckDetailMList(List<CheckMVo> vo);
}
