package lims.src.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.src.dao.IssueSearchMDao;
import lims.src.service.IssueSearchMService;
import lims.test.vo.IssueMVo;

@Service
public class IssueSearchMServiceImpl implements IssueSearchMService {
	
	@Autowired
	private IssueSearchMDao issueSearchMDao;

	@Override
	public List<IssueMVo> getIssueSearchList(IssueMVo vo) {
		return issueSearchMDao.getIssueSearchList(vo);
	}

}
