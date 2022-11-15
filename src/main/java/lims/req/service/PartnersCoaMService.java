package lims.req.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.req.vo.PartnersCoaMVo;

public interface PartnersCoaMService {
	/**
	 * 저장
	 * @param vo
	 * @return
	 */
	public int insPartnersCoaM(PartnersCoaMVo vo);
	
	/**
	 * 수정
	 * @param vo
	 * @return
	 */
	public int updPartnersCoaM(PartnersCoaMVo vo);
	
	/**
	 * 의뢰정보 삭제
	 * @param vo
	 * @return
	 */
	public int delPartnersCoaM(PartnersCoaMVo vo);
	
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
	 * MtrilCode 조회
	 * @param vo
	 * @return
	 */
	public String getMtrilCode(PartnersCoaMVo vo);
	
	public List<PartnersCoaMVo> getExpriem(PartnersCoaMVo vo);

	public List<PartnersCoaMVo> getExpriemCoaList(PartnersCoaMVo vo);

	public int getVenderLotNo(PartnersCoaMVo vo);

}
