package lims.req.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.req.vo.PartnersCoaMVo;

public interface PartnersCoaMDao {
	
	/**
	 * 협력업체 의뢰목록 조회
	 * @param vo
	 * @return
	 */
	public List<PartnersCoaMVo> getPartnersCoaList(PartnersCoaMVo vo);
	
	/**
	 * 시험항목 정보 조회
	 * @param vo
	 * @return
	 */
	public List<PartnersCoaMVo> getImReqestExpriem(PartnersCoaMVo vo);
	
	/**
	 * 의뢰정보 저장
	 */
	public int insImRequest(PartnersCoaMVo vo);
	
	/**
	 * CAN 정보 저장
	 * @param vo
	 * @return
	 */
	public int insImReqestCanNo(PartnersCoaMVo vo);
	
	/**
	 * 시험 항목 정보 저장
	 * @param vo
	 * @return
	 */
	public int insImReqestExpriem(PartnersCoaMVo vo);
	
	/**
	 * 시험 항목 결과 정보 저장
	 * @param vo
	 * @return
	 */
	public int insImReqestExpriemResult(PartnersCoaMVo vo);
	
	/**
	 * 시험 항목 결과 평균 저장
	 * @param vo
	 * @return
	 */
	public int insImReqestExpriemResultAvrg(PartnersCoaMVo vo);
	
	/**
	 * 의뢰정보 수정
	 * @param vo
	 * @return
	 */
	public int updImRequest(PartnersCoaMVo vo);
	
	/**
	 * 시험항목 정보 수정
	 * @param vo
	 * @return
	 */
	public int delImReqestExpriem(PartnersCoaMVo vo);
	public int delImReqestExpriemResult(PartnersCoaMVo vo );
	
	/**
	 * 시험 항목 결과 정보 수정
	 * @param vo
	 * @return
	 */
	public int updImReqestExpriemResult(PartnersCoaMVo vo);
	
	/**
	 * 시험 항목 결과 평균 수정
	 * @param vo
	 * @return
	 */
	public int updImReqestExpriemResultAvrg(PartnersCoaMVo vo);
	
	/**
	 * 의뢰정보 삭제
	 * @param vo
	 * @return
	 */
	public int delImRequest(PartnersCoaMVo vo);
	/**
	 * MtrilCode 조회
	 * @param vo
	 * @return
	 */
	public String getMtrilCode(PartnersCoaMVo vo);
	
	/**
	 * 시험항목 엑셀 업로드
	 * @param request
	 * @return
	 */
	public HashMap<String, Object> partnersCoaFileExcelUpload(MultipartHttpServletRequest request);

	public List<PartnersCoaMVo> getExpriem(PartnersCoaMVo vo);

	public List<PartnersCoaMVo> getExpriemCoaList(PartnersCoaMVo vo);

	public List<PartnersCoaMVo> getReqestExpriemSeqno(PartnersCoaMVo vo);

	
	public int getVenderLotNo(PartnersCoaMVo vo);

	public int delLotno(PartnersCoaMVo vo);

	
	

}
