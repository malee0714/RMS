package lims.test.service;

import java.util.HashMap;
import java.util.List;

import lims.test.vo.ResultInputMVo;
import lims.test.vo.RoaMVo;
import lims.wrk.vo.ExprMthMVo;

public interface ResultInputMService {
	public List<ResultInputMVo> getReqestListSch(ResultInputMVo vo);
	
	public List<ResultInputMVo> getExpriemListSch(ResultInputMVo vo);
	
	public List<ResultInputMVo> getExpriemCalcNomfrm(ResultInputMVo vo);
	
	public void saveExpriemResult(ResultInputMVo vo);

	public void completeResultInput(ResultInputMVo vo);
	
	public void returnExpriem(ResultInputMVo vo);
	
	public void changeToNextOdr(ResultInputMVo vo);

}


