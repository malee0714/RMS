package lims.qa.dao;

import java.util.List;

import lims.qa.vo.CstmrAuditMVo;


public interface CstmrAuditMDao {
	public List<CstmrAuditMVo> getCstmrAuditMList(CstmrAuditMVo vo);
	public int insCstmrAudit(CstmrAuditMVo vo);
	public int updCstmrAudit(CstmrAuditMVo vo);
	public int delCstmrAudit(CstmrAuditMVo vo);
}
