package lims.src.dao;

import lims.src.vo.QCConditionMVo;

import java.util.List;

public interface QCConditionMDao {
    public List<QCConditionMVo> getQcconditionList(QCConditionMVo vo);
    public List<QCConditionMVo> getQcconditionInspctList(QCConditionMVo vo);
    public List<QCConditionMVo> getQcconditionMtrilList(QCConditionMVo vo);
    public List<QCConditionMVo> getQcconditionPrductList(QCConditionMVo vo);

}
