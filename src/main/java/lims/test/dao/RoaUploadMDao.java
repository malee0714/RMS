package lims.test.dao;

import lims.test.vo.RoaUploadMVo;

import java.util.List;

public interface RoaUploadMDao {

    String getMtrilCode(String mtrilSeqno);

    List<String> getMtrilExpriem(String mtrilSeqno);

    void insSyMtrilRoaUpload(RoaUploadMVo vo);

    String getExpriemSeqno(String expriemNm);

    void insSyMtrilRoaUploadResult(RoaUploadMVo vo);

    void delSyMtrilRoaUpload(String mtrilSeqno);

    void delSyMtrilRoaUploadResult(String mtrilSeqno);

    List<RoaUploadMVo> getRoaUploadList(String mtrilSeqno);

    List<RoaUploadMVo> getUsedRoaUploadChkList(RoaUploadMVo vo);
}
