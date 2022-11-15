package lims.sys.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.sys.vo.DvyfgEntrpsMVo;

public interface DvyfgEntrpsMService {

	/**
	 * 납품 업체 정보 저장
	 * @param vo
	 * @return
	 */
	public int saveDvyfgEntrpsM(DvyfgEntrpsMVo vo);
	
	/**
	 * 납품 업체 정보 조회
	 * @param vo
	 * @return
	 */
	public List<DvyfgEntrpsMVo> getDvyfgEntrpsM(DvyfgEntrpsMVo vo);
	
	/**
	 * 납품업체 엑셀 업로드
	 * @param request
	 * @return
	 */
	public HashMap<String, Object> uploadDvyfgEntrpsExcel(MultipartHttpServletRequest request);
	
	
}
