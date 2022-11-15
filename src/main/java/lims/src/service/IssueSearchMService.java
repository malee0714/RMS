package lims.src.service;

import java.util.List;

import lims.test.vo.IssueMVo;

public interface IssueSearchMService{
	public List<IssueMVo> getIssueSearchList(IssueMVo vo);
}
