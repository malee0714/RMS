package lims.qa.dao;

import java.util.List;

import lims.qa.vo.VendorAuditMVo;


public interface VendorAuditMDao {
	public List<VendorAuditMVo> getVendorAuditMList(VendorAuditMVo vo);
	public int insVendorAudit(VendorAuditMVo vo);
	public int updVendorAudit(VendorAuditMVo vo);
	public int delVendorAudit(VendorAuditMVo vo);
}
