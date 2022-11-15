package lims.qa.service;

import java.util.List;

import lims.qa.vo.CstmrAuditMVo;

public interface CstmrAuditMService {
	public List<CstmrAuditMVo> getCstmrAuditMList(CstmrAuditMVo vo);
	public int insCstmrAudit(CstmrAuditMVo vo);
	public int delCstmrAudit(CstmrAuditMVo vo);
}
