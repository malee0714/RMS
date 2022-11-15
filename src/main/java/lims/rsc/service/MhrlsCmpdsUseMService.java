package lims.rsc.service;

import java.util.List;

import lims.rsc.vo.MhrlsCmpdsUseMVo;

public interface MhrlsCmpdsUseMService {
	/**
	 * 고비용 소모품 사용 조회
	 * @param vo
	 * @return
	 */
	public List<MhrlsCmpdsUseMVo> getMhrlsCmpdsUseMList(MhrlsCmpdsUseMVo vo);
	
	/**
	 * 바코드로 소모품 조회
	 * @param vo
	 * @return
	 */
	public List<MhrlsCmpdsUseMVo> getBrcdMhrlsCmpdsUseM(MhrlsCmpdsUseMVo vo);
	
	/**
	 * 소모품 사용 시간 정보 저장
	 * @param vo
	 * @return
	 */
	public MhrlsCmpdsUseMVo instMhrlsCmpdsUseM(MhrlsCmpdsUseMVo vo);
	
	/**
	 * 소모품 사용 시간 정보 수정
	 * @param vo
	 * @return
	 */
	public MhrlsCmpdsUseMVo updtMhrlsCmpdsUseM(MhrlsCmpdsUseMVo vo);
	
	/**
	 * 소모품 사용 시간 정보 삭제
	 * @param vo
	 * @return
	 */
	public MhrlsCmpdsUseMVo delMhrlsCmpdsUseM (MhrlsCmpdsUseMVo vo);
}
