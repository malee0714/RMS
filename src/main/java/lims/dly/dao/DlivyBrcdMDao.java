package lims.dly.dao;

import java.util.List;

import lims.dly.vo.DlivyMVo;
import lims.sys.vo.DvyfgEntrpsMVo;

public interface DlivyBrcdMDao {
		
	/**
	 * 출고 바코드 테이블 저장
	 * @param vo
	 * @return
	 */
	public int insBrcdDlivy(DlivyMVo vo);
	
	/**
	 * 바코드 저장
	 * @param vo
	 * @return
	 */
	public int insDlivyBrcdDetail(DlivyMVo vo);
	
	/**
	 * 바코드 정보 삭제
	 * @param vo
	 * @return
	 */
	public int insDeleteBarcodeInfo(DlivyMVo vo);
	
	/**
	 * 바코드 정보 하위 바코드 삭제
	 * @param vo
	 * @return
	 */
	public int insDeleteBarcodeList(DlivyMVo vo);
	
	/**
	 * 납품 업체 코드 조회
	 * @param vo
	 * @return
	 */
	public String getDvyfgEntrpsCode(DlivyMVo vo);
	
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
	 * 바코드 정보 수정
	 * @param vo
	 * @return
	 */
	public int updBrcdDlivy(DlivyMVo vo);
	
	/**
	 * 바코드 수량 수정
	 * @param vo
	 * @return
	 */
	public int updBrcdDlivyQy(DlivyMVo vo);
	
	/**
	 * 바코드 수량 조회
	 * @param vo
	 * @return
	 */
	public String getDlivyQy(DlivyMVo vo);
	
	/**
	 * 문자일림 사용자 목록
	 * @param vo
	 * @return
	 */
	public List<DlivyMVo> getSyDeptAcctoNtcnTrgter(DlivyMVo vo);


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
