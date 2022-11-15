package lims.dly.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.com.service.CommonService;
import lims.dly.service.DlivyBrcdValidMService;
import lims.dly.vo.DlivyMVo;
import lims.sys.vo.InsttMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value = "/dly")
public class DlivyBrcdValidMController {
	
	@Resource(name = "DlivyBrcdValidMService")
	private DlivyBrcdValidMService dlivyBrcdValidMService;
	
	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	/**
	 * 바코드 검증
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "DlivyBrcdValidM.lims")
	public String DlivyBrcdValidM(HttpServletRequest request, Model model){
		return "dly/DlivyBrcdValidM";
	}
	
	/**
	 * 로그인없이 바코드 검증
	 * @param request
	 * @param model
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "/brcdValidM.lims")	
	public String brcdValidM(HttpServletRequest request, Model model){
		return "brcdValid";
	}
	
	// 사용자 목록 (콤보)
	@RequestMapping(value = "/getDeptCombo.lims" )
	public @ResponseBody List<InsttMVo> getDeptCombo(@RequestBody InsttMVo vo, Model model) {
		List<InsttMVo> result = commonService.getDeptCombo(vo);		
		return result;
	}
		
	/**
	 * 바코드 검증 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getBrcdVal.lims")
	public @ResponseBody HashMap<String, Object> getBrcdVal(@RequestBody DlivyMVo vo){
		HashMap<String, Object> result = dlivyBrcdValidMService.getBrcdVal(vo);		
		return 	result;
	}
}
