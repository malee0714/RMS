package lims.rsc.service.Impl;


import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.rsc.dao.CmpdsUseMDao;
import lims.rsc.dao.DlyvyMDao;
import lims.rsc.service.CmpdsUseMService;
import lims.rsc.vo.CmpdsUseMVo;
import lims.rsc.vo.DlyvyMVo;
import lims.sys.vo.CanisterNoMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;

@Service
public class CmpdsUseMServiceImpl implements CmpdsUseMService {
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
	private CmpdsUseMDao cmpdsUseMDao;
	@Autowired
	private DlyvyMDao dlyvyMdao;
	
	@Override
	public int saveCmpdsUseM(CmpdsUseMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		String sLastChangerId = userMVo.getUserId(); 
		if(vo.getPrductWrhsdlvrBrcdSeqno() == null|| vo.getOrdr() == null){
			CmpdsUseMVo cmpdsUseMVo2 = cmpdsUseMDao.getOrdrs(vo);
			vo.setOrdr( cmpdsUseMVo2.getOrdr());
			vo.setPrductWrhsdlvrBrcdSeqno(cmpdsUseMVo2.getPrductWrhsdlvrBrcdSeqno());
		}
		String wrhsdlvrSeCode = cmpdsUseMDao.getwrhsdlvrSeCode(vo);
		int check = 0; 
		if(vo.getUseEndDt() == "") {
			check = cmpdsUseMDao.saveCmpdsUseM(vo);
			judgmentCmpdsM(vo);
			
		}
		else if(vo.getCrud().equals("U") && !wrhsdlvrSeCode.equals("RS08000002")){
			return check = cmpdsUseMDao.updCmpdsUseM(vo);
		}
		else {
			check = cmpdsUseMDao.updCmpdsUseM(vo);
			judgmentCmpdsM(vo);
			
		}

		return check;
	}
	@Override
	public CmpdsUseMVo getOrdrs(CmpdsUseMVo vo){
		return cmpdsUseMDao.getOrdrs(vo);
	}
	@Override
	public int restockCmpdsM(CmpdsUseMVo vo,String wrhsdlvrSeCode) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		String sLastChangerId = userMVo.getUserId(); 
		vo.setLastChangerId(sLastChangerId);
		vo.setWrhsdlvrSeCode(wrhsdlvrSeCode);
		cmpdsUseMDao.restockCmpdsM(vo);// 재입고 or 폐기
		DlyvyMVo vos= new DlyvyMVo();
		if("RS08000003".equals(wrhsdlvrSeCode))
			vos.setWrhsdlvrSeCode(wrhsdlvrSeCode);
		else
			vos.setWrhsdlvrSeCode("RS08000004");
		vos.setPrductWrhsdlvrBrcdSeqno(vo.getPrductWrhsdlvrBrcdSeqno());
		vos.setBplcCode(vo.getBplcCode());
		dlyvyMdao.updateBrcdHist(vos); // 재입고 or 폐기 ( 이력데이터에 )
		return cmpdsUseMDao.restockCmpdsM(vo);
	}
	
	public int sumInvntryQy(CmpdsUseMVo vo){
		return cmpdsUseMDao.sumInvntryQy(vo);
	}
	@Override
	public List<CmpdsUseMVo> getbrcdData(CmpdsUseMVo vo) {
		return cmpdsUseMDao.getbrcdData(vo);
	}

	@Override
	public List<CmpdsUseMVo> getCmpdsUseList(CmpdsUseMVo vo) {
		return cmpdsUseMDao.getCmpdsUseList(vo);
	}
	@Override
	public List<CmpdsUseMVo> getRepairList(CmpdsUseMVo vo) {
		return cmpdsUseMDao.getRepairList(vo);
	}
	
	@Override
	public int delMhrlsCmpdsM(CmpdsUseMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int check=0;
		check=cmpdsUseMDao.delMhrlsCmpdsM(vo);
		
		
		judgmentCmpdsM(vo);
		return check ;
	}
	@Override
	public int judgmentCmpdsM(CmpdsUseMVo vo) {
		String delete = cmpdsUseMDao.getdelete(vo);
		vo.setDeleteAt(delete);
		CmpdsUseMVo cmpdsUseMVo2 = getOrdrs(vo);
		Integer ordr1 = cmpdsUseMVo2.getOrdr();
		Integer ordr2 =vo.getOrdr();
		if(vo.getUseEndDt() !="" && vo.getReWrhousngAt().equals("Y")&&vo.getDeleteAt().equals("N")){
			String wrhsdlvrSeCode ="RS08000001";
			if(ordr1.equals(ordr2)){
			restockCmpdsM(vo,wrhsdlvrSeCode);
			sumInvntryQy(vo);}
		}else if (vo.getUseEndDt() !="" && vo.getReWrhousngAt().equals("N")&&vo.getDeleteAt().equals("N")){
			String wrhsdlvrSeCode ="RS08000003";
			if(ordr1.equals(ordr2))
			restockCmpdsM(vo,wrhsdlvrSeCode);
		}else if (("").equals(vo.getUseEndDt())&& vo.getReWrhousngAt().equals("Y")&&vo.getDeleteAt().equals("Y")){
			String wrhsdlvrSeCode ="RS08000001";
			if(ordr1.equals(ordr2)){
			restockCmpdsM(vo,wrhsdlvrSeCode);
			sumInvntryQy(vo);}
		}
		
		return 0;
	}
}
