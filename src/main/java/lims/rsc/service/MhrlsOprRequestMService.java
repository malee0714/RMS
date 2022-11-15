package lims.rsc.service;

import java.util.List;

import lims.req.vo.RequestMVo;
import lims.rsc.vo.MhrlsOprRequestMVo;

public interface MhrlsOprRequestMService {
	/**
	 * 기기 가동 목록 조회
	 * @param vo
	 * @return
	 */
	public List<MhrlsOprRequestMVo> getMhrlsOprList(MhrlsOprRequestMVo vo);
	
	/**
	 * 기기 관리 번호로 조회 
	 * @param vo
	 * @return
	 */
	public List<MhrlsOprRequestMVo> getMhrlsManageNoList(MhrlsOprRequestMVo vo);
	
	/**
	 * 기기관리번호 바코드 조회
	 * @param vo
	 * @return
	 */
	public List<RequestMVo> getImReqestList(RequestMVo vo);
	
	/**
	 * 기기 가동정보 저장
	 * @param vo
	 * @return
	 */
	public int insMhrlsOprRequest(MhrlsOprRequestMVo vo);
	
	/**
	 * 의뢰정보 바코드 조회
	 */
	public List<RequestMVo> getImReqestBacdList(RequestMVo vo);
	
	/**
	 * 기기 가동 목록 삭제
	 * @param vo
	 * @return
	 */
	public int delMhrlsOprRequest(MhrlsOprRequestMVo vo);
	
}
