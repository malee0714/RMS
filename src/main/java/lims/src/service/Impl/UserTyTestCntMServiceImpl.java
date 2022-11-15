package lims.src.service.Impl;

import lims.src.dao.UserTyTestCntMDao;
import lims.src.service.UserTyTestCntMService;
import lims.src.vo.UserTyTestCntMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserTyTestCntMServiceImpl implements UserTyTestCntMService {

    @Autowired
    private UserTyTestCntMDao userTyTestCntMDao;

    @Override
    public List<UserTyTestCntMVo> getReqCntByUser(UserTyTestCntMVo vo) {
        return userTyTestCntMDao.getReqCntByUser(vo);
    }
}
