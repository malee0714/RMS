package lims.test.dao;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import lims.req.vo.RequestMVo;
import lims.test.vo.RoaMSubVo;
import lims.test.vo.RoaMVo;

public interface RoaMDao {
	/**
	 * 
	 * @param vo
	 * @return 결과 목록 가져옴
	 */
	public List<RoaMVo> roaList(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 의뢰 목록 반환
	 */
	public List<RoaMVo> getReqList(RoaMVo vo);
	
	/**
	 * 
	 * @return 결과입력자 목록 가져옴
	 */
	public List<RoaMVo> resultRegisterUserList();
	
	/**
	 * 
	 * @param list
	 * @return roa 데이터 결과수정함. 입력자랑 입력일 수정가능.
	 */
	public int updRoaData(RoaMVo vo);
	
	/**
	 * 
	 * @return 고객사 목록을 가져옴.
	 */
	public List<RoaMVo> getEntrpsList(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 해당의뢰에 엮인 상위라뜨 리스트
	 */
	public List<RoaMVo> getUpperLotList(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return ROA를 생성한다. 접수의 상태값이 coa 대기로 update됨
	 */
	public int genRoa(RoaMVo vo);
	
	/**
	 * 
	 * @param list
	 * @return 시험항목 죄다 coa 대기로만듬
	 */
	public int genRoaExpriem(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 시험항목 코드를 보내면 lotId와 lcl,ucl, 평균 result값을 가지고 찰트를 만듭니다
	 */
	public List<RoaMVo> getLotChartList(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 알디엠에스 날짜목록
	 */
	public List<RoaMVo> getRdmsDateList(RoaMVo vo);

	public int updRdmsDate(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 의뢰값으로 자재 시험항목 리스트 가져옴...
	 */
	public List<RoaMVo> getPrductSdspcList(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 의뢰값으로 의뢰 시험항목 리스트 가져옴 ...
	 */
	public List<RoaMVo> getReqestExpriemList(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 최신화시킴
	 */
	public int updReqestExpriem(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 추가된 시험항목 최신화
	 */
	public int insReqestExpriem(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 추가된 시험항목 결과에 삽입
	 */
	public int insReqestExpriemResult(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 마스터에서 빠진 시험항목 최신화할때 빼버림
	 */
	public int delReqestExpriem(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 현재갑보기 평균갑 생성
	 */
	public int insResultAvrg(RoaMVo vo);

	/**
	 * 
	 * @param vo
	 * @return 의뢰 그리드 클릭시 최초 실험날짜 가져옴
	 */
	public Map<String,Object> getRealAnalsData(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return roa 이력 몰록
	 */
	public  List<RoaMVo> getRoaEditHistList(RoaMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 분석중으로 돌려줌
	 */
	public int setRoaRollback(RoaMVo vo);
	
	/**
	 * @return RDMS에 재전송할 계산식 데이터
	 * */
	public List<RoaMVo> getRdmsCalcData(RoaMVo vo);
	
	public int updExpriemProgrs(RoaMVo vo);
	
	public List<RoaMVo> getCalcInfo(RoaMVo vo);
	
	public int updtRvsopVriablValue(RoaMVo vo);
	
	public List<RoaMVo> getOrgnRoaData(RoaMVo vo);
	
	public String getBplcAddress(RoaMVo vo);

    public int updRoaResultData(RoaMVo resultData);

    int updReqFailAt(RoaMVo firstVo);
}
