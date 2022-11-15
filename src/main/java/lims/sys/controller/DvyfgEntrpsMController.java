package lims.sys.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.sys.service.DvyfgEntrpsMService;
import lims.sys.vo.DvyfgEntrpsMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value = "/sys")
public class DvyfgEntrpsMController {
	
	@Resource(name = "DvyfgEntrpsMService")
	private DvyfgEntrpsMService dvyfgEntrpsMService;
	
	/**
	 * 납품업체
	 * @param model
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "/DvyfgEntrpsM.lims")
	public String DvyfgEntrpsM(Model model){
		return "/sys/DvyfgEntrpsM";
	}
	
	/**
	 * 납품 업체 목록 정보 저장
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/saveDvyfgEntrpsM.lims")
	public @ResponseBody int saveDvyfgEntrpsM(@RequestBody DvyfgEntrpsMVo vo){
		return dvyfgEntrpsMService.saveDvyfgEntrpsM(vo);
	}
	
	/**
	 * 납품 업체 정보 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getDvyfgEntrpsM.lims")
	public @ResponseBody List<DvyfgEntrpsMVo> getDvyfgEntrpsM(@RequestBody DvyfgEntrpsMVo vo){
		return dvyfgEntrpsMService.getDvyfgEntrpsM(vo);
	}
	
	@RequestMapping(value = "/uploadDvyfgEntrpsExcel.lims")
	public @ResponseBody HashMap<String, Object> uploadDvyfgEntrpsExcel(MultipartHttpServletRequest request) throws Exception{		
		return dvyfgEntrpsMService.uploadDvyfgEntrpsExcel(request);
		
	}
}
