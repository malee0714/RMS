package lims.rsc.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.standard.Sides;
import javax.servlet.http.HttpServletRequest;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.service.QualfResultMService;
import lims.rsc.vo.PurchsRequestFixMVo;
import lims.rsc.vo.QualfStdrMVo;
import lims.rsc.vo.QualfResultMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;
import net.sf.json.JSONObject;



@Controller
@RequestMapping(value = "/rsc")
public class QualfResultMController {
	
	
	
	@Resource(name = "qualfResultMServiceImpl")
	private QualfResultMService qualfResultMService;
	
	@SetLocale()
	@RequestMapping(value = "QualfResultM.lims")
	public String CanM(HttpServletRequest request, Model model) {
		return "rsc/QualfResultM";
	}
	
	// 조회
	@RequestMapping(value = "/getQualfStdrReg.lims")
	public @ResponseBody List<QualfResultMVo> getQualfStdrReg(@RequestBody QualfResultMVo vo) throws PrintException, IOException{
		 
		return qualfResultMService.getQualfStdrReg(vo);
	}
	// 팝업조회
	@RequestMapping(value = "/getQualfRec.lims")
	public @ResponseBody List<QualfResultMVo> getQualfRec(@RequestBody QualfResultMVo vo) throws PrintException, IOException{
		 
		return qualfResultMService.getQualfRec(vo);
	}
	// 조회
	@RequestMapping(value = "/getQualfElgblList.lims")
	public @ResponseBody List<QualfResultMVo> getQualfElgblList(@RequestBody QualfResultMVo vo){
		return qualfResultMService.getQualfElgblList(vo);
	}
	// tab2조회
	@RequestMapping(value = "/getSkill.lims")
	public @ResponseBody List<QualfResultMVo> getSkill(@RequestBody QualfResultMVo vo){
		return qualfResultMService.getSkill(vo);
	}
	@RequestMapping(value = "/getAbility.lims")
	public @ResponseBody List<QualfResultMVo> getAbility(@RequestBody QualfResultMVo vo){
		return qualfResultMService.getAbility(vo);
	}
	@RequestMapping(value = "/getQualfList.lims")
	public @ResponseBody List<QualfResultMVo> getQualfList(@RequestBody QualfResultMVo vo){
		return qualfResultMService.getQualfList(vo);
	}
	@RequestMapping(value = "/getElgblList.lims")
	public @ResponseBody List<QualfResultMVo> getElgblList(@RequestBody QualfResultMVo vo){
		return qualfResultMService.getElgblList(vo);
	}
	
	// 저장
	@RequestMapping(value = "/saveQualfResult.lims")
	public @ResponseBody int saveQualfResult(@RequestBody QualfResultMVo vo) {
		return qualfResultMService.saveQualfResult(vo);
	}

	// 저장
	@RequestMapping(value = "/updQualfResult.lims")
	public @ResponseBody int updQualfResult(@RequestBody QualfResultMVo vo) {
		return qualfResultMService.updQualfResult(vo);
	}

}
