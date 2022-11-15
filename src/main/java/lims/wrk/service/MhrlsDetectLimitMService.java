package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.MhrlsDetectLimitMVo;

public interface MhrlsDetectLimitMService {
	public List<MhrlsDetectLimitMVo> getDLExpriems(MhrlsDetectLimitMVo vo);
	public int saveExprDl(MhrlsDetectLimitMVo vo);
}
