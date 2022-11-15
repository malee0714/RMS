package lims.rsc.dao;

import java.util.List;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.vo.MhrlsCmpdsUseMVo;

public interface MhrlsCmpdsUseMDao {
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
	public int instMhrlsCmpdsUseM(MhrlsCmpdsUseMVo vo);
	
	/**
	 * 소모품 사용 시간 정보 수정
	 * @param vo
	 * @return
	 */
	public int updtMhrlsCmpdsUseM(MhrlsCmpdsUseMVo vo);

	/**
	 * 현재 사용 여부 수정
	 * @param vo
	 */
	public int updNowUseAt (MhrlsCmpdsUseMVo vo);
	
	/**
	 * 소모품 사용 시간 정보 삭제
	 * @param vo
	 * @return
	 */
	public int delMhrlsCmpdsUseM (MhrlsCmpdsUseMVo vo);
}
