package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.util.Locale.SetLocale;
import lims.wrk.service.PrintngMService;
import lims.wrk.vo.PrintngMVO;

@Controller
@RequestMapping("/wrk")
public class PrintngMController {

	@Resource(name = "printngMServiceImpl")
	private PrintngMService printngMService;

	@SetLocale()
	@RequestMapping(value = "PrintngM.lims" )
	public String PrintngM(HttpServletRequest request, Model model) {
		return "wrk/PrintngM";
	}

	@RequestMapping(value = "getPrintngMList.lims")
	public @ResponseBody List<PrintngMVO> getPrintngMList(@RequestBody PrintngMVO vo, Model model){
		return printngMService.getPrintngMList(vo);
	}

	@RequestMapping(value = "savePrintngM.lims")
	public @ResponseBody int savePrintngM(MultipartHttpServletRequest request){
		return printngMService.savePrintngM(request);
	}

	@RequestMapping(value = "deletePrintngM.lims")
	public @ResponseBody int deletePrintngM(@RequestBody PrintngMVO vo){
		return printngMService.deletePrintngM(vo);
	}

	@RequestMapping(value = "getRdDownload.lims")
	public void getRdDownload(
			@RequestParam(value="printngSeqno", required=true) String printngSeqno
			, @RequestParam(value="histVer", required=true) String histVer
			, HttpServletResponse response) {
		printngMService.getRdDownload(printngSeqno, histVer, response);
	}

}
