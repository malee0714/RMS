package lims.src.service;

import java.util.List;

import lims.com.vo.FileDetailMVo;
import lims.com.vo.RdmsMVo;
import lims.req.vo.RequestMVo;
import lims.test.vo.ResultInputMVo;

public interface TestSearchMService {
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

	/**
	 *
	 * @param vo
	 * @return PDF Viewer Data
	 */
	public FileDetailMVo getblobPdfViewer(RdmsMVo vo);

	/**
	 *
	 * @param List<vo>
	 * @return PDF Viewer Data
	 */
	public FileDetailMVo getCheckBlobPdfViewer(List<RdmsMVo> vo);
}
