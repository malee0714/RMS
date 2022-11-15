package lims.src.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.src.service.MhrlsDeptOprMService;
import lims.src.vo.MhrlsDeptOprMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value ="/src")
public class MhrlsDeptOprMController {
	@Resource(name = "mhrlsDeptOprMServiceImpl")
	private MhrlsDeptOprMService mhrlsDeptOprMService;
	
	@SetLocale
	@RequestMapping(value="MhrlsDeptOprM.lims")
	public String MhrlsDeptOprM(Model model){
		return "src/MhrlsDeptOprM";
	}
	
	// 조회
	@RequestMapping(value = "/getmhrlsDeptOprList.lims")
	public @ResponseBody List<MhrlsDeptOprMVo> getmhrlsDeptOprList(@RequestBody  MhrlsDeptOprMVo vo){
		return mhrlsDeptOprMService.getmhrlsDeptOprList(vo);
	}

	
}
