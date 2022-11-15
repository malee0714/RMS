package lims.src.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.src.service.PedigeeMService;
import lims.src.vo.PedigeeMVo;
import lims.test.vo.IssueMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/src")
public class PedigeeMController {

	@Resource(name="pedigeeMServiceImpl")
	private PedigeeMService pedigeeMService;
	
	@SetLocale
	@RequestMapping(value="PedigeeM.lims")
	public String PedigeeM(Model model){
		return"src/PedigeeM";
	}
	
	@SetLocale
	@RequestMapping(value="PedigeeP01.lims")
	public String PedigeeP01(Model model){
		return"src/PedigeeP01";
	}
	
	@RequestMapping(value="getUpperPrduct.lims")
	public @ResponseBody List<PedigeeMVo> getUpperPrduct(@RequestBody PedigeeMVo vo){
		return pedigeeMService.getUpperPrduct(vo);
	}
	
	@RequestMapping(value="getReqestPrductList.lims")
	public @ResponseBody List<PedigeeMVo> getReqestPrductList(@RequestBody PedigeeMVo vo){
		return pedigeeMService.getReqestPrductList(vo);
	}
	
	@RequestMapping(value="getReqestIssueList.lims")
	public @ResponseBody List<IssueMVo> getReqestPrductList(@RequestBody IssueMVo vo){
		return pedigeeMService.getReqestIssueList(vo);
	}
}
