package lims.test.service;

import lims.test.vo.LotTraceMVo;
import java.util.List;

public interface LotTraceMService {

    List<LotTraceMVo> getLotTraceList(LotTraceMVo vo);

    int saveReqTrace(List<LotTraceMVo> list);

    int saveTrace(List<LotTraceMVo> list);

    List<LotTraceMVo> getTraceDetail(LotTraceMVo vo);

    int delLotTrace(List<LotTraceMVo> list);
}
