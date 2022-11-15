package lims.src.dao;

import lims.src.vo.UserTyTestCntMVo;

import java.util.List;

public interface UserTyTestCntMDao {
    public List<UserTyTestCntMVo> getReqCntByUser(UserTyTestCntMVo vo);
}
