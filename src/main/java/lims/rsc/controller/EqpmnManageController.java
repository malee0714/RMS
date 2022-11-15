package lims.rsc.controller;

import lims.rsc.service.EqpmnManageService;
import lims.rsc.vo.EqpmnManageDto;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Slf4j
@Controller
@RequestMapping("/rsc")
public class EqpmnManageController {

	private final EqpmnManageService eqpmnManageService;

	@Autowired
	public EqpmnManageController(EqpmnManageService eqpmnManageServiceImpl) {
		this.eqpmnManageService = eqpmnManageServiceImpl;
	}

	@Value("${file.upload.path}")
	private String fileUploadPath;

	@SetLocale()
	@RequestMapping(value = "EqpmnM.lims")
	public String EqpmnM(Model model) {
		model.addAttribute("filePath", fileUploadPath.replaceAll("\\\\", "\\\\\\\\"));
		return "rsc/EqpmnM";
	}

	@RequestMapping(value = "getEqpmnMList.lims")
	@ResponseBody
	public List<EqpmnManageDto> getEqpmnMList(@RequestBody EqpmnManageDto eqpmnManageDto) {
		try {
			return eqpmnManageService.getEqpmnMList(eqpmnManageDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnManageDto, "장비목록이 정상적으로 조회되지 않았습니다.");
		}
	}

	@RequestMapping(value = "insEqpmn.lims")
	@ResponseBody
	public int insEqpmn(@RequestBody EqpmnManageDto list) {
		try {
			return eqpmnManageService.insEqpmn(list);
		} catch (Exception e) {
			throw new CustomException(e, list, "장비정보가 정상적으로 등록되지 않았습니다.");
		}
	}

	@RequestMapping(value = "updEqpmn.lims")
	@ResponseBody
	public int updEqpmn(@RequestBody EqpmnManageDto list) {
		try {
			return eqpmnManageService.updEqpmn(list);
		} catch (Exception e) {
			throw new CustomException(e, list, "장비정보가 정상적으로 수정되지 않았습니다.");
		}
	}

	@RequestMapping(value = "getAnalsMtrilList.lims")
	@ResponseBody
	public List<EqpmnManageDto> getAnalsMtrilList(@RequestBody EqpmnManageDto eqpmnManageDto) {
		try {
			return eqpmnManageService.getAnalsMtrilList(eqpmnManageDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnManageDto, "관련제품이 정상적으로 조회되지 않았습니다.");
		}
	}

	@RequestMapping(value = "delAnalsMtril.lims")
	@ResponseBody
	public int delAnalsMtril(@RequestBody List<EqpmnManageDto> list) {
		try {
			return eqpmnManageService.delAnalsMtril(list);
		} catch (Exception e) {
			throw new CustomException(e, list, "관련제품이 정상적으로 삭제되지 않았습니다.");
		}
	}
	
	@RequestMapping(value = "getAnalsItemList.lims")
	@ResponseBody
	public List<EqpmnManageDto> getAnalsItemList(@RequestBody EqpmnManageDto eqpmnManageDto) {
		try {
			return eqpmnManageService.getAnalsItemList(eqpmnManageDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnManageDto, "관련시험항목이 정상적으로 조회되지 않았습니다.");
		}
	}

	@RequestMapping(value = "delAnalsItem.lims")
	@ResponseBody
	public int delAnalsItem(@RequestBody List<EqpmnManageDto> list) {
		try {
			return eqpmnManageService.delAnalsItem(list);
		} catch (Exception e) {
			throw new CustomException(e, list, "관련시험항목이 정상적으로 삭제되지 않았습니다.");
		}
	}
	
	@RequestMapping(value = "getCrrctCycleList.lims")
	@ResponseBody
	public List<EqpmnManageDto> getCrrctCycleList(@RequestBody EqpmnManageDto eqpmnManageDto) {
		try {
			return eqpmnManageService.getCrrctCycleList(eqpmnManageDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnManageDto, "검교정주기정보가 정상적으로 조회되지 않았습니다.");
		}
	}

	@RequestMapping(value = "delCrrctCycle.lims")
	@ResponseBody
	public int delCrrctCycle(@RequestBody List<EqpmnManageDto> list) {
		try {
			return eqpmnManageService.delCrrctCycle(list);
		} catch (Exception e) {
			throw new CustomException(e, list, "검교정주기정보가 정상적으로 삭제되지 않았습니다.");
		}
	}

	@RequestMapping(value = "getEqpmnChckExpr.lims")
	@ResponseBody
	public List<EqpmnManageDto> getEqpmnChckExpr(@RequestBody EqpmnManageDto eqpmnManageDto) {
		try {
			return eqpmnManageService.getEqpmnChckExpr(eqpmnManageDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnManageDto, "일상점검시험항목이 정상적으로 조회되지 않았습니다.");
		}
	}

	@RequestMapping(value = "delChckExpr.lims")
	@ResponseBody
	public int delChckExpr(@RequestBody List<EqpmnManageDto> list) {
		try {
			return eqpmnManageService.delChckExpr(list);
		} catch (Exception e) {
			throw new CustomException(e, list, "일상점검시험항목이 정상적으로 삭제되지 않았습니다.");
		}
	}
}
