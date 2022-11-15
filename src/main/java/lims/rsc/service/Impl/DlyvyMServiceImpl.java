package lims.rsc.service.Impl;

import lims.rsc.dao.DlyvyMDao;
import lims.rsc.dao.RgntMDao;
import lims.rsc.service.DlyvyMService;
import lims.rsc.vo.DlyvyMVo;
import lims.rsc.vo.RgntMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class DlyvyMServiceImpl implements DlyvyMService{
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
	private DlyvyMDao dlyvyMDao;
	
	@Autowired
	private RgntMDao rgntmDao;
	
	  Comparator<DlyvyMVo> compareById = new Comparator<DlyvyMVo>() {
	      @Override
	      public int compare(final DlyvyMVo object1, final DlyvyMVo object2) {
	          return object1.getPrductNm().compareTo(object2.getPrductNm());
	      }
	  };
	  
//	public List<DlyvyMVo>  getBacode(DlyvyMVo vo){
//		//Service에서 세션값 받아오기
//		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
//	
//		
//		DlyvyMVo vo3 = getPrductSeqno(vo);
//		List<DlyvyMVo> DlyvyList = new ArrayList<DlyvyMVo>();
//		DlyvyList=dlyvyMDao.getBacode(vo);
//		if (vo3 != null) {
//
//			if (vo.getBrcdChk() != null && vo.getBrcdChk() != "") {
//				String[] BrcdList = vo.getBrcdChk().split(",");
//				vo3.setBrcdList(BrcdList);
//			}
//			DlyvyMVo vo2 = getBacodeChk(vo3);
//
//			if (vo2.getBrcdChkval() > 1) {
//				vo.setFlog(100);
//				DlyvyList.set(0,vo);
//			}
//		}
//		return DlyvyList;
//
//	}
	public List<DlyvyMVo>  getBacode(DlyvyMVo vo){
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
	
		
		List<DlyvyMVo> vo3= getPrductSeqno(vo);
		List<DlyvyMVo> DlyvyList = new ArrayList<DlyvyMVo>();
		DlyvyList=dlyvyMDao.getBacode(vo);
		
		if (vo3 != null) {
			for(int i=0; i<vo3.size();i++){		
			if (vo.getBrcdChk() != null && vo.getBrcdChk() != "") {
				String[] BrcdList = vo.getBrcdChk().split(",");

				vo3.get(i).setBrcdList(BrcdList);
			}
			List<DlyvyMVo> vo2 = getBacodeChk(vo3.get(i));
			for(int j=0; j<vo2.size();j++){
			if (vo2.get(j).getBrcdChkval() > 1) {
				vo.setFlog(100);
				DlyvyList.set(0,vo);
			}
			}
		}
		}
		return DlyvyList;

	}
	
	public List<DlyvyMVo> getBacodeChk(DlyvyMVo vo){
		
		return dlyvyMDao.getBacodeChk(vo);
	}
	public List<DlyvyMVo> getPrductSeqno(DlyvyMVo vo){
		
		return dlyvyMDao.getPrductSeqno(vo);
	}
	
	public int updateBrcd(List<DlyvyMVo> vo){
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		
		int result = 0;
		int check= 0;
		if (vo.size() > 0) {
			  Collections.sort(vo,compareById);				 
		}

		for (int i = 0; i < vo.size(); i++) {	
			System.out.print(vo.get(i).getValidDte());
			if (vo.get(i).getValidDte() != null) {							//개봉후 유효기간인 바코드는 검사 x
				if (vo.get(i).getWrhsdlvrSeCode().equals("RS08000002")) {
					if (check != (int) dlyvyMDao.checkBrcd(vo.get(i))) // 검사용 )
						return 0;
					if (i != vo.size() - 1) {
						if ((!vo.get(i).getValidDte().equals(vo.get(i + 1).getValidDte()))&&(vo.get(i).getPrductSeqno().equals(vo.get(i + 1).getPrductSeqno())) ){
							check += (int) dlyvyMDao.checkBrcds(vo.get(i)); // 검사용
						}
						else{
							check=0;
						}
					}
				}
			}
		}
		
		for(int i=0; i <vo.size(); i++){
			String data = null;
			String validTmlmtMthdCode = vo.get(i).getValidTmlmtMthdCode();
			if(("Y").equals(vo.get(i).getValidTmlmtTrgetAt())){
			if (("RS08000002").equals(vo.get(i).getWrhsdlvrSeCode())) {
				if (validTmlmtMthdCode.equals("RS15000002")) {
					int unsealAfterTmlmt = vo.get(i).getUnsealAfterTmlmt();
					String cycleCode = vo.get(i).getCycleCode();
					Date date = new Date();
					System.out.print(date + "test");
					if (cycleCode.equals("SY14000001")) {
						date.setYear(date.getYear() + unsealAfterTmlmt);
						data = new SimpleDateFormat("yyyy-MM-dd").format(date);
					} else if (cycleCode.equals("SY14000002")) {
						date.setMonth((date.getMonth()) + (unsealAfterTmlmt * 6));
						data = new SimpleDateFormat("yyyy-MM-dd").format(date);
					} else if (cycleCode.equals("SY14000003")) {
						date.setMonth((date.getMonth()) + (unsealAfterTmlmt * 3));
						data = new SimpleDateFormat("yyyy-MM-dd").format(date);
					} else if (cycleCode.equals("SY14000004")) {
						date.setMonth((date.getMonth()) + unsealAfterTmlmt);
						data = new SimpleDateFormat("yyyy-MM-dd").format(date);
					} else if (cycleCode.equals("SY14000005")) {
						date.setDate(date.getDate() + unsealAfterTmlmt);
						data = new SimpleDateFormat("yyyy-MM-dd").format(date);
					}
					vo.get(i).setValidDte(data);
				}
			}
			}
				if(vo.get(i).getWrhsdlvrSeBeforeCode()!=vo.get(i).getWrhsdlvrSeCode()){
				result += dlyvyMDao.updateBrcd(vo.get(i));
				DlyvyMVo voSeqno = dlyvyMDao.getSeqno(vo.get(i));
				result += dlyvyMDao.updateBrcdHist(voSeqno);
				RgntMVo rgntMVo=new RgntMVo() ;
				String WrhsdlvrSeCode= vo.get(i).getWrhsdlvrSeCode();
				String WrhsdlvrSeBeforeCode= vo.get(i).getWrhsdlvrSeBeforeCode();
				rgntMVo.setPrductSeqno(vo.get(i).getPrductSeqno());
				rgntMVo.setWrhsdlvrSeCode(WrhsdlvrSeCode);
				rgntMVo.setWrhsdlvrSeBeforeCode(WrhsdlvrSeBeforeCode);
				rgntMVo.setWrhsdlvrQy(1);
				if(("RS08000002").equals(WrhsdlvrSeCode))
				rgntmDao.nowInvntryupdate(rgntMVo);
				else if(("RS08000001").equals(WrhsdlvrSeBeforeCode))
				rgntmDao.nowInvntrydelet(rgntMVo);
				}
		
		}


		return result; 
	}
	public List<DlyvyMVo> getPopupBrcd(DlyvyMVo vo){
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);

		
		if(vo.getWrhsdlvrSeCode().equals("1")){
			vo.setWrhsdlvrSeCode("RS08000001");
		}
		
		if(vo.getWrhsdlvrSeCode().equals("2")){
			vo.setWrhsdlvrSeCode("RS08000002");
			vo.setExceptionCode("RS08000001");
		}

		return dlyvyMDao.getPopupBrcd(vo);
	}
	
//	@Override
//	public int nowInvntryupdate(DlyvyMVo vo){
//		int check = 0;
//		check =dlyvyMDao.nowInvntryupdate(vo);
//		int NowInvntryQy =vo.getNowInvntryQy();
//		int ProprtInvntryQy = vo.getProprtInvntryQy();
//		if(NowInvntryQy > ProprtInvntryQy){
//			//사용자한테 알림메일
//		}
//		
//		
//		return check;
//	}
}
