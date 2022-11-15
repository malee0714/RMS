package lims.src.service;

import lims.src.vo.QCConditionDetailMVo;

import java.util.List;

public interface QCConditionDetailMService {
    public List<QCConditionDetailMVo> getQcconditionDetailList(QCConditionDetailMVo vo);
    public List<QCConditionDetailMVo> getQcconditionDetailData(QCConditionDetailMVo vo);
}
