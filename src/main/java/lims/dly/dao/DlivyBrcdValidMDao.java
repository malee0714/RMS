package lims.dly.dao;

import java.util.HashMap;
import java.util.List;

import lims.dly.vo.DlivyMVo;

public interface DlivyBrcdValidMDao {
	/**
	 * 바코드 조회
	 */
	public DlivyMVo getBrcdVal(DlivyMVo vo);
	
	/**
	 * 바코드 개별 조회
	 * @param vo
	 * @return
	 */
	public int getBrcdValidation(HashMap<String, Object> param);
	
	/**
	 * 출고 바코드 테이블 진행상태 수정
	 * @param vo
	 * @return
	 */
	public int updDlivyBrcdInfoSttusCode(DlivyMVo vo);
	
	/**
	 * 출보 바코드 상세 테이블 진행상태 수정
	 * @param vo
	 * @return
	 */
	public int updDlivyBrcdDetailSttusCode(HashMap<String, Object> param);
	
	/**
	 * 바코드 합격여부 조회
	 * @param vo
	 * @return
	 */
	public DlivyMVo getBrcdProgrsSittnCode(DlivyMVo vo);
	
	/**
	 * 바코드 합격 갯수 확인
	 * @param vo
	 * @return
	 */
	public int getTopReprCnt(DlivyMVo vo);

}
