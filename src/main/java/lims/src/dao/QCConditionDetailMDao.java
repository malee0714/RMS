package lims.src.dao;

import lims.src.vo.QCConditionDetailMVo;

import java.util.List;

public interface QCConditionDetailMDao {
    public List<QCConditionDetailMVo> getQcconditionDetailList(QCConditionDetailMVo vo);
    public List<QCConditionDetailMVo> getQcconditionDetailData(QCConditionDetailMVo vo);

}
