package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.util.Locale.SetLocale;
import lims.wrk.service.SanctnLineMService;
import lims.wrk.vo.SanctnLineMVo;

@Controller
@RequestMapping("/wrk")
public class SanctnLineMController {

	@Resource(name = "sanctnLineMServiceImpl")
	private SanctnLineMService sanctnLineMService;

	@SetLocale()
	@RequestMapping(value = "SanctnLineM.lims")
	public String SanctnLineM(HttpServletRequest request, Model model) {
		return "wrk/SanctnLineM";
	}

	@RequestMapping(value = "getSanctnKndList.lims")
	public @ResponseBody List<SanctnLineMVo> getSanctnKndList(@RequestBody SanctnLineMVo vo, Model model) {
		return sanctnLineMService.getSanctnKndList();
	}

	@RequestMapping(value = "getUserNtncList.lims")
	public @ResponseBody List<SanctnLineMVo> getUserNtncList(@RequestBody SanctnLineMVo vo, Model model) {
		return sanctnLineMService.getUserNtncList(vo);
	}

	@RequestMapping("/getSanctnLineList")
	public @ResponseBody List<SanctnLineMVo> getSanctnLineList(@RequestBody SanctnLineMVo vo, HttpServletRequest request){
		return sanctnLineMService.getSanctnLineList(vo);
	}


	@RequestMapping("/getUserAList")
	public @ResponseBody List<SanctnLineMVo> getUserAList(@RequestBody SanctnLineMVo vo, HttpServletRequest request){
		return sanctnLineMService.getUserAList(vo);
	}

	@RequestMapping("/getSanctnerList")
	public @ResponseBody List<SanctnLineMVo> getSanctnerList(@RequestBody SanctnLineMVo vo, HttpServletRequest request){
		return sanctnLineMService.getSanctnerList(vo);
	}

	@RequestMapping("/saveSanctnLine")
	public @ResponseBody int saveSanctnLine(@RequestBody SanctnLineMVo vo){
		return sanctnLineMService.saveSanctnLine(vo);
	}
}
