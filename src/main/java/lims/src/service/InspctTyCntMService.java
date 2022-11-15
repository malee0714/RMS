package lims.src.service;

import java.util.List;

import lims.src.vo.InspctTyCntMVo;

public interface InspctTyCntMService {
	
	public List<InspctTyCntMVo> getReqCntByInspctTyAndMnth(InspctTyCntMVo vo);
}
