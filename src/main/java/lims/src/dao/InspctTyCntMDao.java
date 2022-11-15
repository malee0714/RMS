package lims.src.dao;

import java.util.List;

import lims.src.vo.InspctTyCntMVo;

public interface InspctTyCntMDao {
	public List<InspctTyCntMVo> getReqCntByInspctTyAndMnth(InspctTyCntMVo vo);
}
