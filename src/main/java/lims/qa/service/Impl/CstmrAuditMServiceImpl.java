package lims.qa.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.com.service.CommonService;
import lims.qa.dao.CstmrAuditMDao;
import lims.qa.service.CstmrAuditMService;
import lims.qa.vo.CstmrAuditMVo;
import lims.util.CommonFunc;

@Service
public class CstmrAuditMServiceImpl implements CstmrAuditMService{

	@Autowired
	private CstmrAuditMDao cstmrAuditMDao;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Override
	public List<CstmrAuditMVo> getCstmrAuditMList(CstmrAuditMVo vo){
		return cstmrAuditMDao.getCstmrAuditMList(vo);
	}

	@Override
	public int insCstmrAudit(CstmrAuditMVo vo){
		int result = 0;

		if(commonFunc.isEmpty(vo.getAuditSeqno())){
			//접수번호 생성
			String auditRceptNo = commonService.auditRceptNo("C");
			vo.setAuditRceptNo(auditRceptNo);

			result = cstmrAuditMDao.insCstmrAudit(vo);
		}else{
			result = cstmrAuditMDao.updCstmrAudit(vo);
		}

		return result;
	}

	@Override
	public int delCstmrAudit(CstmrAuditMVo vo) {
		int result = 0;
		result = cstmrAuditMDao.delCstmrAudit(vo);
		return result;
	}
}
