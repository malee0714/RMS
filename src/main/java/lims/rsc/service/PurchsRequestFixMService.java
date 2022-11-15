package lims.rsc.service;

import java.util.List;

import lims.rsc.vo.PurchsRequestFixMVo;
import lims.rsc.vo.PurchsRequestMVo;

public interface PurchsRequestFixMService {
	public List<PurchsRequestFixMVo> getPurchsRequestFixMList(PurchsRequestFixMVo vo);
	public List<PurchsRequestMVo> getRequstIsestatnFixMList(PurchsRequestMVo vo);
	public List<PurchsRequestMVo> getPurchsIsestatnFixMList(PurchsRequestMVo vo);
	public int savePurchsRequestFixM(PurchsRequestFixMVo masterVO, List<PurchsRequestFixMVo> detailVO, List<PurchsRequestFixMVo> productVO);
	public int delRequestFixM (PurchsRequestFixMVo masterVO, PurchsRequestFixMVo detailVO);
}
