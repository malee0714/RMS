package lims.wrk.service;

import lims.wrk.vo.PrductMVo;

import java.util.List;

public interface PrductMService {
	
	/**
	 * 
	 * @param vo
	 * @return 부서 목록 콤보 만들기위해 뱉을아이
	 */
	
	public List<PrductMVo> getDeptList(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 자재 목록
	 */
	
	public List<PrductMVo> getMtrilList(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 자재관리 새로 저장
	 */
	
	public int insMtrilNewSave(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 자재관리 기존데이터 저장
	 */
	
	public int putMtrilSave(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 자재 삭제
	 */
	
	public int delMtril(PrductMVo vo);
	
	
	/**
	 * 
	 * @param vo
	 * @return 제품 시험항목 리스트
	 */
	
	public List<PrductMVo> getMtrilExpriemList(PrductMVo vo);
	
	/**
	 * 
	 * @return 마스터 단위 리스트
	 */
	
	public List<PrductMVo> getMasterUnitList(PrductMVo vo);
	

	
	/**
	 * 
	 * @param vo
	 * @return 일괄추가 
	 */
	public int insMtrilExpriemAll (PrductMVo vo);

	public int deletCylinder (PrductMVo vo);
	public int deletItemNo(PrductMVo vo);
	public int deletExpriem(PrductMVo vo);
	public List<PrductMVo> getcylndrList(PrductMVo vo);
	public List<PrductMVo> getitemNoList(PrductMVo vo);

}
