package lims.test.service.Impl;


import lims.test.dao.LotTraceMDao;
import lims.test.service.LotTraceMService;
import lims.test.vo.LotTraceMVo;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LotTraceMServiceImpl implements LotTraceMService {

    private final LotTraceMDao lotTraceMDao;
    private final CommonFunc commonFunc;

    @Autowired
    public LotTraceMServiceImpl(LotTraceMDao lotTraceMDao, CommonFunc commonFunc) {
        this.lotTraceMDao = lotTraceMDao;
        this.commonFunc = commonFunc;
    }

    @Override
    public List<LotTraceMVo> getLotTraceList(LotTraceMVo vo) {
        return lotTraceMDao.getLotTraceList(vo);
    }

    @Override
    public int saveReqTrace(List<LotTraceMVo> list) {
        int count = 0;
        if (list.isEmpty())
            return count;

        for (int i = 0; i < list.size(); i++) {
            //lotNo 신규등록인 경우, 입력한 lotNo 등록하고 해당 의뢰에 등록한 lotNo 일렬번호 업데이트
            if (list.get(i).getLotNoSeqno() == "" || list.get(i).getLotNoSeqno() == null) {
                count = lotTraceMDao.saveReqTrace(list.get(i));
                list.get(i).setLotNoSeqno(list.get(i).getLotNoSeqno());
                lotTraceMDao.saveReqUp(list.get(i));
            } else {
                //바뀐 lotNo 업데이트. lotNo를 빈값으로 수정한 경우 해당 의뢰에서 lotNo 일렬번호 제거
                count = lotTraceMDao.upReqTrace(list.get(i));
                if (list.get(i).getLotNo() == "") {
                    list.get(i).setLotNoSeqno("");
                    count = lotTraceMDao.saveReqUp(list.get(i));
                }
            }
        }

        return Integer.parseInt(list.get(0).getReqestSeqno());
    }

    @Override
    public int saveTrace(List<LotTraceMVo> list) {
        int count = 0;
        if (list.isEmpty())
            return count;

        for (int i = 0; i < list.size(); i++) {
            if (!commonFunc.isEmpty(list.get(i).getReqestSeqno()) && commonFunc.isEmpty(list.get(i).getOrdr())) {
                count = lotTraceMDao.saveTrace(list.get(i));
            } else {
                list.get(i).setSortOrdr(Integer.toString(i+1));
                count = lotTraceMDao.upTrace(list.get(i));
            }
        }

        return count;
    }

    @Override
    public List<LotTraceMVo> getTraceDetail(LotTraceMVo vo) {
        return lotTraceMDao.getTraceDetail(vo);
    }

    @Override
    public int delLotTrace(List<LotTraceMVo> list) {
        int count = 0;
        if (list.isEmpty())
            return count;

        for (int i = 0; i < list.size(); i++) {
            count = lotTraceMDao.delLotTrace(list.get(i));
        }

        return count;
    }
}
