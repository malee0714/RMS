package lims.qa.dao;

import lims.com.vo.CmExmntDto;
import lims.qa.vo.D8ReprtMVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface D8RerptMDao {
    List<D8ReprtMVo> d8ReprtMList(D8ReprtMVo vo);

    int insD8ReprtInfo(D8ReprtMVo vo);

    int updD8ReprtInfo(D8ReprtMVo vo);

    void updateD8ReprtSanctn(D8ReprtMVo vo);

    void updateExmntSeqno(CmExmntDto cmExmntDto);
}
