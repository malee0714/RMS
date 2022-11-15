package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.PurchsRequestFixMVo;
import lims.rsc.vo.PurchsRequestMVo;


public interface PurchsRequestFixMDao {
	public List<PurchsRequestFixMVo> getPurchsRequestFixMList(PurchsRequestFixMVo vo);
	public List<PurchsRequestMVo> getRequstIsestatnFixMList(PurchsRequestMVo vo);
	public List<PurchsRequestMVo> getPurchsIsestatnFixMList(PurchsRequestMVo vo);
	public int insPurchsRequestFixM(PurchsRequestFixMVo vo);
	public int updPurchsRequestFixM(PurchsRequestFixMVo vo);
	public int insRequstIsestatnFixM(PurchsRequestFixMVo vo);
	public int updRequstIsestatnFixM(PurchsRequestFixMVo vo);
	public int delRequestFixMDetail(PurchsRequestFixMVo vo);
	public int delRequestFixM(PurchsRequestFixMVo vo);
	public int updBeforeDelSeqno(PurchsRequestFixMVo vo);
	public int updBeforeDelSeqnoPart(PurchsRequestFixMVo vo);
	public int updPurchsRequstSeqno(PurchsRequestFixMVo vo);
	public int updMasterPurchsRequstSeqno(PurchsRequestFixMVo vo);
	public int updMasterBeforeDelSeqno(PurchsRequestFixMVo vo);
	public int updMasterBeforeDelSeqnoPart(PurchsRequestFixMVo vo);
	
	
	
	
}
