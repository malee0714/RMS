package lims.wrk.dao;

import lims.wrk.vo.PrductMVo;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

public interface PrductMDao {
	
	/**
	 * 
	 * @param vo
	 * @return 부서 목록 콤보
	 */
	public List<PrductMVo> getDeptList(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 자재목록
	 */
	public List<PrductMVo> getMtrilList(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 사업장별 자재코드 중복체크(insert)
	 */
	public int chkMtrilCodeByPlantIns(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 사업장별 자재코드 중복체크(update)
	 */
	public int chkMtrilCodeByPlantUpd(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 자재관리 새로 저장
	 */
	public int insMtrilNewSave(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 자재 관리 기존 데이터 저장
	 */
	public int updPrductSave(PrductMVo vo);

	/**
	 * 
	 * @param vo
	 * @return 자재 SAP 관련 데이터 존재여부 체크
	 */
	public String getMtrilSapData(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 자재 삭제
	 */
	public int delMtril(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 제품 시험항목 리스트
	 */
	public List<PrductMVo> getMtrilExpriemList(PrductMVo vo);
	
	/**
	 * 
	 * @return 마스터 단위 리스트
	 */
	@RequestMapping(value = "getMasterUnitList.lims")
	public List<PrductMVo> getMasterUnitList(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 시험항목 삽입
	 */
	public int insExpriem(PrductMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 시험항목 수정
	 */
	public int updExpriem(PrductMVo vo);
	
	
	/**
	 * 
	 * @param vo
	 * @return 시험항목 삭제
	 */
	public int delExpriem(PrductMVo vo);

	/**
	 * 
	 * @param vo
	 * @return 일괄추가
	 */
	public int insExpriemAll(PrductMVo vo);


	public int deletCylinder(PrductMVo vo);
	public int addCylinder(PrductMVo vo);

	public int deletExpriem(PrductMVo vo);
	public int deletItemNo(PrductMVo vo);
	public int addItemNo(PrductMVo vo);


	public List<PrductMVo> getcylndrList(PrductMVo vo);
	public List<PrductMVo> getitemNoList(PrductMVo vo);


}
