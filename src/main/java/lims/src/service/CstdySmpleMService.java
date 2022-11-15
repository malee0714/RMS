package lims.src.service;

import java.util.List;

import lims.src.vo.CstdySmpleMVo;
import lims.src.vo.RequestCntMVo;

public interface CstdySmpleMService {

	public List<CstdySmpleMVo>  getCstdyList(CstdySmpleMVo vo);
	/**
	 * 담당 팀별 접수 건수 조회
	 * @param vo
	 * @return
	 */
	public int delRequestCntList(List<CstdySmpleMVo> vo);
}
