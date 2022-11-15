package lims.test.dao;

import java.util.List;

import lims.com.vo.ChartVo;
import lims.dly.vo.DlivyMVo;
import lims.test.vo.IssueMVo;
import lims.test.vo.ResultInputMVo;

public interface IssueMDao {
	/**
	 * 이슈관리 리스트 조회
	 * @param vo
	 * @return
	 */
	public List<IssueMVo> getIssueMList(IssueMVo vo);
	
	/**
	 * 이슈관리 차트 조회
	 * @param vo
	 * @return
	 */
	public List<ChartVo> getIssueMChart(IssueMVo vo);
	
	/**
	 * 차트 데이터
	 * @param vo
	 * @return
	 */
	public List<ChartVo> getIssueMChartData(IssueMVo vo);	
	
	/**
	 * 신규 이슈정보저장
	 * @param vo
	 * @return
	 */
	public int insIssueInfo(IssueMVo vo);
	
	/**
	 * 이슈 정보 수정
	 * @param vo
	 * @return
	 */
	public int updIssueInfo(IssueMVo vo);
	
	/**
	 * 결재자 수정
	 * @param vo
	 * @return
	 */
	public int approvedChange(IssueMVo vo);
	
	public int updIssueExpriemAt(IssueMVo vo);
	
	public int updIssueAt(IssueMVo vo);
	
	/**
	 * 의뢰 테이블 잠금여부 업데이트
	 * @param vo
	 * @return
	 */
	public int updImReqestLockAt(IssueMVo vo);
	
	public List<IssueMVo> getSendEmailInfo(ResultInputMVo vo);
	
	public String getIssueMailCn(String vo);
	
	/**
	 * 
	 * @param vo
	 * @return 메일 업뎃침
	 */
	public int updMailCn(IssueMVo vo);

	public List<IssueMVo> mainLcountList(IssueMVo vo);

	public List<IssueMVo> mainCcountList(IssueMVo vo);
	
	public int insMobphonCn(ResultInputMVo vo);
	
	public String getMessageTitle(ResultInputMVo vo);
	
	/**
	 * 변경점 알림 문자
	 * @param vo
	 * @return
	 */
	public int insMobphonNtcn(DlivyMVo vo);
}
