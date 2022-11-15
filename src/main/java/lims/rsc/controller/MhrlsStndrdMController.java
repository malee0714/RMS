package lims.rsc.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.service.MhrlsStndrdMService;
import lims.rsc.vo.MhrlsStndrdMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/reg")
public class MhrlsStndrdMController {
	
	@Resource(name="mhrlsStndrdMServiceImpl")
	private MhrlsStndrdMService mhrlsStndrdMService;
	
	@SetLocale
	@RequestMapping(value="MhrlsStndrdM.lims")
	public String MhrlsStndrdM(Model model){
		return "rsc/MhrlsStndrdM";
	}
	
	@RequestMapping(value="getMhrlsStndrdUseMList.lims")
	public @ResponseBody List<MhrlsStndrdMVo> getMhrlsStndrdUseMList(@RequestBody MhrlsStndrdMVo vo){
		return mhrlsStndrdMService.getMhrlsStndrdUseMList(vo);
	}
	
	@RequestMapping(value="instMhrlsStndrdUseM.lims")
	public @ResponseBody int instMhrlsStndrdUseM(@RequestBody MhrlsStndrdMVo vo){
		return mhrlsStndrdMService.instMhrlsStndrdUseM(vo);
	}
}
