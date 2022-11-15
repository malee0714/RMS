package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.CmpdsUseMVo;
import lims.rsc.vo.DlyvyMVo;


public interface DlyvyMDao {
	public List<DlyvyMVo> getBacode(DlyvyMVo vo);
	public int updateBrcd(DlyvyMVo vo);
	public List<DlyvyMVo> getBacodeChk(DlyvyMVo vo);
	public List<DlyvyMVo> getPrductSeqno(DlyvyMVo vo);
	public int checkBrcd(DlyvyMVo vo);
	public int checkBrcds(DlyvyMVo vo);
	public int updateBrcdHist(DlyvyMVo vo);
	public DlyvyMVo getSeqno(DlyvyMVo vo);
	public List<DlyvyMVo> getPopupBrcd(DlyvyMVo vo);
	

}
