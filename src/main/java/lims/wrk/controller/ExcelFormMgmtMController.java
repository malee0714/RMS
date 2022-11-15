package lims.wrk.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import lims.wrk.service.ExcelFormMgmtMService;
import lims.wrk.vo.ExcelFormMgmtMVo;

@Controller
@RequestMapping(value ="/wrk")
public class ExcelFormMgmtMController {

	@Resource(name = "excelFormMgmtMServiceImpl")
	private ExcelFormMgmtMService excelFormMgmtMService;

	@SetLocale()
	@RequestMapping(value = "ExcelFormMgmtM.lims")
	public String ExcelFormMgmt(HttpServletRequest reqest, Model model) {
		return "wrk/ExcelFormMgmtM";
	}

	@RequestMapping(value = "/getExcelForm.lims")
	public @ResponseBody List<ExcelFormMgmtMVo> getExcelForm(@RequestBody ExcelFormMgmtMVo vo){
		return excelFormMgmtMService.getExcelForm(vo);
	}

	@RequestMapping(value = "/getExcelInfo.lims")
	public @ResponseBody List<ExcelFormMgmtMVo> getExcelInfo(@RequestBody ExcelFormMgmtMVo vo){
		return excelFormMgmtMService.getExcelInfo(vo);
	}

	@RequestMapping(value = "exUpload.lims")
	public @ResponseBody int exUpload(MultipartHttpServletRequest request) throws Exception {
		return excelFormMgmtMService.exUpload(request);
	}

	@RequestMapping(value = "getExDownload.lims")
	public void getExDownload(@RequestParam(value="params", required=false) String excelSeqno, HttpServletResponse response){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("excelSeqno", excelSeqno);
		excelFormMgmtMService.getExDownload(param, response);
	}

	@RequestMapping(value ="/delCelForm")
	public @ResponseBody int delCelForm(@RequestBody List<ExcelFormMgmtMVo> list) {
		return excelFormMgmtMService.delCelForm(list);
	}

}
