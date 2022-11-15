package lims.qa.dao;

import java.util.List;

import lims.qa.vo.VocMVo;

public interface VocMDao {

	/**
	 * VOC 목록 조회
	 * @param vo
	 * @return
	 */
	public List<VocMVo> searchVocList(VocMVo vo);
	
	/**
	 * VOCRegist 목록 조회
	 * @param vo
	 * @return
	 */
	public List<VocMVo> getVocRegist(VocMVo vo);
	
	/**
	 * VOC 등록
	 * @param vo
	 * @return
	 */
	public int putVoc(VocMVo vo);
	
	/**
	 * VOC 업데이트
	 * @param vo
	 * @return
	 */
	public int updateVoc(VocMVo vo);
	
	/**
	 * VOC 등록 저장
	 * @param vo
	 * @return
	 */
	public int putVocRegist(VocMVo vo);
	
	/**
	 * VOCSeqno 값 호출 
	 * @param vo
	 * @return
	 */
	public int getVocSeqno(VocMVo vo);
	
	/**
	 * VOCRegistSeqno 값 호출 
	 * @param vo
	 * @return
	 */
	public int getVocRegistSeqno(VocMVo vo);
	
	/**
	 * vocCntrplnFoundngSeqno 값 호출 
	 * @param vo
	 * @return
	 */
	public int getVocCntrplnFoundngSeqno(VocMVo vo);
	
	/**
	 * VocValidVrifySeqno 값 호출 
	 * @param vo
	 * @return
	 */
	public int getVocValidVrifySeqno(VocMVo vo);
	
	/**
	 * VocRceptNo 값 조회 
	 * @param vo
	 * @return
	 */
	public String getVocRceptNo(VocMVo vo);
	
	/**
	 * Voc삭제 
	 * @param vo
	 * @return
	 */
	public int updateVocDel(VocMVo vo);
	
	/**
	 * Voc 대책 등록삭제 
	 * @param vo
	 * @return
	 */
	public int updateVocCntrplnFoundngDel(VocMVo vo);
	
	/**
	 * Voc 유효검증 삭제 
	 * @param vo
	 * @return
	 */
	public int updateVocValidVrifyDel(VocMVo vo);
	
	
	/**
	 * VOC 대책수립 저장
	 * @param vo
	 * @return
	 */
	public int putVocCntrplnFoundng(VocMVo vo);
	
	/**
	 * VOC 유효성검증 저장
	 * @param vo
	 * @return
	 */
	public int putVocValidVrify(VocMVo vo);
	
	
	/**
	 * VOC대책수립 조회
	 * @param vo
	 * @return
	 */
	public List<VocMVo> getVocCntrplnFoundng(VocMVo vo);
	
	/**
	 * VOC유효 검증
	 * @param vo
	 * @return
	 */
	public List<VocMVo> getVocValidVrify(VocMVo vo);

}
