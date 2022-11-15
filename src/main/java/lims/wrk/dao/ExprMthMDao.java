package lims.wrk.dao;

import java.util.List;

import lims.wrk.vo.ExprMthMVo;

public interface ExprMthMDao {

	//시험방법 조회
	public List<ExprMthMVo> getExprMthMList(ExprMthMVo vo);

	//시험방법 저장
	public int insExprMthM(ExprMthMVo vo);

	//시험방법 업데이트
	public int updExprMthM(ExprMthMVo vo);
}
