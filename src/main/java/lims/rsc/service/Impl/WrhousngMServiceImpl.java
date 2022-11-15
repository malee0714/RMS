package lims.rsc.service.Impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.req.vo.RequestMVo;
import lims.rsc.dao.RgntMDao;
import lims.rsc.dao.WrhousngMDao;
import lims.rsc.service.WrhousngMService;
import lims.rsc.vo.DlyvyMVo;
import lims.rsc.vo.RgntMVo;
import lims.rsc.vo.WrhousngMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;

@Service
public class WrhousngMServiceImpl implements WrhousngMService {

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Autowired
	private WrhousngMDao wrhousngMDao;
	@Autowired
	private RgntMDao rgntmDao;

	// 입고 그리드 조회
	@Override
	public List<WrhousngMVo> getWrhousngList(WrhousngMVo vo) {
		return wrhousngMDao.getWrhousngList(vo);
	}

	@Override
	public List<WrhousngMVo> getbrcdList(WrhousngMVo vo) {
		return wrhousngMDao.getbrcdList(vo);
	}
	@Override
	public List<WrhousngMVo> getexpriemList(WrhousngMVo vo){
		return wrhousngMDao.getexpriemList(vo);
	}
	@Override
	public List<WrhousngMVo> getbrcdSeqno(List<WrhousngMVo> list) {
		List<WrhousngMVo> retrunlist = new ArrayList<>();
		for(int i = 0;i<list.size();i++){
			retrunlist.addAll(wrhousngMDao.getbrcdSeqno(list.get(i)));
		}
		return  retrunlist;
	}
	
	@Override
	public List<WrhousngMVo> selectBrcd(WrhousngMVo vo){
		return wrhousngMDao.selectBrcd(vo);
	}


	@Override
	public int insWrhousng(WrhousngMVo vo) {
		// Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int check = 0;

		if (vo.getPrductWrhsdlvrSeqno() != null) {
			wrhousngMDao.updWrhousng(vo);
			return 0;
		} else {
			wrhousngMDao.insWrhousng(vo);
		}
		
		return vo.getPrductWrhsdlvrSeqno();
	}

	@Override
	public int insWareBrcd(WrhousngMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int check = 0;
		if(insWrhousng(vo)==0){
			return 99;
		}
		List<WrhousngMVo> addedGridData = vo.getAddedBrcdList();
		List<WrhousngMVo> editedExpriemList = vo.getEditedExpriemList();
		for (int i = 0; i <addedGridData.size(); i++) {
		vo.setBrcd(addedGridData.get(i).getBrcd());
		vo.setPrductWrhsdlvrBrcdSeqno(addedGridData.get(i).getPrductWrhsdlvrBrcdSeqno());
		vo.setValidDte(addedGridData.get(i).getValidDte());
		check += wrhousngMDao.insWareBrcd(vo);
		wrhousngMDao.insWareBrcdHist(vo);
		wrhousngMDao.wrhsdlvrQyadd(vo);
		wrhousngMDao.nowInvntryupdate(vo);
		}
		for (int i = 0; i <editedExpriemList.size(); i++) {
			vo.setExpriemSeqno(editedExpriemList.get(i).getExpriemSeqno());
			vo.setSortOrdr(editedExpriemList.get(i).getSortOrdr());
			vo.setDnstyValue(editedExpriemList.get(i).getDnstyValue());
			check += wrhousngMDao.insDnsty(vo);
		}
		return check;
	}
	@Override
	public int updbrcdlist(WrhousngMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int check = 0;

		List<WrhousngMVo> addedGridData = vo.getAddedBrcdList();
		List<WrhousngMVo> editedGridData = vo.getEditedBrcdList();
		List<WrhousngMVo> addedExpriemList = vo.getAddedExpriemList();
		List<WrhousngMVo> editedExpriemList = vo.getEditedExpriemList();
		for (int i = 0; i <addedGridData.size(); i++) {
		vo.setBrcd(addedGridData.get(i).getBrcd());
		vo.setPrductWrhsdlvrBrcdSeqno(addedGridData.get(i).getPrductWrhsdlvrBrcdSeqno());
		vo.setValidDte(addedGridData.get(i).getValidDte());
		check += wrhousngMDao.insWareBrcd(vo);
		wrhousngMDao.insWareBrcdHist(vo);
		wrhousngMDao.nowInvntryupdate(vo);
		}
		for (int i = 0; i <editedGridData.size(); i++) {
			vo.setBrcd(editedGridData.get(i).getBrcd());
			vo.setPrductWrhsdlvrBrcdSeqno(editedGridData.get(i).getPrductWrhsdlvrBrcdSeqno());
			vo.setValidDte(editedGridData.get(i).getValidDte());
			check += wrhousngMDao.updbrcdlist(vo);
			}
		for (int i = 0; i <addedExpriemList.size(); i++) {
			vo.setExpriemSeqno(addedExpriemList.get(i).getExpriemSeqno());
			vo.setSortOrdr(addedExpriemList.get(i).getSortOrdr());
			vo.setDnstyValue(addedExpriemList.get(i).getDnstyValue());
			check += wrhousngMDao.insDnsty(vo);
		}
		for (int i = 0; i <editedExpriemList.size(); i++) {
			vo.setExpriemSeqno(editedExpriemList.get(i).getExpriemSeqno());
			vo.setSortOrdr(editedExpriemList.get(i).getSortOrdr());
			vo.setDnstyValue(editedExpriemList.get(i).getDnstyValue());
			check += wrhousngMDao.insDnsty(vo);
		}

		List<WrhousngMVo> removedExpriemList = vo.getRemovedBrcdList();
		for (int i = 0; i <removedExpriemList.size(); i++) {
			vo.setExpriemSeqno(removedExpriemList.get(i).getExpriemSeqno());
			vo.setPrductWrhsdlvrSeqno(removedExpriemList.get(i).getPrductWrhsdlvrSeqno());
			vo.setPrductSeqno(removedExpriemList.get(i).getPrductSeqno());
			check += wrhousngMDao.delDnsty(vo);
		}
		wrhousngMDao.wrhsdlvrQyadd(vo);
		return check;
	}
	@Override
	public int deletbrcdlist(List<WrhousngMVo> vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int check = 0;
		for(int i=1; i <vo.size(); i++){
			check +=wrhousngMDao.deletbrcdlist(vo.get(i));
			wrhousngMDao.deletbrcdhist(vo.get(i));
		}

		return check;
	}
	@Override
	public int deletbrcdrowlist(WrhousngMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int check = 0;
		List<WrhousngMVo> removedGridData = vo.getRemovedBrcdList();
		for (int i = 0; i <removedGridData.size(); i++) {
			vo.setPrductWrhsdlvrSeqno(removedGridData.get(i).getPrductWrhsdlvrSeqno());
			vo.setPrductWrhsdlvrBrcdSeqno(removedGridData.get(i).getPrductWrhsdlvrBrcdSeqno());

			check += wrhousngMDao.deletbrcdlist(vo);
			wrhousngMDao.deletbrcdhist(vo);
			wrhousngMDao.wrhsdlvrQydelet(vo);
			wrhousngMDao.delnowInvntryupdate(vo);

		}

		return check;
	}
	@Override
	public int deletexpriem(WrhousngMVo vo){
		int check=0;
		List<WrhousngMVo> removedExpriemList = vo.getRemovedExpriemList();
		for (int i = 0; i <removedExpriemList.size(); i++) {
			vo.setPrductWrhsdlvrSeqno(vo.getPrductWrhsdlvrSeqno());
			vo.setExpriemSeqno(removedExpriemList.get(i).getExpriemSeqno());
			vo.setPrductSeqno(removedExpriemList.get(i).getPrductSeqno());
			check += wrhousngMDao.delDnsty(vo);
		}
		return check;
	}
	
	
	
	@Override
	public int wrhsdlvrQydelet(List<WrhousngMVo> vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int check = 0;
		for(int i=1; i <vo.size(); i++){
		check +=wrhousngMDao.wrhsdlvrQydelet(vo.get(i));
		}

		return check;
	}

//	public int insWareBrcd(List<WrhousngMVo> vo) {
//		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
//		int check = 0;
//		int prductWrhsdlvrSeqno = vo.get(0).getPrductWrhsdlvrSeqno();
//		int PrductSeqno = vo.get(0).getPrductSeqno();
//		String WrhsdlvrSeCode =  vo.get(0).getWrhsdlvrSeCode();
//		
//		for(int i=1; i <vo.size(); i++){
//		vo.get(i).setPrductWrhsdlvrSeqno(prductWrhsdlvrSeqno);
//		check +=wrhousngMDao.insWareBrcd(vo.get(i));
//		check += wrhousngMDao.insWareBrcdHist(vo.get(i));
//		RgntMVo rgntMVo=new RgntMVo();
//		rgntMVo.setPrductSeqno(PrductSeqno);
//		rgntMVo.setWrhsdlvrSeCode(WrhsdlvrSeCode);
//		rgntMVo.setWrhsdlvrQy(1);
//		rgntmDao.nowInvntryupdate(rgntMVo);
//		}
//
//		return check;
//	}
	
	@Override
	public int deletBrcd(WrhousngMVo vo) {
		// Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int check = 0;

			check +=wrhousngMDao.deletBrcd(vo);
	
		
		return check;
	}
}
