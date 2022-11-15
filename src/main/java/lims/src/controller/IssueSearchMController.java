package lims.src.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.src.service.IssueSearchMService;
import lims.test.service.IssueMService;
import lims.test.vo.IssueMVo;

@Controller
@RequestMapping("/src")
public class IssueSearchMController {
	
	@Resource(name="issueSearchMServiceImpl")
	private IssueSearchMService issueSearchMService;

	@RequestMapping(value="IssueSearchM.lims")
	public String IssueSearchM(){
		return "src/IssueSearchM";
	}
	
	@RequestMapping(value="getIssueSearchList.lims")
	public @ResponseBody List<IssueMVo> getIssueSearchList(@RequestBody IssueMVo vo){
		return issueSearchMService.getIssueSearchList(vo);
	}
}
