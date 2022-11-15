package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.StdMttrMVo;

public interface StdMttrMDao {
	public List<StdMttrMVo> getStdMttrList(StdMttrMVo vo);
	
	public int saveStdMttrM(StdMttrMVo vo);
	
	public int updStdMttrM(StdMttrMVo vo);
	
	/**
	 * 상위 표준 물질 저장
	 * @param vo
	 * @return
	 */
	public int insUpperStdMttr(StdMttrMVo vo);
	
	/**
	 * 상위 표준 물질 삭제
	 * @param vo
	 * @return
	 */
	public int delUpperStdMttr(StdMttrMVo vo);
	
	/**
	 * 상위 표준 물질 조회
	 */
	public List<StdMttrMVo> getUpperStdMttr(StdMttrMVo vo);
}
