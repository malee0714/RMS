package lims.rsc.service.Impl;

import lims.rsc.dao.PurchsRequestMDao;
import lims.rsc.service.PurchsRequestMService;
import lims.rsc.vo.PurchsRequestMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class PurchsRequestMServiceImpl implements PurchsRequestMService{
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
	private PurchsRequestMDao purchsRequestMDao;
	
	@Override
	public List<PurchsRequestMVo> getPurchsRequestMList(PurchsRequestMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		
		return purchsRequestMDao.getPurchsRequestMList(vo);
	}
	
	@Override
	public int savePurchsRequestM(PurchsRequestMVo masterVO, List<PurchsRequestMVo> detailVO, List<PurchsRequestMVo> productVO){
		int result = 0;

		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		String strpurchsRequstSeqno = null;

		if(masterVO.getGbnCrud() != "" && masterVO.getGbnCrud() != null){
			masterVO.setLastChangerId(userMVo.getUserId());
			
			masterVO.setRequstDeptCode(userMVo.getDeptCode());
			if("C".equals(masterVO.getGbnCrud())) { // 저장
				result += purchsRequestMDao.insPurchsRequestM(masterVO);
			}
			
			if("U".equals(masterVO.getGbnCrud())) { // 수정
				result += purchsRequestMDao.updPurchsRequestM(masterVO);
			}
			
			/*if("D".equals(masterVO.getGbnCrud())) { // 삭제
				result = purchsRequestMDao.delPurchsRequestMDetail(masterVO);
			}*/
		}
		
		strpurchsRequstSeqno = masterVO.getPurchsRequstSeqno();
		
		for(int i=0; i <detailVO.size(); i++) {
			String sLastChangerId = userMVo.getUserId(); 
			detailVO.get(i).setLastChangerId(sLastChangerId); // 로그인 세션값 할당
			detailVO.get(i).setPurchsRequstSeqno(strpurchsRequstSeqno);
			
			if(detailVO.get(i).getGridCrud() != "" && detailVO.get(i).getGridCrud()  != null){
				if(detailVO.get(i).getGridCrud().equals("C")){ // CRUD 구분값이 C라면 insert
					result += purchsRequestMDao.insRequstIsestatnM(detailVO.get(i));
				}
				
				if(detailVO.get(i).getGridCrud().equals("U")){ // CRUD 구분값이 U라면 update
					result += purchsRequestMDao.updRequstIsestatnM(detailVO.get(i));
				}

			}
		}
		
		for(int j=0; j <productVO.size(); j++){
			if(productVO.get(j).getGridCrud() != "" && productVO.get(j).getGridCrud()  != null){

				if(productVO.get(j).getGridCrud().equals("D")){ // CRUD 구분값이 D라면 delete
					result += purchsRequestMDao.delPurchsRequestMDetail(productVO.get(j));
				}
			}
		}

		
		return result; 
	}
	
	@Override
	public int delPurchsRequestM(PurchsRequestMVo masterVO, PurchsRequestMVo detailVO){
		int result = 0;

		if(detailVO.getPurchsRequstSeqno() != "" && detailVO.getPurchsRequstSeqno() != null){
			result += purchsRequestMDao.delPurchsRequestMDetail(detailVO);
		}
		
		if(masterVO.getGbnCrud() != "" && masterVO.getGbnCrud() != null){
			if("D".equals(masterVO.getGbnCrud())) { // 삭제
				result += purchsRequestMDao.delPurchsRequestM(masterVO);
			}
		}

		return result;
	}
	
	/*@Override
	public int delPurchsRequestMDetail(List<PurchsRequestMVo> vo){
		int result = 0;
		
		for(int i=0; i <vo.size(); i++) {
			if(vo.get(i).getGridCrud() != "" && vo.get(i).getGridCrud()  != null){
				if(vo.get(i).getGridCrud().equals("D")){ // CRUD 구분값이 D라면 delete
					result = purchsRequestMDao.delPurchsRequestMDetail(vo.get(i));
				}
			}
		}
		
		return result;
	}*/
	
	@Override
	public List<PurchsRequestMVo> getRequstIsestatnMList(PurchsRequestMVo vo) {
		return purchsRequestMDao.getRequstIsestatnMList(vo);
	}

	/*@Override
	public int saveRequstIsestatnMList(List<PurchsRequestMVo> vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int result = 0;
		
		try {
			for(int i=0; i <vo.size(); i++) {
				String sLastChangerId = userMVo.getUserId(); 
				vo.get(i).setLastChangerId(sLastChangerId); // 로그인 세션값 할당
				
				if(vo.get(i).getGridCrud() != "" && vo.get(i).getGridCrud()  != null){
					if(vo.get(i).getGridCrud().equals("C")){ // CRUD 구분값이 C라면 insert
						result = purchsRequestMDao.insRequstIsestatnM(vo.get(i));
					}
					
					if(vo.get(i).getGridCrud().equals("U")){ // CRUD 구분값이 U라면 update
						result = purchsRequestMDao.updRequstIsestatnM(vo.get(i));
					}
				}
			}
		} catch (Exception e) {
			result = 0;
			System.out.println(">> 구매요청목록(purchsRequstIsestatn_Detail) 그리드 저장 에러 발생: "+e);
		}

		return result;
	}*/

	@Override
	public List<PurchsRequestMVo> getComboRgntProgrsSittnCodeList(PurchsRequestMVo vo) {
		return purchsRequestMDao.getComboRgntProgrsSittnCodeList(vo);
	}

}
