package lims.test.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.com.vo.ChartVo;
import lims.test.vo.IssueMVo;
import lims.test.vo.ResultInputMVo;

public interface IssueMService {
	
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
	
	
	//이메일전송 완료된 이슈 이메일전송 완료 여부 Y처리
	public int updIssueExpriemAt(IssueMVo vo);
	
	public List<IssueMVo> getSendEmailInfo(ResultInputMVo vo);
	
	public String getIssueMailCn(String vo);
	
	/**
	 * 
	 * @param vo
	 * @return 파일명 던저준다
	 */
	public String saveChartImg(IssueMVo vo);
	
	/**
	 * 
	 * @param vo
	 * @return 메일 업뎃침
	 */
	public int updMailCn(IssueMVo vo);

	public List<IssueMVo> mainLcountList(IssueMVo vo);

	public List<IssueMVo> mainCcountList(IssueMVo vo);

	//문자 보내기 위한 내용 insert
	public int insMobphonCn(ResultInputMVo vo);
	
	//문자 제목 가져오기.
	public String getMessageTitle(ResultInputMVo vo);
	
}
