package lims.wrk.service;

import lims.wrk.vo.CylinderMVo;

import java.util.List;

public interface CylinderMService {

    List<CylinderMVo> getcylinderList(CylinderMVo vo);
    int savecylinder(CylinderMVo vo);
    int deletecylinder(CylinderMVo vo);
    int batchUpdValvMaker(List<CylinderMVo> list);

}
