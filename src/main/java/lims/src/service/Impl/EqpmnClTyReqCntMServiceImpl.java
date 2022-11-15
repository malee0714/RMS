package lims.src.service.Impl;

import lims.src.dao.EqpmnClTyReqCntMDao;
import lims.src.service.EqpmnClTyReqCntMService;

import lims.src.vo.EqpmnClTyReqCntMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("eqpmnClTyReqCntMServiceImpl")
public class EqpmnClTyReqCntMServiceImpl implements EqpmnClTyReqCntMService {

    @Autowired
    private EqpmnClTyReqCntMDao eqpmnClTyReqCntMDao;

    @Override
    public List<EqpmnClTyReqCntMVo> getEqpClReqCntByMnth(EqpmnClTyReqCntMVo vo) {
        return eqpmnClTyReqCntMDao.getEqpClReqCntByMnth(vo);
    }
}
