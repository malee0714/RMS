package lims.src.dao;

import java.util.List;

import lims.src.vo.CstdySmpleMVo;

public interface CstdySmpleMDao {

	public List<CstdySmpleMVo> getCstdyList(CstdySmpleMVo vo);
	/**
	 * 담당 팀별 접수 건수 조회
	 * @param vo
	 * @return
	 */

	public int delRequestCntList(CstdySmpleMVo vo);
}
