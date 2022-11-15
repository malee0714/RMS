package lims.src.dao;

import java.util.List;

import lims.req.vo.RequestMVo;
import lims.test.vo.ResultInputMVo;

public interface TestSearchMDao {
	public List<ResultInputMVo> getReqestListSch(ResultInputMVo vo);

	public List<ResultInputMVo> getExpriemListSch(ResultInputMVo vo);

	/**
	 *
	 * @param vo
	 * @return 접수에 물린 상위 로트 리스트
	 */
	public List<RequestMVo> getReqestUpperLotList(RequestMVo vo);

	/**
	 *
	 * @param vo
	 * @return 접수에 물린 분석 초중말 리스트
	 */
	public List<RequestMVo> getReqestChrgTeamList(RequestMVo vo);

	/**
	 *
	 * @param vo
	 * @return 접수에 물린 Can no 리스트
	 */
	public List<RequestMVo> getReqestCanNoList(RequestMVo vo);

	/**
	 *
	 * @param vo
	 * @return 상위 lot id 콤보 리스트
	 */
	public List<RequestMVo> getUpperLotId(RequestMVo vo);
}
