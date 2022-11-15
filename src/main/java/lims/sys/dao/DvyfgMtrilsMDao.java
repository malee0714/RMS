package lims.sys.dao;

import java.util.List;

import lims.sys.vo.DvyfgMtrilsMVo;

public interface DvyfgMtrilsMDao {
	
	/**
	 * 조회
	 * @param vo
	 * @return
	 */
	public List<DvyfgMtrilsMVo> getDvyfgMtrils(DvyfgMtrilsMVo vo);
	
	/**
	 * 저장
	 * @param vo
	 * @return
	 */
	public int insDvyfgMtrils(DvyfgMtrilsMVo vo);
	
	/**
	 * 수정
	 * @param vo
	 * @return
	 */
	public int updDvyfgMtrils(DvyfgMtrilsMVo vo);
	
	/**
	 * 삭제
	 * @param vo
	 * @return
	 */
	public int delDvyfgMtrils(DvyfgMtrilsMVo vo);
	
	
}
