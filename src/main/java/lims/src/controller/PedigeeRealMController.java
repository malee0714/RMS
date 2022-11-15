package lims.src.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.src.service.PedigeeMService;
import lims.src.service.PedigeeRealMService;
import lims.src.vo.PedigeeMVo;
import lims.test.vo.IssueMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/src")
public class PedigeeRealMController {

	@Resource(name="pedigeeRealMServiceImpl")
	private PedigeeRealMService pedigeeRealMService;
	
	@SetLocale
	@RequestMapping(value="PedigeeRealM.lims")
	public String PedigeeM(Model model){
		return"src/PedigeeRealM";
	}

	@RequestMapping(value="getUpperReqestPedigee.lims")
	public @ResponseBody List<PedigeeMVo> getUpperReqestPedigee(@RequestBody PedigeeMVo vo){
		return pedigeeRealMService.getUpperReqestPedigee(vo);
	}
}
