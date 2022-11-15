package lims.wrk.dao;

import java.util.List;

import lims.wrk.vo.EntrpsSpecMVo;

public interface EntrpsSpecSanctnMDao {
	
	/**
	 * 결재정보 조회
	 * @param vo
	 * @return
	 */
	public List<EntrpsSpecMVo> getCmSanctnInfo(EntrpsSpecMVo vo);
	
	/**
	 * 승인자 기준 결재정보 조회
	 * @param vo
	 * @return
	 */
	public EntrpsSpecMVo getCmSanctnInfoSanctUser(EntrpsSpecMVo vo);
	
	/**
	 * 결재 정보 승인자별 업데이트
	 * @param vo
	 * @return
	 */
	public int updCmSanctnInfo(EntrpsSpecMVo vo);
	
	/**
	 * 결재 정보 진행상황
	 * @param vo
	 * @return
	 */
	public int updCmSanctnSanctnProgrsSittnCode(EntrpsSpecMVo vo);
	
	/**
	 * 제품 고객사 결재정보 업데이트
	 * @param vo
	 * @return
	 */
	public int updatePrductCtmmnySanctnLine(EntrpsSpecMVo vo);
	
	/**
	 * 결재 진행상황 업데이트
	 * @param vo
	 * @return
	 */
	public int updCmSanctnSanctn(EntrpsSpecMVo vo);
	
	/**
	 * 사용자가 결재 순서인지 조회
	 * @param vo
	 * @return
	 */
	public int getApprovalCnt(EntrpsSpecMVo vo);
	
	/**
	 * 결재진행 여부 업데이트
	 * @param vo
	 * @return
	 */
	public int insReturnSanctn(EntrpsSpecMVo vo);

	
	
	/**
	 * 이전버전 종료일 업데이트
	 * @param vo
	 * @return
	 */
	public int updatePrductCtmmnyPrevious(EntrpsSpecMVo vo);

	//2021-07-19
	public int approveSanctnInfo(EntrpsSpecMVo entrpsSpecMVo);

	public int approveSanctnInfoNextAppn(EntrpsSpecMVo entrpsSpecMVo);

	public int approveSanctn(EntrpsSpecMVo entrpsSpecMVo);

	public int insRtnSanctn(EntrpsSpecMVo entrpsSpecMVo);

	public int updSanctnInfoProgrsCode(EntrpsSpecMVo entrpsSpecMVo);

	public int updSanctnProgrsCode(EntrpsSpecMVo entrpsSpecMVo);
	
	public int updatePrductCtmmnySanctnLineLastVerYn(EntrpsSpecMVo vo);

	public int updRtnSanctnUseAt(EntrpsSpecMVo vo);

	public List<EntrpsSpecMVo> limitMtril(EntrpsSpecMVo updVo);

	public int updMtrilSdspc(EntrpsSpecMVo entrpsSpecMVo);

	public String getMtrilSeqno(List<EntrpsSpecMVo> vo);

	public int insWdtbSanctn(EntrpsSpecMVo entrpsSpecMVo);

	public int insWdtbTrgterSanctn(EntrpsSpecMVo entrpsSpecMVo);
	
}
