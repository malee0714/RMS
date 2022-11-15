package lims.wrk.dao;

import lims.wrk.vo.CalcLawMVo;
import lims.wrk.vo.CylinderMVo;

import java.util.List;

public interface CylinderMDao {

    List<CylinderMVo> getcylinderList(CylinderMVo vo);

    int savecylinder(CylinderMVo vo);

    int deletecylinder(CylinderMVo vo);

}
