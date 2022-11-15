package lims.qa.service;

import lims.com.vo.CmExmntDto;
import lims.qa.vo.NcrMVo;

import java.util.List;

public interface NcrMService {

    void saveNcr(NcrMVo ncrMVo);

    void approvalRequestNcr(NcrMVo ncrMVo);

    List<NcrMVo> getNcrList(NcrMVo vo);

    List<NcrMVo> getExprGrid(NcrMVo vo);

    List<NcrMVo> ncrExpriemGrid(NcrMVo vo);

    int deleteNcr(NcrMVo ncrMVo);

    void saveExmnt(CmExmntDto cmExmntDto);

    void revertNcr(NcrMVo ncrMVo);
}
