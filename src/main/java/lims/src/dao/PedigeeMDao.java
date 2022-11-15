package lims.src.dao;

import java.util.List;

import lims.src.vo.PedigeeMVo;
import lims.sys.vo.InsttMVo;
import lims.test.vo.IssueMVo;

public interface PedigeeMDao {
	public List<PedigeeMVo> getUpperPrduct(PedigeeMVo vo);
	
	public List<PedigeeMVo> getReqestPrductList(PedigeeMVo vo);
	
	public List<IssueMVo> getReqestIssueList(IssueMVo vo);
}
