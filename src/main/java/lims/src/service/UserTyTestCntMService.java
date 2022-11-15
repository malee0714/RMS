package lims.src.service;

import lims.src.vo.UserTyTestCntMVo;

import java.util.List;

public interface UserTyTestCntMService {
    public List<UserTyTestCntMVo> getReqCntByUser(UserTyTestCntMVo vo);
}
