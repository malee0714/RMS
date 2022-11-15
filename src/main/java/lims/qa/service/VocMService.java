package lims.qa.service;

import java.util.List;

import lims.qa.vo.VocMVo;

public interface VocMService {

	
	/**
	 * VOC 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	public List<VocMVo> searchVocList(VocMVo vo);
	
	/**
	 * VOCRegist 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	public List<VocMVo> getVocRegist(VocMVo vo);
	
	/**
	 * VOC 등록
	 * @param request
	 * @param model
	 * @return
	 */
	public int putVoc(VocMVo vo);
	
	/**
	 * VOC 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	public int updateVocDel(VocMVo vo);
	
	
	/**
	 * 원인규명 및 대책수립
	 * @param request
	 * @param model
	 * @return
	 */
	public int putDiagnose(VocMVo vo);
	
	
	/**
	 * VOCRegist 대책수립 조회
	 * @param request
	 * @param model
	 * @return
	 */
	public List<VocMVo> getVocCntrplnFoundng(VocMVo vo);
	
	/**
	 * VOC 대책 등록 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	public int updateVocCntrplnFoundngDel(VocMVo vo);
	
	/**
	 * VOC 유효검증 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	public int updateVocValidVrifyDel(VocMVo vo);
	
	/**
	 * VOC 유효성 검증
	 * @param request
	 * @param model
	 * @return
	 */
	public int putValidVrify(VocMVo vo);
	
	/**
	 * VOCRegist 유효검증 조회
	 * @param request
	 * @param model
	 * @return
	 */
	public List<VocMVo> getVocValidVrify(VocMVo vo);
}
