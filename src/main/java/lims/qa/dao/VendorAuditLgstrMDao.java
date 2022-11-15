package lims.qa.dao;

import java.util.List;

import lims.qa.vo.VendorAuditLgstrMVo;
import lims.qa.vo.VendorAuditMVo;


public interface VendorAuditLgstrMDao {
	public List<VendorAuditLgstrMVo> getVendorAuditLgstrMList(VendorAuditLgstrMVo vo);
	public int insVendorAuditLgstr(VendorAuditLgstrMVo vo);
	public int updVendorAuditLgstr(VendorAuditLgstrMVo vo);
	public int delVendorAuditLgstr(VendorAuditLgstrMVo vo);
}
