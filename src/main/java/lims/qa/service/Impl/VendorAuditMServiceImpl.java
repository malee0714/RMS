package lims.qa.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.com.service.CommonService;
import lims.qa.dao.VendorAuditMDao;
import lims.qa.service.VendorAuditMService;
import lims.qa.vo.VendorAuditMVo;
import lims.util.CommonFunc;

@Service
public class VendorAuditMServiceImpl implements VendorAuditMService{

	@Autowired
	private VendorAuditMDao vendorAuditMDao;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Override
	public List<VendorAuditMVo> getVendorAuditMList(VendorAuditMVo vo){
		return vendorAuditMDao.getVendorAuditMList(vo);
	}

	@Override
	public int insVendorAudit(VendorAuditMVo vo){
		int result = 0;

		if(commonFunc.isEmpty(vo.getAuditSeqno())){
			//접수번호 생성
			String auditRceptNo = commonService.auditRceptNo("S");
			vo.setAuditRceptNo(auditRceptNo);

			result = vendorAuditMDao.insVendorAudit(vo);
		}else{
			result = vendorAuditMDao.updVendorAudit(vo);
		}

		return result;
	}

	@Override
	public int delVendorAudit(VendorAuditMVo vo) {
		int result = 0;
		result = vendorAuditMDao.delVendorAudit(vo);
		return result;
	}
}
