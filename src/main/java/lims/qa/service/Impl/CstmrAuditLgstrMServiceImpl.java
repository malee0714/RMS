package lims.qa.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.com.service.CommonService;
import lims.qa.dao.CstmrAuditLgstrMDao;
import lims.qa.service.CstmrAuditLgstrMService;
import lims.qa.vo.CstmrAuditLgstrMVo;
import lims.qa.vo.VendorAuditLgstrMVo;
import lims.util.CommonFunc;

@Service
public class CstmrAuditLgstrMServiceImpl implements CstmrAuditLgstrMService{

	@Autowired
	private CstmrAuditLgstrMDao cstmrAuditLgstrMDao;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Override
	public List<CstmrAuditLgstrMVo> getCstmrAuditLgstrMList(CstmrAuditLgstrMVo vo){
		return cstmrAuditLgstrMDao.getCstmrAuditLgstrMList(vo);
	}

	@Override
	public int insCstmrAuditLgstr(CstmrAuditLgstrMVo vo){
		int result = 0;

		if(commonFunc.isEmpty(vo.getAuditCarSeqno())){

			//CAR NO 생성
			String auditRceptNo = vo.getCarNo();

			String carNo = commonService.auditLgstrNo(auditRceptNo);
			vo.setCarNo(carNo);

			result = cstmrAuditLgstrMDao.insCstmrAuditLgstr(vo);
		}else{
			result = cstmrAuditLgstrMDao.updCstmrAuditLgstr(vo);
		}
		return result;
	}

	@Override
	public int delCstmrAuditLgstr(CstmrAuditLgstrMVo vo) {
		int result = 0;
		
		result = cstmrAuditLgstrMDao.delCstmrAuditLgstr(vo);
		return result;
	}
}
