package lims.sys.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.service.SchdulMService;
import lims.sys.vo.SchdulMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/sys")
public class SchdulMController {
	
	@Resource(name="schdulMServiceImpl")
	private SchdulMService schdulMService;
	
	@SetLocale()
	@RequestMapping(value="SchdulM.lims")
	public String SchdulM(Model model,HttpServletRequest request){
		return "sys/SchdulM"; 
	}
	
	@RequestMapping(value="getSchdulMList.lims")
	public @ResponseBody List<SchdulMVo> getSchdulMList(@RequestBody SchdulMVo vo){
		return schdulMService.getSchdulMList(vo);
	}
	
	@RequestMapping(value="getSchdulUserList.lims")
	public @ResponseBody List<SchdulMVo> getSchdulUserList(@RequestBody SchdulMVo vo){
		return schdulMService.getSchdulUserList(vo);
	}
	
	@RequestMapping(value="saveSchdulInfo.lims")
	public @ResponseBody int saveSchdulInfo(@RequestBody SchdulMVo vo){
		return schdulMService.saveSchdulInfo(vo); 
	}
	
	@RequestMapping(value="delSchdule.lims")
	public @ResponseBody int delSchdule(@RequestBody SchdulMVo vo){
		return schdulMService.delSchdule(vo); 
	}
}
