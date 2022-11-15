package lims.rsc.service.Impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.adm.vo.ErrorLogMVo;
import lims.com.service.CommonService;
import lims.rsc.dao.MrlsEdayChckMDao;
import lims.rsc.service.MrlsEdayChckMService;
import lims.rsc.vo.MrlsEdayChckMVo;
import lims.req.vo.RequestMVo;
import lims.sys.vo.CanisterNoMVo;
import lims.rsc.vo.QualfStdrMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.wrk.dao.MhrlsDetectLimitMDao;

@Service
public class MrlsEdayChckMServiceImpl implements MrlsEdayChckMService{
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	private MrlsEdayChckMDao mrlsEdayChckMDao;
	
	@Override
	public List<MrlsEdayChckMVo> searchMrlsChk(MrlsEdayChckMVo vo){
		return mrlsEdayChckMDao.searchMrlsChk(vo);
	}
	
	
	@Override
	public List<MrlsEdayChckMVo> searchReqVal(MrlsEdayChckMVo vo){
		return mrlsEdayChckMDao.searchReqVal(vo);
	}
	@Override
	public List<MrlsEdayChckMVo> searchReqList(MrlsEdayChckMVo vo){
		return mrlsEdayChckMDao.searchReqList(vo);
	}
	
	
	@Override
	public List<MrlsEdayChckMVo> searchValDetail(MrlsEdayChckMVo vo) {
		
		List<MrlsEdayChckMVo> list = mrlsEdayChckMDao.searchValDetail(vo);
		if(list != null) {
			
			for(int i=0; i< list.size(); i++) {
					
				String[] testArr = list.get(i).getExpriemSeqno().split("/");
				
				String[] testArr2 = list.get(i).getExpriemNm().split("/");
				
				String[] testArr3 = list.get(i).getExprNumot().split("/");
				
				String[] testArr4 = list.get(i).getResultValue().split("/");
				
				String[] testArr5 = list.get(i).getReqestExpriemSeqno().split("/");
				
			
				
				list.get(i).setExpriemSeqnoArr(testArr);
				
				list.get(i).setExpriemNmArr(testArr2);
				
				list.get(i).setExprNumotArr(testArr3);
				
				list.get(i).setResultValueArr(testArr4);
				
				list.get(i).setReqestExpriemSeqnoArr(testArr5);
			}
		}
		return list;
	}
	
	@Override
	public List<MrlsEdayChckMVo> MecChartList(MrlsEdayChckMVo vo){
		List<MrlsEdayChckMVo> list = mrlsEdayChckMDao.MecChartList(vo);
		if(list != null) {
//			
//			for(int i=0; i< list.size(); i++) {
//					
//				String[] testArr = list.get(i).getExpriemSeqno().split("-");
//				
//				String[] testArr2 = list.get(i).getExpriemNm().split("-");
//				
//				String[] testArr3 = list.get(i).getExprNumot().split("-");
//				
//				String[] testArr4 = list.get(i).getResultValue().split("-");
//				
//				
//				list.get(i).setExpriemSeqnoArr(testArr);
//				
//				list.get(i).setExpriemNmArr(testArr2);
//				
//				list.get(i).setExprNumotArr(testArr3);
//				
//				list.get(i).setResultValueArr(testArr4);
//				
//				
//				
//				for(String s : testArr4) {
//					logger.debug(i + " test : " + s);
//				}
//				
//				
//			}
			
		}
		return list;
	}
	
	@Override
	public int saveMrlsChk(MrlsEdayChckMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		String sLastChangerId = userMVo.getUserId(); 
		vo.setLastChangerId(sLastChangerId);
		vo.setProgrsSittnCode("IM03000006");
		
		int result = 0;

		if(vo.getMhrlsEdayChckSeqno() == "" || vo.getMhrlsEdayChckSeqno() == null) {
			result += mrlsEdayChckMDao.saveMrlsChk(vo);

			for(int i=0; i <vo.getRequestaddedRowItems().size(); i++) {
				vo.setReqestSeqno(vo.getRequestaddedRowItems().get(i).getReqestSeqno());
				result += mrlsEdayChckMDao.saveMrlsChkReq(vo);	
			}
		} else {
			result += mrlsEdayChckMDao.upMrlsChk(vo);
			for(int i=0; i <vo.getRequestaddedRowItems().size(); i++) {
				vo.setReqestSeqno(vo.getRequestaddedRowItems().get(i).getReqestSeqno());
				result += mrlsEdayChckMDao.saveMrlsChkReq(vo);	
			}
		}
		if(vo.getMhrlsEdayChckSeqno() == "" || vo.getMhrlsEdayChckSeqno() == null) {
			if(vo.getDetectLimitApplcAt().equals("Y")) {
				String realQu = vo.getQu();
				// 4분기면 다음년도 1분기로 가야함.
				if(vo.getQu().equals("4")) {
					int intYearPlus = Integer.parseInt(vo.getYear());
					String strYearPlus = String.valueOf(intYearPlus+1);
					// 다음년도
					vo.setYear(strYearPlus);
					// 기기중간점검 분기
					vo.setQu(realQu);
				} else {
					// 기기중간점검 분기(1,2,3분기면 +1분기씩)
					vo.setQu(realQu);
				}
				
				if(vo.getQu().equals("1")) {
					vo.setApplcBeginDte(vo.getYear()+"-"+"04-01");
					vo.setApplcEndDte(vo.getYear()+"-"+"06-30");
					vo.setQu("2");
				} else if(vo.getQu().equals("2")) {
					vo.setApplcBeginDte(vo.getYear()+"-"+"07-01");
					vo.setApplcEndDte(vo.getYear()+"-"+"09-30");
					vo.setQu("3");
				} else if(vo.getQu().equals("3")) {
					vo.setApplcBeginDte(vo.getYear()+"-"+"10-01");
					vo.setApplcEndDte(vo.getYear()+"-"+"12-31");
					vo.setQu("4");
				} else if(vo.getQu().equals("4")) {
					vo.setYear(vo.getYear());
					vo.setApplcBeginDte(vo.getYear()+"-"+"01-01");
					vo.setApplcEndDte(vo.getYear()+"-"+"03-31");
					vo.setQu("1");
				}
				
				result += mrlsEdayChckMDao.saveMhrlsDl(vo);	
			}
		} else {
			if(vo.getDetectLimitApplcAt().equals("Y")) {
				String realQu = vo.getQu();
				//기기중간점검이 4분기면
				if(vo.getQu().equals("4")) {
					// 1분기로 바꾸고
					vo.setQu("1");
					int intYearPlus = Integer.parseInt(vo.getYear());
					String strYearPlus = String.valueOf(intYearPlus+1);
					//1년 추가
					vo.setYear(strYearPlus);
					result += mrlsEdayChckMDao.upMhrlsDl(vo);
					vo.setQu(realQu);
				} else {
					int intQuPlus = Integer.parseInt(realQu);
					String strQuPlus = String.valueOf(intQuPlus+1);
					vo.setQu(strQuPlus);
					result += mrlsEdayChckMDao.upMhrlsDl(vo);	

				}
				// 다시 원래값 기존값 기기중간점검에 있는 분기
				vo.setQu(realQu);
			
			if(vo.getQu().equals("1")) {
				vo.setApplcBeginDte(vo.getYear()+"-"+"04-01");
				vo.setApplcEndDte(vo.getYear()+"-"+"06-30");
				vo.setQu("2");
			} else if(vo.getQu().equals("2")) {
				vo.setApplcBeginDte(vo.getYear()+"-"+"07-01");
				vo.setApplcEndDte(vo.getYear()+"-"+"09-30");
				vo.setQu("3");
			} else if(vo.getQu().equals("3")) {
				vo.setApplcBeginDte(vo.getYear()+"-"+"10-01");
				vo.setApplcEndDte(vo.getYear()+"-"+"12-31");
				vo.setQu("4");
			} else if(vo.getQu().equals("4")) {
				vo.setYear(vo.getYear());
				vo.setApplcBeginDte(vo.getYear()+"-"+"01-01");
				vo.setApplcEndDte(vo.getYear()+"-"+"03-31");
				vo.setQu("1");
			}

			result += mrlsEdayChckMDao.saveMhrlsDl(vo);	
			}
		}

		
		//기기테이블 검사교정 예정일자, 최근검사 교정일자 업데이트
		
		//의뢰테이블  진행 사항 업데이트
		for(int i=0; i <vo.getRequestaddedRowItems().size(); i++) {
			vo.getRequestaddedRowItems().get(i).setInspctCrrctSeCode(vo.getInspctCrrctSeCode());
			result += mrlsEdayChckMDao.upMhrlsDate(vo.getRequestaddedRowItems().get(i));
			result += mrlsEdayChckMDao.upImReqDate(vo.getRequestaddedRowItems().get(i));
		}
		
		
		return result;
		
	}
	
	//의뢰 목록 삭제
	@Override
	public int delReqDetail(List<MrlsEdayChckMVo> list) {
		int count = 0;
		if(list.isEmpty())
			return count;
		
		for(int i=0; i <list.size(); i++) {
			count = mrlsEdayChckMDao.delReqDetail(list.get(i));
			
			count = mrlsEdayChckMDao.updDelReqDetail(list.get(i));
		}
		
		//검교정 의뢰가 한개도 없으면 마스터 삭제
		mrlsEdayChckMDao.updEdayChckInfo(list.get(0));
		return count;
	}
	
	//의뢰 목록 삭제
	@Override
	public int delReqAll(MrlsEdayChckMVo vo) {
		vo.setType("all");
		mrlsEdayChckMDao.updDelReqDetail(vo);//삭제된 의뢰 진행상황 IM03000003로 변경
		mrlsEdayChckMDao.delReqDetail(vo); // 의뢰 삭제
		return	mrlsEdayChckMDao.updEdayChckInfo(vo); //중간점검 delete_at = 'Y' 처리
 
	}
	

}
