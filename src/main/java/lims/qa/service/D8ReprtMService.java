package lims.qa.service;

import lims.com.vo.CmExmntDto;
import lims.qa.vo.D8ReprtMVo;

import java.util.HashMap;
import java.util.List;

public interface D8ReprtMService {
    List<D8ReprtMVo> d8ReprtMList(D8ReprtMVo vo);

    HashMap<String, Object> insD8ReprtInfo(D8ReprtMVo vo);
    
    void saveExmnt(CmExmntDto cmExmntDto);

    void revertD8Reprt(D8ReprtMVo d8ReprtMVo);
}
