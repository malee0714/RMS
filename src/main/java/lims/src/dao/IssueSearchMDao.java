package lims.src.dao;

import java.util.List;

import lims.test.vo.IssueMVo;

public interface IssueSearchMDao {
	public List<IssueMVo> getIssueSearchList(IssueMVo vo);
}
