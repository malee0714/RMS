package lims.dly.service;


import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.dly.vo.DlivyMVo;

public interface DlivyMService {
	
	
	/**
	 * 양식 파일 업로드
	 * @param request
	 * @return
	 */
	public HashMap<String, Object> applyFormFile(MultipartHttpServletRequest request);
	
	/**
	 * 미등록 알림 리스트 조회
	 * @param vo
	 * @return
	 */
	public List<DlivyMVo> getDlivyList(DlivyMVo vo);
	
	/**
	 * 출고 이메일 이용자 리스트 조회
	 * @param vo
	 * @return
	 */
	public List<DlivyMVo> getEmailDlivyList(DlivyMVo vo);
	
	
	/**
	 * 미등록 알림 리스트 저장
	 * @param vo
	 * @return
	 */
	public int insDlivyInfo(DlivyMVo vo);
	
	/**
	 * 출고 이메일 이용자 저장
	 * @param vo
	 * @return
	 */
	public int insAddDlivyEmail(DlivyMVo vo);
	
	/**
	 * lot 유효성 체크
	 * @param vo
	 * @return
	 */
	public int getLotValidation(DlivyMVo vo);
	
	/**
	 * INVOICE NO 업로드
	 * @param request
	 * @return
	 */
	public HashMap<String, Object> applyFormFile2(MultipartHttpServletRequest request);
	/**
	 * D/O NO 업로드
	 * @param request
	 * @return
	 */
	public HashMap<String, Object> applyFormFile3(MultipartHttpServletRequest request);
	
}
