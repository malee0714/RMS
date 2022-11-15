package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.PrductUpperMVo;

public interface PrductUpperFMService {
	// 조회
	public List<PrductUpperMVo> getPrductUppFM(PrductUpperMVo vo);

	// 저장
	public int savePrductUppFM(PrductUpperMVo vo);

	// 삭제
	public int delPrductUppFM(PrductUpperMVo vo);

	// 중복체크
	public int chkNo(PrductUpperMVo vo);


	// 중복체크 
	public PrductUpperMVo chkPrductUpp(PrductUpperMVo vo);
}
