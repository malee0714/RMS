package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.CmpdsUseMVo;

public interface CmpdsUseMDao {
	public List<CmpdsUseMVo> getCmpdsUseList(CmpdsUseMVo vo);
	
	public int saveCmpdsUseM(CmpdsUseMVo vo);
	
	public List<CmpdsUseMVo> getbrcdData(CmpdsUseMVo vo);

	public CmpdsUseMVo getOrdrs(CmpdsUseMVo vo);
	
	public int saveRepair(CmpdsUseMVo mhrlsCmpdsMVo);

	public List<CmpdsUseMVo> getRepairList(CmpdsUseMVo vo);

	public int delMhrlsCmpdsM(CmpdsUseMVo vo);
	
	public int restockCmpdsM(CmpdsUseMVo vo );
	
	public int sumInvntryQy(CmpdsUseMVo vo);

	public int updCmpdsUseM(CmpdsUseMVo vo);

	public int judgmentCmpdsM(CmpdsUseMVo vo);

	public String getdelete(CmpdsUseMVo vo);

	public String getwrhsdlvrSeCode(CmpdsUseMVo vo);




}
