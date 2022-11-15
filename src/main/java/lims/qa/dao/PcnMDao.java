package lims.qa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import lims.com.vo.CmExmntDto;
import lims.com.vo.ComboVo;
import lims.qa.vo.PcnChangePointVo;
import lims.qa.vo.PcnMVo;
import lims.qa.vo.QlityDocHistVo;

@Mapper
public interface PcnMDao {
	
	public int getPcnSeq();
	
	public String getChangePointApplcCode(String changePointApplcCn);
	
	public List<PcnMVo> getPcnList(PcnMVo vo);
	
	public int insPcnInfo(PcnMVo vo);
	
	public int insChangePoint(PcnChangePointVo vo);
	
	public int delChangePoint(PcnMVo vo);
	
	public int updPcnInfo(PcnMVo vo);

	public int deletePcnInfo(PcnMVo vo);
	
	public List<ComboVo> getEntrpsNameList();

	public List<ComboVo> getMtrilNameList();
	
	public List<ComboVo> getUserNameList();
	
	public String getMaxPcnNo(String pblicteDate);
	
	public void updateExmntSeqno(CmExmntDto cmExmntDto);
	
	public void updatePcnSanctn(PcnMVo vo);

}
