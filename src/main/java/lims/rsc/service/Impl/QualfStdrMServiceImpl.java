package lims.rsc.service.Impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.com.service.CommonService;
import lims.rsc.dao.QualfStdrMDao;
import lims.rsc.service.QualfStdrMService;
import lims.rsc.vo.QualfStdrMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;

@Service
public class QualfStdrMServiceImpl implements QualfStdrMService{

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	private QualfStdrMDao qualfStdrMDao;
	
	@Override
	public List<QualfStdrMVo> getQualfStdr(QualfStdrMVo vo){
		return qualfStdrMDao.getQualfStdr(vo);
	}
	
	@Override
	public int saveQualfStdr(QualfStdrMVo vo) {
		
		List<QualfStdrMVo> addedRowList = vo.getAddedRowList();
		List<QualfStdrMVo> editedRowList = vo.getEditedRowList();
		List<QualfStdrMVo> removedRowList = vo.getRemovedRowList();
		
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		String sLastChangerId = userMVo.getUserId(); 
		String addQualfStdrSeqno = null;
		vo.setLastChangerId(sLastChangerId);
		String bplcCode = vo.getBplcCode();
		
		int result = 0;
		if(vo.getQualfStdrSeqno() == "" || vo.getQualfStdrSeqno() == null) {
			result = qualfStdrMDao.saveQualfStdr(vo);
			addQualfStdrSeqno = vo.getQualfStdrSeqno();
		} else {
			result = qualfStdrMDao.upQualfStdr(vo);
		}
		
		if(addedRowList.size()>0){
			for(int i=0;i<addedRowList.size(); i++){
				addedRowList.get(i).setLastChangerId(sLastChangerId);
				addedRowList.get(i).setBplcCode(bplcCode);
				if(addedRowList.get(i).getQualfStdrSeqno() == "" ||addedRowList.get(i).getQualfStdrSeqno()==null){//마스터가 update일경우는 화면에서 받아오기때문
					addedRowList.get(i).setQualfStdrSeqno(addQualfStdrSeqno);//insert일경우에만 selectkey값받도록
				}
				result = qualfStdrMDao.insQualfStdrSe(addedRowList.get(i));	
			}
		}
		if(editedRowList.size()>0){
			for(int i=0;i<editedRowList.size(); i++){
				editedRowList.get(i).setLastChangerId(sLastChangerId);
				editedRowList.get(i).setBplcCode(bplcCode);
				result = qualfStdrMDao.updQualfStdrSe(editedRowList.get(i));
			}
		}
		if(removedRowList.size()>0){
			for(int i=0;i<removedRowList.size(); i++){
				removedRowList.get(i).setBplcCode(bplcCode);
				removedRowList.get(i).setLastChangerId(sLastChangerId);
				result = qualfStdrMDao.delQualfStdrSe(removedRowList.get(i));
			}
		}
		
		return result;
	}
	
	@Override
	public int delQualfStdr(QualfStdrMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		String sLastChangerId = userMVo.getUserId(); 
		vo.setLastChangerId(sLastChangerId);
		int result = qualfStdrMDao.delQualfStdr(vo);

		return result;
	}

	@Override
	public List<QualfStdrMVo> getScoreList(QualfStdrMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		String sbplcCode= userMVo.getBplcCode();
		vo.setBplcCode(sbplcCode);
		
		return qualfStdrMDao.getScoreList(vo);
	}

	@Override
	public List<QualfStdrMVo> getBaseLineList(QualfStdrMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		String sbplcCode= userMVo.getBplcCode();
		vo.setBplcCode(sbplcCode);
		
		return qualfStdrMDao.getBaseLineList(vo);
	}
	
	
	
}
