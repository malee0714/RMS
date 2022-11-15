package lims.sys.dao;

import java.util.List;

import lims.sys.vo.DvyfgEntrpsMVo;

public interface DvyfgEntrpsMDao {
	/**
	 * 납품 업체 정보 저장
	 * @param vo
	 * @return
	 */
	public int saveDvyfgEntrpsM(DvyfgEntrpsMVo vo);
	
	/**
	 * 납품 업체 정보 수정
	 * @param vo
	 * @return
	 */
	public int updDvyfgEntrpsM(DvyfgEntrpsMVo vo);
	
	/**
	 * 납품 업체 사용여부 수정
	 * @param vo
	 * @return
	 */
	public int delDvyfgEntrpsM(DvyfgEntrpsMVo vo);
	
	/**
	 * 납품 업체 정보 조회
	 * @param vo
	 * @return
	 */
	public List<DvyfgEntrpsMVo> getDvyfgEntrpsM(DvyfgEntrpsMVo vo);
	
	
}
