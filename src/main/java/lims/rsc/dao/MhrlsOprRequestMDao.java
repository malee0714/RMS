package lims.rsc.dao;

import java.util.List;

import lims.req.vo.RequestMVo;
import lims.rsc.vo.MhrlsOprRequestMVo;

public interface MhrlsOprRequestMDao {
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
	 * 기기 가동 조회
	 * @param vo
	 * @return
	 */
	public List<MhrlsOprRequestMVo> getMhrlsOpr(MhrlsOprRequestMVo vo);
	
	/**
	 * 기기 가동정보 저장
	 * @param vo
	 * @return
	 */
	public int insMhrlsOpr(MhrlsOprRequestMVo vo);
	
	/**
	 * 기기가동 기기가동건수 저장
	 * @param vo
	 * @return
	 */
	public int updMhrlsRequestOprCnt(MhrlsOprRequestMVo vo);
	
	/**
	 * 기기 가동정보 수정
	 * @param vo
	 * @return
	 */
	public int udpMhrlsOrp(MhrlsOprRequestMVo vo);
	
	/**
	 * 추가된 기기 가동 의뢰 저장
	 * @param vo
	 * @return
	 */
	public int insMhrlsRequestOpr(MhrlsOprRequestMVo vo);
	
	/**
	 * 삭제된 기가 가동 의뢰 저장
	 * @param vo
	 * @return
	 */
	public int updMhrlsRequestOpr(MhrlsOprRequestMVo vo);
	
	/**
	 * 기기 가동시료 의뢰정보 바코드 조회
	 * @param vo
	 * @return
	 */
	public List<RequestMVo> getImReqestBacdList(RequestMVo vo);
	
	/**
	 * 기기 가동 목록 삭제
	 * @param vo
	 * @return
	 */
	public int delMhrlsOprRequest(MhrlsOprRequestMVo vo);
}
