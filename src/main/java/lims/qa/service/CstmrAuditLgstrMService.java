package lims.qa.service;

import java.util.List;

import lims.qa.vo.CstmrAuditLgstrMVo;
import lims.qa.vo.VendorAuditLgstrMVo;

public interface CstmrAuditLgstrMService {
	public List<CstmrAuditLgstrMVo> getCstmrAuditLgstrMList(CstmrAuditLgstrMVo vo);
	public int insCstmrAuditLgstr(CstmrAuditLgstrMVo vo);
	public int delCstmrAuditLgstr(CstmrAuditLgstrMVo vo);
}
