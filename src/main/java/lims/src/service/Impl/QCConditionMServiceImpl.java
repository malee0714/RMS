package lims.src.service.Impl;


import lims.src.dao.QCConditionMDao;

import lims.src.service.QCConditionMService;
import lims.src.vo.QCConditionMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class QCConditionMServiceImpl  implements QCConditionMService {
    @Autowired
    private QCConditionMDao qCConditionMDao;


    @Override
    public List<QCConditionMVo> getQcconditionList(QCConditionMVo vo) {
        return  qCConditionMDao.getQcconditionList(vo);
    }
    @Override
    public List<QCConditionMVo> getQcconditionInspctList(QCConditionMVo vo) {
        return  qCConditionMDao.getQcconditionInspctList(vo);
    }
    @Override
    public List<QCConditionMVo> getQcconditionPrductList(QCConditionMVo vo) {
        return  qCConditionMDao.getQcconditionPrductList(vo);
    }
    @Override
    public List<QCConditionMVo> getQcconditionMtrilList(QCConditionMVo vo) {
        return  qCConditionMDao.getQcconditionMtrilList(vo);
    }

}
