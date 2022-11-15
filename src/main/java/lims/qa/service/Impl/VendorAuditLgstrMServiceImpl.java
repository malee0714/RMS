package lims.qa.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.com.service.CommonService;
import lims.qa.dao.VendorAuditLgstrMDao;
import lims.qa.dao.VendorAuditMDao;
import lims.qa.service.VendorAuditLgstrMService;
import lims.qa.service.VendorAuditMService;
import lims.qa.vo.VendorAuditLgstrMVo;
import lims.qa.vo.VendorAuditMVo;
import lims.util.CommonFunc;

@Service
public class VendorAuditLgstrMServiceImpl implements VendorAuditLgstrMService{

	@Autowired
	private VendorAuditLgstrMDao vendorAuditLgstrMDao;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Override
	public List<VendorAuditLgstrMVo> getVendorAuditLgstrMList(VendorAuditLgstrMVo vo){
		return vendorAuditLgstrMDao.getVendorAuditLgstrMList(vo);
	}

	@Override
	public int insVendorAuditLgstr(VendorAuditLgstrMVo vo){
		int result = 0;

		if(commonFunc.isEmpty(vo.getAuditCarSeqno())){

			//CAR NO 생성
			String auditRceptNo = vo.getCarNo();

			String carNo = commonService.auditLgstrNo(auditRceptNo);
			vo.setCarNo(carNo);

			result = vendorAuditLgstrMDao.insVendorAuditLgstr(vo);
		}else{
			result = vendorAuditLgstrMDao.updVendorAuditLgstr(vo);
		}
		return result;
	}

	@Override
	public int delVendorAuditLgstr(VendorAuditLgstrMVo vo) {
		int result = 0;
		result = vendorAuditLgstrMDao.delVendorAuditLgstr(vo);
		return result;
	}
}
