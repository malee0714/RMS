package lims.src.dao;

import lims.src.vo.InspctTyReqCntMVo;

import java.util.List;

public interface InspctTyReqCntMDao {
    public List<InspctTyReqCntMVo> getReqCntByInspctTy(InspctTyReqCntMVo vo);

    public List<InspctTyReqCntMVo> getMnthByYear(InspctTyReqCntMVo vo);
}
