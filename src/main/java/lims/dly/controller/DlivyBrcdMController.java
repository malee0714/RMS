package lims.dly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.dly.service.DlivyBrcdMService;
import lims.dly.vo.DlivyMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value = "/dly")
public class DlivyBrcdMController {

	@Resource(name = "DlivyBrcdMService")
	private DlivyBrcdMService dlivyBrcdMService;
	
	@SetLocale()
	@RequestMapping(value = "/DlivyBrcdM.lims")
	public String dlivyBrcdM(Model model){
		return "dly/DlivyBrcdM";
	}
	
	/**
	 * 바코드 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getBarcodeList.lims")
	public @ResponseBody List<DlivyMVo> getBarcodeList(@RequestBody DlivyMVo vo){
		return dlivyBrcdMService.getBarcodeList(vo);
	}

	
	/**
	 * 바코드 상세 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getBarcodeDetailList.lims")
	public @ResponseBody List<DlivyMVo> getBarcodeDetailList(@RequestBody DlivyMVo vo){
		return dlivyBrcdMService.getBarcodeDetailList(vo);
	}
	
	/**
	 * 바코드 엑셀 출력 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getBarcodePrintList.lims")
	public @ResponseBody List<DlivyMVo> getBarcodePrintList(@RequestBody DlivyMVo vo){
		return dlivyBrcdMService.getBarcodePrintList(vo);
	}
	
	/**
	 * 물류양식 엑셀 출력 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getBarcodePrintList3.lims")
	public @ResponseBody List<DlivyMVo> getBarcodePrintList3(@RequestBody DlivyMVo vo){
		return dlivyBrcdMService.getBarcodePrintList3(vo);
	}
	
	/**
	 * 품질양식 엑셀 출력 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getBarcodePrintList4.lims")
	public @ResponseBody List<DlivyMVo> getBarcodePrintList4(@RequestBody DlivyMVo vo){
		return dlivyBrcdMService.getBarcodePrintList4(vo);
	}
	
	/**
	 * 바코드 정보 삭제
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/insDeleteBarcd.lims")
	public @ResponseBody int insDeleteBarcd(@RequestBody DlivyMVo vo){
		return dlivyBrcdMService.insDeleteBarcd(vo);
	}
	
	
}
