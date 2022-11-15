package lims.test.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.com.vo.ChartVo;
import lims.test.service.IssueMService;
import lims.test.vo.IssueMVo;
import lims.util.GetUserSession;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/test")
public class IssueMController {

	@Resource(name = "IssueMService")
	private IssueMService issueMService;
	
	@SetLocale
	@RequestMapping(value = "/IssueM.lims")
	public String IssueM(Model model){
		GetUserSession getUserSession = new GetUserSession();
		model.addAttribute("loginId", getUserSession.getUserId());
		return "test/IssueM";
	}
	
	
	
	/**
	 * 이슈관리 리스트 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping("/getIssueMList.lims")
	public @ResponseBody List<IssueMVo> getIssueMList(@RequestBody IssueMVo vo){
		return issueMService.getIssueMList(vo);
	}
	
	/**
	 * 이슈관리 차트 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping("/getIssueMChart.lims")
	public @ResponseBody List<ChartVo> getIssueMChart(@RequestBody IssueMVo vo){
		return issueMService.getIssueMChart(vo);
	}
	
	/**
	 * 외부 이슈정보저장
	 * @param vo
	 * @return
	 */
	@RequestMapping("/saveIssueInfo.lims")
	public @ResponseBody int saveIssueInfo(@RequestBody IssueMVo vo){
		int result = 0;
		//신규저장
		if(vo.getCrud().equals("C")){
			result = issueMService.insIssueInfo(vo);
		}
		//수정 저장
		else if(vo.getCrud().equals("U")){
			result = issueMService.updIssueInfo(vo);
		}
		else if(vo.getCrud().equals("A")){
			result = issueMService.updIssueInfo(vo);
		}
		return result;
	}
	
	/**
	 * 결재자 수정
	 * @param vo
	 * @return
	 */
	@RequestMapping("/approvedChange.lims")
	public @ResponseBody int approvedChange(@RequestBody IssueMVo vo){
		int result = issueMService.approvedChange(vo);		
		return result;
	}
	
	/**
	 * 메인 이상목록 전월 리스트 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping("/mainLcountList.lims")
	public @ResponseBody List<IssueMVo> mainLcountList(@RequestBody IssueMVo vo){
		return issueMService.mainLcountList(vo);
	}
	
	/**
	 * 메인 이상목록 당월 리스트 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping("/mainCcountList.lims")
	public @ResponseBody List<IssueMVo> mainCcountList(@RequestBody IssueMVo vo){
		return issueMService.mainCcountList(vo);
	}
	
	/**
	 * 메일내용불러오기
	 * @param vo
	 * @return
	 */
	@RequestMapping(value="/getIssueMailCn.lims", produces="application/text;charset=utf-8")
	public @ResponseBody String getIssueMailCn(@RequestBody IssueMVo vo, HttpServletResponse response){
		
		String issueSeqno = vo.getIssueSeqno();
		return issueMService.getIssueMailCn(issueSeqno);
	}
	
	
}
