package lims.rsc.service;

import java.util.HashMap;
import java.util.List;

import lims.rsc.vo.CheckMVo;
import lims.rsc.vo.DlyvyMVo;
import lims.rsc.vo.PurchsRequestFixMVo;
import lims.rsc.vo.PurchsRequestMVo;
import lims.rsc.vo.RgntMVo;
import lims.rsc.vo.WrhousngMVo;

public interface WrhousngMService {
	public List<WrhousngMVo> getWrhousngList(WrhousngMVo vo);
	public int insWareBrcd(WrhousngMVo vo);
	public int insWrhousng(WrhousngMVo vo);
	public int updbrcdlist(WrhousngMVo vo);
	public List<WrhousngMVo> getbrcdList(WrhousngMVo vo);
	public List<WrhousngMVo> getexpriemList(WrhousngMVo vo);
	public List<WrhousngMVo> selectBrcd(WrhousngMVo vo);
	public int deletBrcd(WrhousngMVo vo);
	public int deletbrcdlist(List<WrhousngMVo> vo);
	public int deletbrcdrowlist(WrhousngMVo vo);
	public int deletexpriem(WrhousngMVo vo);
	public List<WrhousngMVo> getbrcdSeqno(List<WrhousngMVo> list);
	public int wrhsdlvrQydelet(List<WrhousngMVo> list);
}
