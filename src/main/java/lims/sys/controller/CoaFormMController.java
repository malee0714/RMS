package lims.sys.controller;

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

import lims.sys.service.CoaFormMService;
import lims.sys.vo.CoaFormMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value = "/wrk")
public class CoaFormMController {

	@Resource(name = "coaFormMServiceImpl")
	private CoaFormMService coaFormMService;

	@SetLocale()
	@RequestMapping(value = "CoaFormM.lims")
	public String CoaFormM(HttpServletRequest request, Model model) {
		return "sys/CoaFormM";
	}

	@RequestMapping(value = "getCoaFormMList.lims")
	public @ResponseBody List<CoaFormMVo> getCoaFormMList(@RequestBody CoaFormMVo vo, Model model){
		return coaFormMService.getCoaFormMList(vo);
	}

	@RequestMapping(value = "saveCoaFormM.lims")
	public @ResponseBody int saveCoaFormM(MultipartHttpServletRequest request){
		return coaFormMService.saveCoaFormM(request);
	}

	@RequestMapping(value = "deleteCoaFormM.lims")
	public @ResponseBody int deleteCoaFormM(@RequestBody CoaFormMVo vo){
		return coaFormMService.deleteCoaFormM(vo);
	}

	@RequestMapping(value = "getCoaDownload.lims")
	public void getCoaDownload(
			@RequestParam(value="printngSeqno", required=true) String printngSeqno
			, @RequestParam(value="histVer", required=true) String histVer
			, HttpServletResponse response) {
		coaFormMService.getCoaDownload(printngSeqno, histVer, response);
	}

}