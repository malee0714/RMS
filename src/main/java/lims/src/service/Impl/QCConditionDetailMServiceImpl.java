package lims.src.service.Impl;


import lims.src.dao.QCConditionDetailMDao;
import lims.src.service.QCConditionDetailMService;
import lims.src.vo.QCConditionDetailMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class QCConditionDetailMServiceImpl  implements QCConditionDetailMService {

    @Autowired
    private QCConditionDetailMDao qCConditionDetailMDao;

    @Override
    public List<QCConditionDetailMVo> getQcconditionDetailList(QCConditionDetailMVo vo) {
        return qCConditionDetailMDao.getQcconditionDetailList(vo);
    }
    @Override
    public List<QCConditionDetailMVo> getQcconditionDetailData(QCConditionDetailMVo vo ){
        return  qCConditionDetailMDao.getQcconditionDetailData(vo);
    }
}
