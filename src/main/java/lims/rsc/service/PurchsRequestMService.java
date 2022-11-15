package lims.rsc.service;

import java.util.List;

import lims.rsc.vo.PurchsRequestMVo;

public interface PurchsRequestMService {
	public List<PurchsRequestMVo> getPurchsRequestMList(PurchsRequestMVo vo);
	public int savePurchsRequestM (PurchsRequestMVo masterVO, List<PurchsRequestMVo> detailVO, List<PurchsRequestMVo> productVO);
	public int delPurchsRequestM (PurchsRequestMVo masterVO, PurchsRequestMVo detailVO);
	//public int delPurchsRequestMDetail (List<PurchsRequestMVo> vo);
	public List<PurchsRequestMVo> getRequstIsestatnMList(PurchsRequestMVo vo);
	//public int saveRequstIsestatnMList (List<PurchsRequestMVo> vo);
	public List<PurchsRequestMVo> getComboRgntProgrsSittnCodeList(PurchsRequestMVo vo);
	
}
