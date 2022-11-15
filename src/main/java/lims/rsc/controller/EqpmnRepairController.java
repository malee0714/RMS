package lims.rsc.controller;

import lims.rsc.service.EqpmnRepairService;
import lims.rsc.vo.EqpmnRepairDto;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Slf4j
@Controller
@RequestMapping("/rsc")
public class EqpmnRepairController {
	
	private final EqpmnRepairService eqpmnRepairService;

	@Autowired
	public EqpmnRepairController(EqpmnRepairService eqpmnRepairServiceImpl) {
		this.eqpmnRepairService = eqpmnRepairServiceImpl;
	}

	@SetLocale()
	@RequestMapping(value = "EqpmnRepair.lims")
	public String EqpmnRepairM(Model model) {
		return "/rsc/EqpmnRepair";
	}

	@RequestMapping(value = "getEqpRepairHist.lims")
	@ResponseBody
	public List<EqpmnRepairDto> getEqpRepairHist(@RequestBody EqpmnRepairDto eqpmnRepairDto) {
		try {
			return eqpmnRepairService.getEqpRepairHist(eqpmnRepairDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnRepairDto, "수리이력 조회에 실패하였습니다.");
		}
	}

	@RequestMapping(value = "saveEqpRepairHist.lims")
	@ResponseBody
	public int saveEqpRepairHist(@RequestBody EqpmnRepairDto eqpmnRepairDto) {
		try {
			return eqpmnRepairService.saveEqpRepairHist(eqpmnRepairDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnRepairDto, "수리이력 저장에 실패하였습니다.");
		}
	}

}
