package lims.test.dao;


import lims.test.vo.LotTraceMVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface LotTraceMDao {
    List<LotTraceMVo> getLotTraceList(LotTraceMVo vo);
    int saveReqTrace(LotTraceMVo lotTraceMVo);
    int upReqTrace(LotTraceMVo lotTraceMVo);
    int saveReqUp(LotTraceMVo lotTraceMVo);
    int saveTrace(LotTraceMVo lotTraceMVo);
    int upTrace(LotTraceMVo lotTraceMVo);
    List<LotTraceMVo> getTraceDetail(LotTraceMVo vo);
    int delLotTrace(LotTraceMVo lotTraceMVo);

}
