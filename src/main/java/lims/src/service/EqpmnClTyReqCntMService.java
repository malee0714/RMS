package lims.src.service;

import lims.src.vo.EqpmnClTyReqCntMVo;

import java.util.List;

public interface EqpmnClTyReqCntMService {
    public List<EqpmnClTyReqCntMVo> getEqpClReqCntByMnth(EqpmnClTyReqCntMVo vo);
}
