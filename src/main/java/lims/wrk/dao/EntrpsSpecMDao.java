package lims.wrk.dao;

import java.util.List;

import lims.rsc.vo.ProductMVo;
import lims.wrk.vo.EntrpsSpecMVo;
import lims.wrk.vo.PrductMVo;

public interface EntrpsSpecMDao {
	/**
	 * 제품 목록 규격관리 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getPrductListManage(EntrpsSpecMVo vo);
	/**
	 * 제품 목록 결재 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getPrductList(EntrpsSpecMVo vo);
	
	/**
	 * 자재 팝업 조회
	 * @param vo
	 * @return
	 */
	public List<ProductMVo> getProductPopList(PrductMVo vo);
	
	/**
	 * 제품 이력 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getPrductHist(EntrpsSpecMVo vo);
	
	/**
	 * 시험 항목 정보 그리드 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getPrductCtmmnySdspcList(EntrpsSpecMVo vo);
	
	/**
	 * 시험항목 항목추가 조회
	 * @param vo
	 * @return
	 */
	public List<PrductMVo> getPrductExpriemList(PrductMVo vo);
	
	/**
	 * 자재 정보 그리드 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getPrductCtmmnyMtrilList(EntrpsSpecMVo vo);
	
	/**
	 * 결재 순서 그리드 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getCmSanctnList(EntrpsSpecMVo vo);
	
	/**
	 * 제품 고객사 저장
	 * @param vo
	 * @return
	 */
	public int insertSyPrductCtmmny(EntrpsSpecMVo vo);
	
	/**
	 * 제품 고객사 시험항목 저장
	 * @param vo
	 * @return
	 */
	public int insertSyPrductCtmmnySdspc(EntrpsSpecMVo vo);
	
	/**
	 * 제품 고객사 자재 저장
	 * @param vo
	 * @return
	 */
	public int insertSyPrductCtmmnyMtril(EntrpsSpecMVo vo);
	
	/**
	 * 결재라인 저장
	 * @param vo
	 * @return
	 */
	public int insertCMSanctn(EntrpsSpecMVo vo);
	
	/**
	 * 결재 정보 저장
	 * @param vo
	 * @return
	 */
	public int insertCMSanctnInfo(EntrpsSpecMVo vo);
	
	/**
	 * 제품 고객사 기본정보 수정
	 * @param vo
	 * @return
	 */
	public int updatePrductCtmmny(EntrpsSpecMVo vo);
	
	/**
	 * 제품 고객사 결재정보 업데이트
	 * @param vo
	 * @return
	 */
	public int updatePrductCtmmnySanctnLine(EntrpsSpecMVo vo);
	
	/**
	 * 시험항목 수정
	 * @param vo
	 * @return
	 */
	public int updateSyPrductCtmmnySdspc(EntrpsSpecMVo vo);
	
	/**
	 * 시험항목 삭제
	 * @param vo
	 * @return
	 */
	public int deleteSyPrductCtmmnySdspc(EntrpsSpecMVo vo);
	
	/**
	 * 제품 고객사 자재 저장
	 * @param vo
	 * @return
	 */
	public int deleteSyPrductCtmmnyMtril(EntrpsSpecMVo vo);
	
	/**
	 * 결재 정보 삭제
	 * @param vo
	 * @return
	 */
	public int deleteCMSanctnInfo(EntrpsSpecMVo vo);
	
	/**
	 * 시험항목 버전 업데이트
	 * @param vo
	 * @return
	 */
	public int updateSyPrductCtmmnySdspcVer(EntrpsSpecMVo vo);
	
	/**
	 * 제품목록 개정 업데이트
	 * @param vo
	 * @return
	 */
	public int updateSyPrductCtmmnyLastVerAt(EntrpsSpecMVo vo);

	/**
	 * 현재 정보가 개정승인요청을 했는지 구분
	 * @param vo
	 * @return
	 */
	public String getAmendmentAt(EntrpsSpecMVo vo);
	
	//고객사제품삭제
	public int delSyPrductCtmmny(EntrpsSpecMVo vo);
	
	//상신
	public int updSanctnCon(EntrpsSpecMVo vo);
	
	public int delSanctnerCon(EntrpsSpecMVo vo);
	public int insSanctnerCon(EntrpsSpecMVo entrpsSpecMVo);
	public int updLastVer(EntrpsSpecMVo vo);
	public int delUpdLastVer(EntrpsSpecMVo vo);
	public int delSyPrductCtmmnyMtril(EntrpsSpecMVo vo);
	public int delSyPrductCtmmnySdspc(EntrpsSpecMVo vo);
	public int insertPrductCtmmnySdspc(EntrpsSpecMVo requestVo);
	public void insWdtbSanctn(EntrpsSpecMVo wdtbSanctnVo);
	public void insWdtbTrgterSanctn(EntrpsSpecMVo wdtbSanctnVo);

	public int updSanctnSeqno(EntrpsSpecMVo vo);
	
}
