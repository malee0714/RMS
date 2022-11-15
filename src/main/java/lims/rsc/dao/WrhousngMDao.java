package lims.rsc.dao;

import java.util.HashMap;
import java.util.List;

import lims.rsc.vo.CheckMVo;
import lims.rsc.vo.DlyvyMVo;
import lims.rsc.vo.WrhousngMVo;


public interface WrhousngMDao {
	public List<WrhousngMVo> getWrhousngList(WrhousngMVo vo);
	public int insWareBrcd(WrhousngMVo vo);
	public int insWareBrcdHist(WrhousngMVo vo);
	public int insWrhousng(WrhousngMVo vo);
	public int insDnsty(WrhousngMVo vo);
	public int nowInvntryupdate(WrhousngMVo vo);
	public int delnowInvntryupdate(WrhousngMVo vo);
	public List<WrhousngMVo> getbrcdList(WrhousngMVo vo);
	public List<WrhousngMVo> getexpriemList(WrhousngMVo vo);
	public int updWrhousng(WrhousngMVo vo);
	public int updBrcd(WrhousngMVo vo);
	public int updBrcdHist(WrhousngMVo vo);
	public int updbrcdlist(WrhousngMVo vo);
	public List<WrhousngMVo> selectBrcd(WrhousngMVo vo);
	public int deletBrcd(WrhousngMVo vo);
	public int deletbrcdlist(WrhousngMVo vo);
	public int deletbrcdrowlist(WrhousngMVo vo);
	public int deletexpriem(WrhousngMVo vo);
	public List<WrhousngMVo> getbrcdSeqno(WrhousngMVo vo);
	public int wrhsdlvrQydelet(WrhousngMVo vo);
	public int wrhsdlvrQyadd(WrhousngMVo vo);
	public void deletbrcdhist(WrhousngMVo wrhousngMVo);
	public int delDnsty(WrhousngMVo vo);
}
