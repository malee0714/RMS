package lims.test.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lims.req.vo.RequestMVo;
import lims.test.vo.RoaMVo;

//import lims.test.vo.RoaMVo;

public interface RoaMService {

	/**
	 * @param vo
	 * @return 결과 목록 가져옴
	 */
	public List<RoaMVo> roaList(RoaMVo vo);

	/**
	 * @param vo
	 * @return 의뢰 목록 반환
	 */
	public List<RoaMVo> getReqList(RoaMVo vo);

	/**
	 * @return 결과입력자 목록 가져옴
	 */
	public List<RoaMVo> resultRegisterUserList();

	/**
	 * @param list
	 * @return roa 데이터 결과수정함. 입력자랑 입력일 수정가능.
	 */
	public Void updRoaData(List<RoaMVo> vo);

	/**
	 * @return 의뢰 더블클릭시 고객사 목록을 가져옴.
	 */
	public List<RoaMVo> getEntrpsList(RoaMVo vo);

	/**
	 * @param vo
	 * @return 해당의뢰에 엮인 상위라뜨 리스트
	 */
	public List<RoaMVo> getUpperLotList(RoaMVo vo);

	/**
	 * @param vo
	 * @return roa를 생성한다(설명하자면 긴데 resultOfAnalysisGenerator 줄여서 genRoa ㅎ)
	 */
	public Map<String, Object> resultOfAnalysisGenerator_aka_genRoa(RoaMVo vo);

	/**
	 * @param vo
	 * @return 시험항목 코드를 보내면 lotId와 lcl,ucl, 평균 result값을 가지고 찰트를 만듭니다
	 */
	public List<RoaMVo> getLotChartList(RoaMVo vo);

	/**
	 * @param vo
	 * @return 알디엠에스 날짜목록
	 */
	public List<RoaMVo> getRdmsDateList(RoaMVo vo);

	/**
	 * @param vo
	 * @return rdms date 변경
	 */
	public HashMap<String, Object> updRdmsDate(List<RoaMVo> vo);

	/**
	 * @param vo
	 * @return ROA 현재값 보기 기능입니다
	 */
	public HashMap<String, Object> setChangeNowData(RoaMVo vo);

	/**
	 * @param vo
	 * @return 의뢰 그리드 클릭시 최초 실험날짜 가져옴
	 */
	public Map<String, Object> getRealAnalsData(RoaMVo vo);

	/**
	 * @param vo
	 * @return roa 이력 몰록
	 */
	public List<RoaMVo> getRoaEditHistList(RoaMVo vo);

	/**
	 * @param vo
	 * @return 분석중으로 돌려줌
	 */
	public void setRoaRollback(List<RoaMVo> vo);

	public void genRoa(RoaMVo vo);

}
