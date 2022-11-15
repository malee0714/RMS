package lims.qa.service;

import java.util.List;

import lims.qa.vo.VendorAuditMVo;

public interface VendorAuditMService {
	public List<VendorAuditMVo> getVendorAuditMList(VendorAuditMVo vo);
	public int insVendorAudit(VendorAuditMVo vo);
	public int delVendorAudit(VendorAuditMVo vo);
}
