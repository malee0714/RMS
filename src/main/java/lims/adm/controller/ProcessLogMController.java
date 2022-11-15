package lims.adm.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.adm.service.LoginLogMService;
import lims.adm.service.ProcessLogMService;
import lims.adm.vo.ProcessLogMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/adm")
public class ProcessLogMController {
	
	
	@Resource(name="processLogMServiceImpl")
	private ProcessLogMService processLogMService;
	
	@SetLocale()
	@RequestMapping("/ProcessLogM.lims")
	public String ProcessLogM(Model model){
		return "adm/ProcessLogM";
	}
	
	@RequestMapping("/getProcessLogListM.lims")
	public @ResponseBody List<ProcessLogMVo> getProcessLogMList(@RequestBody ProcessLogMVo ProcessLogMVo, HttpServletRequest request){
		return processLogMService.getProcessLogMList(ProcessLogMVo);
	}
	
	
}
