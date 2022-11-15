package lims.rsc.service;

import java.util.List;

import lims.rsc.vo.EqpmnRlabltyEvlVo;

public interface EqpmnRlabltyEvlService {
	
	
	/**
	 * 장비 신뢰성평가 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	public List<EqpmnRlabltyEvlVo> searchEqpmnRlabltyEvlRegst(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 장비 신뢰성평가 저장된 시험항목 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	public List<EqpmnRlabltyEvlVo> searchEqpmnRlabltyEvlRegstSub(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 장비 신뢰성평가 저장
	 * @param request
	 * @param model
	 * @return
	 */
	public int saveEqpmnRlabltyEvlRegstDate(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 장비 신뢰성평가 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	public int updateEqpmnRlabltyEvlRegstDel(EqpmnRlabltyEvlVo vo);

	/**
	 * 장비 신뢰성평가 시험항목 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	public List<EqpmnRlabltyEvlVo> getRsEqpmnRlabltyEvlExpriem(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 장비 검사 교정  데이터 호출
	 * @param request
	 * @param model
	 * @return
	 */
	public List<EqpmnRlabltyEvlVo> getCmmnInspctCode(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 장비관리번호로 조회 OR 장비 SELECTBOX로 조회
	 * @param request
	 * @param model
	 * @return
	 */
	public EqpmnRlabltyEvlVo getSelectEqpmnManageNo(EqpmnRlabltyEvlVo vo);
	
	public int getChkRegistDate(EqpmnRlabltyEvlVo vo);
	

	

	

	

	
	
}
