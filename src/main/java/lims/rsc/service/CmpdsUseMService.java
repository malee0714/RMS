package lims.rsc.service;

import java.util.List;

import lims.rsc.vo.CmpdsUseMVo;

public interface CmpdsUseMService {
	public List<CmpdsUseMVo> getCmpdsUseList(CmpdsUseMVo vo);
	
	public int saveCmpdsUseM(CmpdsUseMVo list);

	public CmpdsUseMVo getOrdrs(CmpdsUseMVo vo);

	public List<CmpdsUseMVo> getbrcdData(CmpdsUseMVo vo);
	
	public List<CmpdsUseMVo> getRepairList(CmpdsUseMVo vo);

	public int delMhrlsCmpdsM(CmpdsUseMVo vo);

	public int restockCmpdsM(CmpdsUseMVo vo, String wrhsdlvrSeCode);

	public int sumInvntryQy(CmpdsUseMVo vo);

	public int judgmentCmpdsM(CmpdsUseMVo vo);


	

	


}
