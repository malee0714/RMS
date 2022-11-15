package lims.qa.dao;

import lims.com.vo.CmExmntDto;
import lims.qa.vo.CstrmrDscnTtmmVo;
import lims.sys.vo.UserMVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CstrmrDscnTTMMDao {
    List<CstrmrDscnTtmmVo> CstrmrDscnTTMList(CstrmrDscnTtmmVo vo);

    int insCstrmrInfo(CstrmrDscnTtmmVo vo);

    int updCstrmrInfo(CstrmrDscnTtmmVo vo);

    void updCstrmrUserInfo(CstrmrDscnTtmmVo userVo);

    void insCstrmrUserInfo(CstrmrDscnTtmmVo userVo);

    void updateCstrmrSanctn(CstrmrDscnTtmmVo vo);

    List<CstrmrDscnTtmmVo> getCstmrUserList(CstrmrDscnTtmmVo vo);

    void updateExmntSeqno(CmExmntDto cmExmntDto);
}
