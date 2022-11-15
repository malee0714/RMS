package lims.qa.dao;

import java.util.List;

import lims.qa.vo.CstmrAuditLgstrMVo;
import lims.qa.vo.VendorAuditLgstrMVo;


public interface CstmrAuditLgstrMDao {
	public List<CstmrAuditLgstrMVo> getCstmrAuditLgstrMList(CstmrAuditLgstrMVo vo);
	public int insCstmrAuditLgstr(CstmrAuditLgstrMVo vo);
	public int updCstmrAuditLgstr(CstmrAuditLgstrMVo vo);
	public int delCstmrAuditLgstr(CstmrAuditLgstrMVo vo);
}
