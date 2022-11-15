package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.EntrpsSpecMVo;

public interface EntrpsSpecSanctnMServcie {

	/**
	 * 승인
	 * @param vo
	 * @return
	 */
//	public int insApprovalSanctn(EntrpsSpecMVo vo);
	
	/**
	 * 결재대기 상태인지 조회
	 * @param vo
	 * @return
	 */
	public int getApprovalCnt(EntrpsSpecMVo vo);
	
	/**
	 * 반려
	 * @param vo
	 * @return
	 */
	public int insReturnSanctn(EntrpsSpecMVo vo);

	public int insApprovalSanctn(List<EntrpsSpecMVo> vo);
}
