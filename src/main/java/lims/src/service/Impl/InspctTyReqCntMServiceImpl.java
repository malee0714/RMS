package lims.src.service.Impl;

import lims.src.dao.InspctTyReqCntMDao;
import lims.src.service.InspctTyReqCntMService;
import lims.src.vo.InspctTyReqCntMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("inspctTyReqCntMServiceImpl")
public class InspctTyReqCntMServiceImpl implements InspctTyReqCntMService {

    @Autowired
    private InspctTyReqCntMDao inspctTyReqCntMDao;

    @Override
    public InspctTyReqCntMVo getReqCntByInspctTy(InspctTyReqCntMVo vo) {
        vo.setList(inspctTyReqCntMDao.getReqCntByInspctTy(vo));
        vo.setListDate(inspctTyReqCntMDao.getMnthByYear(vo));

        return vo;
    }
}
