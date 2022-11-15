package lims.rsc.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.service.CheckMService;
import lims.rsc.vo.CheckMVo;

@Controller
@RequestMapping(value="/reg")
public class CheckMController {
	
	@Resource(name = "checkMServiceImpl")
	private CheckMService checkMService;
	
	@RequestMapping(value = "CheckM.lims")
	public String checkM(Model model, HttpServletRequest request) {
		return "rsc/CheckM";
	}
	
	// 검수 그리드 리스트 조회
	@RequestMapping(value = "getCheckMList.lims" )
	public @ResponseBody List<CheckMVo> getCheckMList(@RequestBody CheckMVo vo, Model model) {
		List<CheckMVo> result = checkMService.getCheckMList(vo);
		return result;
	}

	// 검수 목록 그리드 리스트 조회
	@RequestMapping(value = "getCheckDetailMList.lims" )
	public @ResponseBody List<CheckMVo> getCheckDetailMList(@RequestBody CheckMVo vo, Model model) {
		List<CheckMVo> result = checkMService.getCheckDetailMList(vo);
		return result;
	}
	
	// 저장
	@RequestMapping(value = "saveCheckDetailMList.lims" )
	public @ResponseBody HashMap<String,Object> saveCheckDetailMList(@RequestBody List<CheckMVo> vo){
		HashMap<String,Object> result = checkMService.saveCheckDetailMList(vo);
		
		//바코드 확인
		System.out.println(">>> CONTROLLER 바코드 확인: " + result);
		
		return result;
	}

}
