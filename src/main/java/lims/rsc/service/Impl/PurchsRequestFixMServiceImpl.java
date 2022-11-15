package lims.rsc.service.Impl;

import lims.rsc.dao.PurchsRequestFixMDao;
import lims.rsc.service.PurchsRequestFixMService;
import lims.rsc.vo.PurchsRequestFixMVo;
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
public class PurchsRequestFixMServiceImpl implements PurchsRequestFixMService{
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
	private PurchsRequestFixMDao purchsRequestFixMDao;
	
	@Override
	public List<PurchsRequestFixMVo> getPurchsRequestFixMList(PurchsRequestFixMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		return purchsRequestFixMDao.getPurchsRequestFixMList(vo);
	}
	
	@Override
	public List<PurchsRequestMVo> getRequstIsestatnFixMList(PurchsRequestMVo vo){
		
		return purchsRequestFixMDao.getRequstIsestatnFixMList(vo);
	}
	
	@Override
	public List<PurchsRequestMVo> getPurchsIsestatnFixMList(PurchsRequestMVo vo){
		return purchsRequestFixMDao.getPurchsIsestatnFixMList(vo);
	}
	
	@Override
	public int savePurchsRequestFixM (PurchsRequestFixMVo masterVO, List<PurchsRequestFixMVo> detailVO, List<PurchsRequestFixMVo> productVO){
		int result = 0;
		
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		String strSeqno = null;
		String strRgntProgrsSittnCode = null;
		
		for(int j=0; j <productVO.size(); j++){
			if(productVO.get(j).getGridCrud() != "" && productVO.get(j).getGridCrud()  != null){
				if(productVO.get(j).getGridCrud().equals("D")){ // CRUD 구분값이 D라면 delete
					
					productVO.get(j).setRgntProgrsSittnCode("RS05000002");
					
					// 구매번호 삭제 (부분 삭제)
					result += purchsRequestFixMDao.updBeforeDelSeqnoPart(productVO.get(j));
					result += purchsRequestFixMDao.updMasterBeforeDelSeqnoPart(productVO.get(j));
					
					// 구매 목록 삭제
					result += purchsRequestFixMDao.delRequestFixMDetail(productVO.get(j));

				}
			}
		}
		
		
		if(masterVO.getGbnCrud() != "" && masterVO.getGbnCrud() != null){
			masterVO.setLastChangerId(userMVo.getUserId());
			
			if("C".equals(masterVO.getGbnCrud())){ // 저장
				result += purchsRequestFixMDao.insPurchsRequestFixM(masterVO);
			}
			
			if("U".equals(masterVO.getGbnCrud())) { // 수정
				result += purchsRequestFixMDao.updPurchsRequestFixM(masterVO);
				//result += purchsRequestFixMDao.updPurchsRequstSeqno(masterVO);
			}

		}
		
		strSeqno = masterVO.getPurchsSeqno();
		strRgntProgrsSittnCode = masterVO.getRgntProgrsSittnCode();
		
		for(int i=0; i <detailVO.size(); i++){
			String sLastChangerId = userMVo.getUserId(); 
			detailVO.get(i).setLastChangerId(sLastChangerId); // 로그인 세션값 할당
			detailVO.get(i).setPurchsSeqno(strSeqno);
			detailVO.get(i).setRgntProgrsSittnCode(strRgntProgrsSittnCode);
			
			if(detailVO.get(i).getGridCrud() != "" && detailVO.get(i).getGridCrud()  != null){
				if(detailVO.get(i).getGridCrud().equals("C")){ // CRUD 구분값이 C라면 insert
					result += purchsRequestFixMDao.insRequstIsestatnFixM(detailVO.get(i));
					
					// 구매요청 수정(구매 일련번호값 채우기)
					result += purchsRequestFixMDao.updPurchsRequstSeqno(detailVO.get(i));
					result += purchsRequestFixMDao.updMasterPurchsRequstSeqno(detailVO.get(i));
				}
				
				if(detailVO.get(i).getGridCrud().equals("U")){ // CRUD 구분값이 U라면 update
					result += purchsRequestFixMDao.updRequstIsestatnFixM(detailVO.get(i));
				}
				
			}
			
			if(detailVO.get(i).getRgntProgrsSittnCode().equals("RS05000004")){
				
				result += purchsRequestFixMDao.updMasterPurchsRequstSeqno(detailVO.get(i));
				
			}
		}

		return result;
	}
	
	public int delRequestFixM(PurchsRequestFixMVo masterVO, PurchsRequestFixMVo detailVO){
		int result = 0;
		
		String strPurchsRequstSeqno = null;
		
		if(detailVO.getPurchsSeqno() != "" && detailVO.getPurchsSeqno() != null ){
			//strPurchsRequstSeqno = masterVO.getPurchsRequstSeqno();
			//detailVO.setPurchsRequstSeqno(strPurchsRequstSeqno);
			
			// 삭제 전 구매번호 삭제
			result += purchsRequestFixMDao.updMasterBeforeDelSeqno(detailVO);
			result += purchsRequestFixMDao.updBeforeDelSeqno(detailVO);
			
			
			// 구매목록(디테일 그리드)삭제
			result += purchsRequestFixMDao.delRequestFixMDetail(detailVO);
		}
		
		if(masterVO.getGbnCrud() != "" && masterVO.getGbnCrud() != null){
			if("D".equals(masterVO.getGbnCrud())) { // 삭제
				// 구매요청 확정 정보(마스터 그리드) 삭제
				result += purchsRequestFixMDao.delRequestFixM(masterVO);
			}
		}
			

		return result;
	}
	
}
