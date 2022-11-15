package lims.rsc.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.service.QualfStdrMService;
import lims.rsc.vo.QualfStdrMVo;
import lims.util.Locale.SetLocale;
	


@Controller
@RequestMapping("/rsc")
public class QualfStdrMController {
	
	
	@Resource(name = "qualfStdrMServiceImpl")
	private QualfStdrMService qualfStdrMService;
	
	@SetLocale()
	@RequestMapping(value = "QualfStdrM.lims")
	public String CanM(HttpServletRequest request, Model model) {
		return "rsc/QualfStdrM";
	}

	// 조회
	@RequestMapping(value = "/getQualfStdr.lims")
	public @ResponseBody List<QualfStdrMVo> getQualfStdr(@RequestBody QualfStdrMVo vo){
		return qualfStdrMService.getQualfStdr(vo);
	}
	// 조회
	@RequestMapping(value = "/getScoreList.lims")
	public @ResponseBody List<QualfStdrMVo> getScoreList(@RequestBody QualfStdrMVo vo){
		return qualfStdrMService.getScoreList(vo);
	}
	// 조회
	@RequestMapping(value = "/getBaseLineList.lims")
	public @ResponseBody List<QualfStdrMVo> getBaseLineList(@RequestBody QualfStdrMVo vo){
		return qualfStdrMService.getBaseLineList(vo);
	}
	
	
	// 저장
	@RequestMapping(value = "/saveQualfStdr.lims")
	public @ResponseBody int saveQualfStdr(@RequestBody QualfStdrMVo vo) {
		return qualfStdrMService.saveQualfStdr(vo);
	}
	
	//삭제
	@RequestMapping(value = "/delQualfStdr.lims")
	public @ResponseBody int delQualfStdr(@RequestBody QualfStdrMVo vo) {
		return qualfStdrMService.delQualfStdr(vo);
	}

	
}
