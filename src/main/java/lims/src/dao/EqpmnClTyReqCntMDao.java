package lims.src.dao;

import lims.src.vo.EqpmnClTyReqCntMVo;

import java.util.List;

public interface EqpmnClTyReqCntMDao {
    public List<EqpmnClTyReqCntMVo> getEqpClReqCntByMnth(EqpmnClTyReqCntMVo vo);
}
