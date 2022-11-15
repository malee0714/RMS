package lims.src.service;

import lims.src.vo.QCConditionMVo;

import java.util.List;

public interface QCConditionMService {
    public List<QCConditionMVo> getQcconditionList(QCConditionMVo vo);
    public List<QCConditionMVo> getQcconditionInspctList(QCConditionMVo vo);
    public List<QCConditionMVo> getQcconditionPrductList(QCConditionMVo vo);
    public List<QCConditionMVo> getQcconditionMtrilList(QCConditionMVo vo);


}
