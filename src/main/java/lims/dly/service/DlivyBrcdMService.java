package lims.dly.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import lims.dly.vo.DlivyMVo;

public interface DlivyBrcdMService {
	/**
	 * 출고 바코드 테이블 저장
	 * @param vo
	 * @return
	 */
	public int insBrcdFormDlivy(DlivyMVo vo);
	
	/**
	 * 바코드 조회
	 * @param vo
	 * @return
	 */
	public List<DlivyMVo> getBarcodeList(DlivyMVo vo);
	
	/**
	 * 바코드 상세 조회
	 * @param vo
	 * @return
	 */
	public List<DlivyMVo> getBarcodeDetailList(DlivyMVo vo);
	
	/**
	 * 바코드 엑셀 출력 조회
	 * @param vo
	 * @return
	 */
	public List<DlivyMVo> getBarcodePrintList(DlivyMVo vo);
	
	/**
	 * 바코드 정보 삭제
	 * @param vo
	 * @return
	 */
	public int insDeleteBarcd(DlivyMVo vo);

	/**
	 * 물류양식 엑셀 출력 조회
	 * @param vo
	 * @return
	 */
	public List<DlivyMVo> getBarcodePrintList3(DlivyMVo vo);

	/**
	 * 품질양식 엑셀 출력 조회
	 * @param vo
	 * @return
	 */
	public List<DlivyMVo> getBarcodePrintList4(DlivyMVo vo);
	
	
}
