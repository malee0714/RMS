package lims.qa.service;

import lims.com.vo.CmExmntDto;
import lims.qa.vo.CstrmrDscnTtmmVo;
import lims.qa.vo.D8ReprtMVo;

import java.util.HashMap;
import java.util.List;

public interface CstrmrDscnTTMMService {
    List<CstrmrDscnTtmmVo> CstrmrDscnTTMList(CstrmrDscnTtmmVo vo);

    HashMap<String, Object> insCstrmrInfo(CstrmrDscnTtmmVo vo);

    List<CstrmrDscnTtmmVo> getCstmrUserList(CstrmrDscnTtmmVo vo);
    
    void saveExmnt(CmExmntDto cmExmntDto);

    void revertCstrmrDscntt(CstrmrDscnTtmmVo vo);

    void removeCstmrUser(CstrmrDscnTtmmVo vo);
}
