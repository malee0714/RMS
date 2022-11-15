package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.PrductUpperMVo;

public interface PrductUpperMService {
	//조회
	public List<PrductUpperMVo> getPrductUpp(PrductUpperMVo vo);
	//저장
	public int savePrductUpp(List<PrductUpperMVo> list);
	//중복체크
	public int chkNo(PrductUpperMVo vo);
	//삭제
	public int delPrductUpp(List<PrductUpperMVo> list);

}
