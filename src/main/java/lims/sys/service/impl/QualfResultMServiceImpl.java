package lims.sys.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.com.service.CommonService;
import lims.rsc.dao.QualfResultMDao;
import lims.rsc.service.QualfResultMService;
import lims.rsc.vo.QualfStdrMVo;
import lims.rsc.vo.QualfResultMVo;
import lims.sys.vo.CanisterNoMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.util.CustomException;

@Service
public class QualfResultMServiceImpl implements QualfResultMService{
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	private QualfResultMDao qualfStdrRegMDao; 
	
	
	@Override
	public List<QualfResultMVo> getQualfStdrReg(QualfResultMVo vo){
			return qualfStdrRegMDao.getQualfStdrReg(vo);	
	}
	@Override
	public List<QualfResultMVo> getSkill(QualfResultMVo vo){
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		vo.setBplcCode(userMVo.getBestInspctInsttCode());
		return qualfStdrRegMDao.getSkill(vo);
	}


	@Override
	public List<QualfResultMVo> getQualfElgblList(QualfResultMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		vo.setBplcCode(userMVo.getBestInspctInsttCode());
		return qualfStdrRegMDao.getQualfElgblList(vo);
	}
	@Override
	public List<QualfResultMVo> getAbility(QualfResultMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		vo.setBplcCode(userMVo.getBestInspctInsttCode());
		return  qualfStdrRegMDao.getAbility(vo);
	}
	@Override
	public int saveQualfResult(QualfResultMVo vo) {
		int result = 0;
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		String sLastChangerId = userMVo.getUserId();
		String bplcCode = vo.getBplcCode();
		vo.setLastChangerId(sLastChangerId);
		
		List<QualfResultMVo> resultGridData = vo.getResultGridList();
		vo.setUpdRegistSeqno(qualfStdrRegMDao.getUserQualf(vo)); 
		
		result = qualfStdrRegMDao.updRegistSeqno(vo); //???????????? ?????? ?????? ????????? ???????????? ???????????? 'N'
		
		result = qualfStdrRegMDao.insQualfRegist(vo); //????????? ?????? ?????? (LAST_AT ='Y' )
		
		
		for(int i =0; i<resultGridData.size(); i++){
			resultGridData.get(i).setQualfStdrRegistSeqno(vo.getQualfStdrRegistSeqno()); //selectkey ????????? ?????? insert???  ????????? ??????
			resultGridData.get(i).setLastChangerId(sLastChangerId);
			resultGridData.get(i).setBplcCode(bplcCode);
			result =  qualfStdrRegMDao.insQualfResult(resultGridData.get(i)); //????????? ?????? ?????? 
		}
		return result;
		
		
	}
	@Override
	public List<QualfResultMVo> getQualfList(QualfResultMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		vo.setBplcCode(userMVo.getBestInspctInsttCode()); 
		return qualfStdrRegMDao.getQualfList(vo);
	}
	@Override
	public List<QualfResultMVo> getElgblList(QualfResultMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		vo.setBplcCode(userMVo.getBestInspctInsttCode());
		return qualfStdrRegMDao.getElgblList(vo);
	}
	@Override
	public int updQualfResult(QualfResultMVo vo) {
		int result = 0;
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		String sLastChangerId = userMVo.getUserId();
		String bplcCode = vo.getBplcCode();
		vo.setLastChangerId(sLastChangerId);
		
		List<QualfResultMVo> resultGridData = vo.getResultGridList();
		List<QualfResultMVo> editedRowList = vo.getEditedRowList();
		List<QualfResultMVo> removedRowList = vo.getRemovedRowList();
		
		
		result = qualfStdrRegMDao.updRegist(vo); //????????? ?????? ?????? (LAST_AT ='Y' )
		
		for(int i =0; i<resultGridData.size(); i++){
			resultGridData.get(i).setQualfStdrRegistSeqno(vo.getQualfStdrRegistSeqno()); //selectkey ????????? ?????? insert???  ????????? ??????
			resultGridData.get(i).setLastChangerId(sLastChangerId);
			resultGridData.get(i).setBplcCode(bplcCode);
			result =  qualfStdrRegMDao.insQualfResult(resultGridData.get(i)); //????????? ?????? ?????? 
		}
		for(int i =0; i<editedRowList.size(); i++){
			editedRowList.get(i).setQualfStdrRegistSeqno(vo.getQualfStdrRegistSeqno()); //selectkey ????????? ?????? insert???  ????????? ??????
			editedRowList.get(i).setLastChangerId(sLastChangerId);
			editedRowList.get(i).setBplcCode(bplcCode);
			result =  qualfStdrRegMDao.updQualfResult(editedRowList.get(i)); //????????? ?????? ?????? 
		}
		for(int i =0; i<removedRowList.size(); i++){
			removedRowList.get(i).setQualfStdrRegistSeqno(vo.getQualfStdrRegistSeqno()); //selectkey ????????? ?????? insert???  ????????? ??????
			removedRowList.get(i).setLastChangerId(sLastChangerId);
			removedRowList.get(i).setBplcCode(bplcCode);
			result =  qualfStdrRegMDao.delQualfResult(removedRowList.get(i)); //????????? ?????? ?????? 
		}
		return result;
	}
	@Override
	public List<QualfResultMVo> getQualfRec(QualfResultMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		vo.setBplcCode(userMVo.getBplcCode()); 
		
		return qualfStdrRegMDao.getQualfRec(vo);
	}

	
}
