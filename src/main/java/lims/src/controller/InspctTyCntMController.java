package lims.src.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.src.service.InspctTyCntMService;
import lims.src.vo.InspctTyCntMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/src")
public class InspctTyCntMController {
	
	@Autowired
	private InspctTyCntMService inspctTyCntMServiceImpl;

	@SetLocale
	@RequestMapping(value="InspctTyCntM.lims")
	public String InspctTyCntM(Model model) {
		return "src/InspctTyCntM";
	}
	
	@RequestMapping(value="getReqCntByInspctTyAndMnth.lims")
	public @ResponseBody List<InspctTyCntMVo> getReqCntByInspctTyAndMnth(@RequestBody InspctTyCntMVo vo) {
		return inspctTyCntMServiceImpl.getReqCntByInspctTyAndMnth(vo);
	}
	
}
