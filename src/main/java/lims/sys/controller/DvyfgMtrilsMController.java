package lims.sys.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.service.DvyfgMtrilsMService;
import lims.sys.vo.DvyfgEntrpsMVo;
import lims.sys.vo.DvyfgMtrilsMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value = "/sys")
public class DvyfgMtrilsMController {

	@Resource(name = "DvyfgMtrilsMService")
	private DvyfgMtrilsMService dvyfgMtrilsMService;
	
	/**
	 * 납품업체 제품정보 관리
	 * @param model
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "/DvyfgMtrilsM.lims")
	public String DvyfgEntrpsM(Model model){
		return "/sys/DvyfgMtrilsM";
	}
	
	
	/**
	 * 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getDvyfgMtrils.lims")
	public @ResponseBody List<DvyfgMtrilsMVo> getDvyfgMtrils(@RequestBody DvyfgMtrilsMVo vo){
		return dvyfgMtrilsMService.getDvyfgMtrils(vo);
	}
	
	/**
	 * 저장
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/saveDvyfgMtrils.lims")
	public @ResponseBody int saveDvyfgMtrils(@RequestBody DvyfgMtrilsMVo vo){
		return dvyfgMtrilsMService.saveDvyfgMtrils(vo);
	}
}
