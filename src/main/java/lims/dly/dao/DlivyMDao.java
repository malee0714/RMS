package lims.dly.dao;

import java.util.List;

import lims.dly.vo.DlivyMVo;
import lims.req.vo.RequestMVo;

public interface DlivyMDao {
	
	/**
	 * lot 번호로 의뢰번호 조회
	 * @param vo
	 * @return
	 */
	public String getReqestSeqno(DlivyMVo vo);
	
	/**
	 * 출고테이블 저장
	 * @param vo
	 * @return
	 */
	public int insDlivy(DlivyMVo vo);
	
	/**
	 * 미등록 알림 리스트 조회
	 * @param vo
	 * @return
	 */
	public List<DlivyMVo> getDlivyList(DlivyMVo vo);
	
	/**
	 * 제조일자 조회
	 */
	public String getMnfcturDte(DlivyMVo vo);
	
	/**
	 * LOT ID 조회
	 */
	public String getLotId(DlivyMVo vo);
	
	/**
	 * 출고 이메일 사용자 저장
	 * @param vo
	 * @return
	 */
	public int insDlivyEmailUser(DlivyMVo vo);
	
	/**
	 * 출고 이메일 이용자 리스트 조회
	 * @param vo
	 * @return
	 */
	public List<DlivyMVo> getEmailDlivyList(DlivyMVo vo);
	
	/**
	 * 미등록 알림 리스트 삭제
	 * @param vo
	 * @return
	 */
	public int delDlivyInfo(DlivyMVo vo);
	
	
	/**
	 * 미등록 알림 리스트 수정
	 * @param vo
	 * @return
	 */
	public int updDlivyInfo(DlivyMVo vo);
	
	/**
	 * 출고 이메일 이용자 저장
	 * @param vo
	 * @return
	 */
	public int insAddDlivyEmail(DlivyMVo vo);
	
	/**
	 * 출고 이메일 이용자 정보 삭제
	 * @param vo
	 * @return
	 */
	public int delDlivyEmailList(DlivyMVo vo);
	
	/**
	 * 자재관리에서 등록한 미등록알림 대상자 조회
	 * @param vo
	 * @return
	 */
	public List<DlivyMVo> getEmailSyDlivyList(DlivyMVo vo);

	/**
	 * 의뢰 변경점, 기타 개 수 확인
	 * @param vo
	 * @return
	 */
	public int getReqestSeCodeCnt(DlivyMVo vo);
	
	public DlivyMVo getReqNtcnInfo(DlivyMVo vo);
	
	/**
	 * lot 유효성 체크
	 * @param vo
	 * @return
	 */
	public int getLotValidation(DlivyMVo vo);
	
	/**
	 * lot로 의뢰일련번호 조회
	 * @param vo
	 * @return
	 */
	public String getLotToRequestSeqno(DlivyMVo vo);

	/**
	 * 자재 + po + batch로  출고바코드 업데이트
	 * @param vo
	 * @return
	 */
	public int getInvoSeq(DlivyMVo dlivyVo);
	


	public List<DlivyMVo> getVrfctChk(DlivyMVo vo);

	public void getInvoDeailSeq(DlivyMVo dlivyMVo);

	public List<DlivyMVo> vrfctDetail(DlivyMVo dlivyMVo);

	public int getInvoDetail(DlivyMVo dlivyMVo);

	public int getCmpResult(DlivyMVo dlivyMVo);











	
}
