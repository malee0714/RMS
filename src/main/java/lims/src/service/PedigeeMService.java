package lims.src.service;

import java.util.List;

import lims.src.vo.PedigeeMVo;
import lims.test.vo.IssueMVo;

public interface PedigeeMService {
	public List<PedigeeMVo> getUpperPrduct(PedigeeMVo vo);

	public List<PedigeeMVo> getReqestPrductList(PedigeeMVo vo);
	
	public List<IssueMVo> getReqestIssueList(IssueMVo vo);
}
