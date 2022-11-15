package lims.test.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.test.vo.ResultInputPscMVo;

public interface ResultInputPscMDao {
	
	/**
	 * 등록파일 업로드, 시험결과 저장
	 * @param request
	 * @return
	 */
	public List<HashMap<String, Object>> paraUpload(MultipartHttpServletRequest request);
	
	/**
	 * 시험항목 일련번호 가져오기
	 * @param vo
	 * @return
	 */
	public String getImReqestExpriemPsc(ResultInputPscMVo vo);
	
	/**
	 * 의뢰 진행상황 가져오기
	 * @param vo
	 * @return
	 */
	public String getProgrsSittnCodePsc(ResultInputPscMVo vo);
	
	/**
	 * 시험 항목 결과 저장
	 * @param vo
	 * @return
	 */
	public int updReqestExpriemResultPsc(ResultInputPscMVo vo);
	
	/**
	 * 시험 항목 결과 평균 저장
	 * @param vo
	 * @return
	 */
	public int updReqestExpriemResultAvrgPsc(ResultInputPscMVo vo);
	
	/**
	 * 의뢰 시험항목 결과 데이터 있는지 확인
	 * @param vo
	 * @return
	 */
	public String getReqestExpriemPsc(ResultInputPscMVo vo);
	
	public int updReqestExpriemProgrsPsc (ResultInputPscMVo vo);
}
