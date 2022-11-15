package lims.com.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lims.com.vo.RdmsMVo;

public interface RdmsCommonService {
	public void getRdmsResultData(List<RdmsMVo> vo, String ip) ;
	
	public int updateCloseCnvt(RdmsMVo vo);
	
	public int delBinderChck(List<RdmsMVo> vo);

	public Integer delRdmsResultData(List<RdmsMVo> vo);
  
}
