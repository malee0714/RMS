package lims.qa.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import lims.req.vo.RequestMVo;
import lims.test.vo.ResultInputMVo;
import lims.test.vo.RoaMVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import lims.qa.service.NCRReportMService;
import lims.qa.vo.NCRReportMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/qa")
public class NCRReportMController {
	@Resource(name="NCRReportMServiceImpl")
	private NCRReportMService ncrReportMService;
	
	@SetLocale
	@RequestMapping(value="NCRReportM.lims")
	public String ncrReportM(HttpServletRequest request, Model model) {
		return "qa/NCRReportM";		
	}
	
	@RequestMapping(value="saveNCRReport.lims")
	public @ResponseBody int saveNCRReport(HttpServletRequest request, Model model, @RequestBody NCRReportMVo vo) {
		return ncrReportMService.saveNCRReport(vo);		
	}

	@RequestMapping(value="deleteNCRReport.lims")
	public @ResponseBody int deleteNCRReport(HttpServletRequest request, Model model, @RequestBody NCRReportMVo ncrSeqno) {
		System.out.println("ncrSeqno : " + ncrSeqno);
		return ncrReportMService.deleteNCRReport(ncrSeqno);

	}
	
	@RequestMapping(value="getNCRReportList.lims")
	public @ResponseBody List<NCRReportMVo> getNCRReportList(HttpServletRequest request, Model model, @RequestBody NCRReportMVo vo) {
		return ncrReportMService.getNCRReportList(vo);		
	}

	@RequestMapping(value="getExpriemListSch.lims")
	public @ResponseBody List<NCRReportMVo> getExpriemListSch(HttpServletRequest request, Model model, @RequestBody NCRReportMVo vo) {
		return ncrReportMService.getExpriemListSch(vo);
	}

	@RequestMapping(value="getRequestExpriemListSch.lims")
	public @ResponseBody List<RoaMVo> getRequestExpriemListSch(HttpServletRequest request, Model model, @RequestBody RoaMVo vo) {
		return ncrReportMService.getRequestExpriemListSch(vo);
	}
	
}
