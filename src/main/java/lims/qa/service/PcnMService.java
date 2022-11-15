package lims.qa.service;

import java.util.List;

import lims.com.vo.CmExmntDto;
import lims.com.vo.ComboVo;
import lims.qa.vo.PcnMVo;
import lims.qa.vo.QlityDocHistVo;

public interface PcnMService {
	
	public List<PcnMVo> getPcnList(PcnMVo vo);
	
	public void insPcnInfo(PcnMVo vo);
	
	public void updPcnInfo(PcnMVo vo);
	
	public List<ComboVo> getEntrpsNameList();

	public List<ComboVo> getMtrilNameList();

	public List<ComboVo> getUserNameList();

	public void saveExmnt(CmExmntDto cmExmntDto);

	public void insApprovalPcnM(PcnMVo vo);
	
	public void updApprovalPcnM(PcnMVo vo);
	
	public void revertPcn(PcnMVo vo);

}
