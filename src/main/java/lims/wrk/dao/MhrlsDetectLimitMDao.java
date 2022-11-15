package lims.wrk.dao;

import java.util.List;

import lims.wrk.vo.MhrlsDetectLimitMVo;

public interface MhrlsDetectLimitMDao {
	public List<MhrlsDetectLimitMVo> getDLExpriems(MhrlsDetectLimitMVo vo);
	public int updExprDl(MhrlsDetectLimitMVo vo);

    int insExprDl(MhrlsDetectLimitMVo vo);
}
