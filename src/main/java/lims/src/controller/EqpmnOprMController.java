package lims.src.controller;

import lims.src.service.EqpmnOprMService;
import lims.src.vo.EqpmnOprManageDto;
import lims.util.Locale.SetLocale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/src")
public class EqpmnOprMController {

	private final EqpmnOprMService eqpmnOprMService;

	@Autowired
	public EqpmnOprMController(EqpmnOprMService eqpmnOprMServiceImpl) {
		this.eqpmnOprMService = eqpmnOprMServiceImpl;
	}

	@SetLocale
	@RequestMapping(value = "EqpmnOprM.lims")
	public String EqpmnOprM(Model model) {
		return "src/EqpmnOprM";
	}
	
	@RequestMapping(value = "getParMonTU.lims ")
	@ResponseBody
	public List<EqpmnOprManageDto> getParMonTU(@RequestBody EqpmnOprManageDto eqpmnOprManageDto) {
		return eqpmnOprMService.getParMonTU(eqpmnOprManageDto);
	}

}
