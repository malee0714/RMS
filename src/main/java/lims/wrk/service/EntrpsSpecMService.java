package lims.wrk.service;

import lims.rsc.vo.ProductMVo;
import lims.wrk.vo.EntrpsSpecMVo;
import lims.wrk.vo.PrductMVo;

import java.util.List;

public interface EntrpsSpecMService {
	/**
	 * 제품 목록 규격관리 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getPrductListManage(EntrpsSpecMVo vo);
	
	/**
	 * 제품 목록 규격결재 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getPrductList(EntrpsSpecMVo vo);
	
	/**
	 * 제품 이력 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getPrductHist(EntrpsSpecMVo vo);
	
	/**
	 * 자재 팝업 조회
	 * @param vo
	 * @return
	 */
	public List<ProductMVo> getProductPopList(PrductMVo vo);
	
	/**
	 * 시험 항목 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getPrductCtmmnySdspcList(EntrpsSpecMVo vo);
	
	/**
	 * 자재정보 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getPrductCtmmnyMtrilList(EntrpsSpecMVo vo);
	
	/**
	 * 결재순서 정보 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getCmSanctnList(EntrpsSpecMVo vo);
	
	/**
	 * 시험항목 항목추가 조회
	 * @param vo
	 * @return
	 */
	public List<PrductMVo> getPrductExpriemList(PrductMVo vo);
	
	/**
	 * 저장
	 * @param vo
	 * @return
	 */
	public int saveEntrpsSpecM(EntrpsSpecMVo vo);
	
	/**
	 * 수정
	 * @param vo
	 * @return
	 */
	public int updateEntrpsSpecM(EntrpsSpecMVo vo);
	
	/**
	 * 개정
	 * @param vo
	 * @return
	 */
	public int revisionEntrpsSpecM(EntrpsSpecMVo vo);
	
	/**
	 * 현재 정보가 개정승인요청을 했는지 구분
	 * @param vo
	 * @return
	 */
	public String getAmendmentAt(EntrpsSpecMVo vo);

	public int delSyPrductCtmmny(EntrpsSpecMVo vo);

	public int insConfirmM(EntrpsSpecMVo vo);


}
