package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.PurchsRequestMVo;


public interface PurchsRequestMDao {
	public List<PurchsRequestMVo> getPurchsRequestMList(PurchsRequestMVo vo);
	public int insPurchsRequestM (PurchsRequestMVo vo);
	public int updPurchsRequestM (PurchsRequestMVo vo);
	public int delPurchsRequestM (PurchsRequestMVo vo);
	public int delPurchsRequestMDetail (PurchsRequestMVo vo);
	public List<PurchsRequestMVo> getRequstIsestatnMList(PurchsRequestMVo vo);
	public int insRequstIsestatnM (PurchsRequestMVo vo);
	public int updRequstIsestatnM (PurchsRequestMVo vo); 
	public List<PurchsRequestMVo> getComboRgntProgrsSittnCodeList(PurchsRequestMVo vo);
	
}
