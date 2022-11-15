package lims.com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import lims.com.vo.RdmsMVo;
import lims.wrk.vo.CalcLawMVo;

public interface RdmsCommonDao {
	public int updRdmsData(HashMap<String, Object> map);
	
	public int insRdmsCalData(HashMap<String, Object> map);
	
	public List<HashMap<String, Object>> getChkRdmsInfo(HashMap<String, Object> map);
	
	public int deleteRdmsDate(HashMap<String, Object> map);
	
	public int insRdmsDate(HashMap<String, Object> map);
	
	public List<HashMap<String,Object>> getCalcLawInfo(HashMap<String,Object> map);
	
	public List<HashMap<String,Object>> getPrductCalcSeqno(HashMap<String,Object> str);
	
	public int insEqpmnOprSplore(HashMap<String,Object> lotId);
	
	public int delBinderChck(RdmsMVo vo);
	
	public int updateCalcLawSeqno(HashMap<String,Object> vo);
	
	public int updateResultValue(HashMap<String,Object> vo);
	
	public int updateCalcInfo(HashMap<String,Object> vo);
	
	public String getBplcCode(String ip);

    public List<HashMap<String, Object>> getchkRdmsMasterCalcInfo(HashMap<String, Object> item);

	public int updtExcelUploadData(HashMap<String,Object> vo);

}
