package lims.adm.controller;

import lims.adm.service.ErrorLogMService;
import lims.adm.vo.ErrorLogMVo;
import lims.util.Locale.SetLocale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/adm")
public class ErrorLogMController {

	private final ErrorLogMService errorLogMService;

	@Autowired
	public ErrorLogMController(ErrorLogMService errorLogMServiceImpl) {
		this.errorLogMService = errorLogMServiceImpl;
	}

	@SetLocale()
	@RequestMapping("/ErrorLogM.lims")
	public String ErrorLogM(HttpServletRequest request, Model model){
		return "adm/ErrorLogM";
	}
	
	// 조회
	@RequestMapping(value = "/getErrorLog.lims")
	public @ResponseBody List<ErrorLogMVo> getErrorLog(@RequestBody ErrorLogMVo vo){
		return errorLogMService.getErrorLog(vo);
	}
	

	
}
