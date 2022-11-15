package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;

import lims.wrk.vo.PrductMVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.util.Locale.SetLocale;
import lims.wrk.service.CalcLawMService;
import lims.wrk.vo.CalcLawMVo;

@Controller
@RequestMapping("/wrk")
public class CalcLawMController {

	@Resource(name = "calcLawMServiceImpl")
	private CalcLawMService calcLawMService;

	@SetLocale()
	@RequestMapping(value = "CalcLawM.lims" )
	public String test(Model model) {
		return "wrk/CalcLawM";
	}

	@RequestMapping(value = "getCalcLawMList.lims")
	public @ResponseBody List<CalcLawMVo> getCalcLawMList(@RequestBody CalcLawMVo vo){
		return calcLawMService.getCalcLawMList(vo);
	}

	@RequestMapping(value = "getCalcNomfrm.lims" )
	public @ResponseBody List<CalcLawMVo> getCalcNomfrm(@RequestBody CalcLawMVo vo) {
		return calcLawMService.getCalcNomfrm(vo);
	}

	@RequestMapping(value = "saveExprMthExpriemM.lims" )
	public @ResponseBody String saveExprMthExpriemM(@RequestBody CalcLawMVo vo) {
		return calcLawMService.saveExprMthCalc(vo);
	}

	@RequestMapping(value = "delCalcLawInfo.lims")
	public @ResponseBody int delCalcLawInfo(@RequestBody CalcLawMVo vo) {
		return calcLawMService.delCalcLawInfo(vo);
	}

	@RequestMapping(value = "chkCalcInfo.lims")
	public @ResponseBody int chkCalcInfo(@RequestBody CalcLawMVo vo) {
		return calcLawMService.chkCalcInfo(vo);
	}

	@RequestMapping(value = "getMtrilPopList.lims")
	public @ResponseBody List<PrductMVo> getMtrilPopList(@RequestBody PrductMVo vo) {
		return calcLawMService.getMtrilPopList(vo);
	}

	@RequestMapping(value = "getCLMtrilExpriemList.lims")
	public @ResponseBody List<CalcLawMVo> getCLMtrilExpriemList(@RequestBody CalcLawMVo vo) {
		return calcLawMService.getCLMtrilExpriemList(vo);
	}
	
	//계산식 콤보만들기
	@RequestMapping(value = "getCalcLawCombo.lims")
	public @ResponseBody List<CalcLawMVo> getCalcLawCombo(@RequestBody CalcLawMVo vo) {
		return calcLawMService.getCalcLawCombo(vo);
	}
	
	//계산식 마스터 데이터 조회하기
	@RequestMapping(value = "getCalcMasterInfo.lims")
	public @ResponseBody CalcLawMVo getCalcMasterInfo(@RequestBody CalcLawMVo vo) {
		return calcLawMService.getCalcMasterInfo(vo);
	}
}
