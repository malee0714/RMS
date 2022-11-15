package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.EqpmnManageDto;
import lims.rsc.vo.EqpmnRlabltyEvlVo;

public interface EqpmnRlabltyEvlDao {
	
	/**
	 * 장비 신뢰성평가 목록 조회
	 * @param vo
	 * @return
	 */
	public List<EqpmnRlabltyEvlVo> searchEqpmnRlabltyEvlRegst(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 장비 신뢰성평가 저장된 시험항목 목록 조회
	 * @param vo
	 * @return
	 */
	public List<EqpmnRlabltyEvlVo> searchEqpmnRlabltyEvlRegstSub(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 장비 신뢰성평가 저장
	 * @param vo
	 * @return
	 */
	public int saveEqpmnRlabltyEvlRegstDate(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 장비 신뢰성평가 결과 저장
	 * @param vo
	 * @return
	 */
	public int saveEqpmnRlabltyEvlRegstSubDate(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 검사교정구분이 DL이면서 선택된 장비의 DL적용여부가 ‘Y’인 경우 RS_장비분류검출한계 테이블에 INSERT
	 * @param vo
	 * @return
	 */
	public int saveRsEqpmnClDetectLimitDate(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 검사교정구분이 DL이면서 선택된 장비의 DL적용여부가 ‘Y’인 경우 RS_장비분류검출한계 테이블에 INSERT
	 * @param vo
	 * @return
	 */
	public int updateRsEqpmnClDetectLimitOldDate(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return
	 */
	public String getRsEqpmnDetectLimitApplcAt(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 신뢰성평가 삭제
	 * @param vo
	 * @return
	 */
	public int updateEqpmnRlabltyEvlRegstDel(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 장비 신뢰성 평가 등록 일련번호 값조회
	 * @param vo
	 * @return
	 */
	public int getEqpmnRlabltyEvlRegistSeqno(EqpmnRlabltyEvlVo vo);
	
	
	/**
	 * 장비 신뢰성평가 시험항목 목록 조회
	 * @param vo
	 * @return
	 */
	public List<EqpmnRlabltyEvlVo> getRsEqpmnRlabltyEvlExpriem(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 장비 검사 교정  데이터 호출
	 * @param vo
	 * @return
	 */
	public List<EqpmnRlabltyEvlVo> getCmmnInspctCode(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 장비관리번호로 조회 OR 장비 SELECTBOX로 조회
	 * @param vo
	 * @return
	 */
	public EqpmnRlabltyEvlVo getSelectEqpmnManageNo(EqpmnRlabltyEvlVo vo);
	
	/**
	 * 장비 검사 교정 주기 및 주기코드 조회
	 * @param vo
	 * @return
	 */
	public EqpmnManageDto getInspctCrrctCycle(EqpmnRlabltyEvlVo vo);
	
	
	/**
	 * 장비 검사 교정 주기 업데이트
	 * @param vo
	 * @return
	 */
	public int updateInspctCrrctCycle(EqpmnManageDto vo);
	
	/**
	 * dl 업데이트
	 * @param map
	 * @return
	 */
	public int updRsEqpmnClDetectLimitDate(EqpmnRlabltyEvlVo map);

	public int insEqpmnRlabltyEvlRegstDate(EqpmnRlabltyEvlVo vo);

	public int updEqpmnRlabltyEvlRegstDate(EqpmnRlabltyEvlVo vo);

	public int getChkRegistDate(EqpmnRlabltyEvlVo vo);
	
}
