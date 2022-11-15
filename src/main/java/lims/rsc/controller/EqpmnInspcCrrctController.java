package lims.rsc.controller;

import lims.rsc.service.EqpmnInspcCrrctService;
import lims.rsc.vo.EqpmnInspcCrrctDto;
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
public class EqpmnInspcCrrctController {

	private final EqpmnInspcCrrctService eqpmnInspcCrrctService;

	@Autowired
	public EqpmnInspcCrrctController(EqpmnInspcCrrctService eqpmnInspcCrrctServiceImpl) {
		this.eqpmnInspcCrrctService = eqpmnInspcCrrctServiceImpl;
	}

	@SetLocale()
	@RequestMapping(value = "EqpmnInspcCrrct.lims")
	public String EqpmnInspcCrrct(Model model) {
		return "rsc/EqpmnInspcCrrct";
	}

	@RequestMapping(value = "getEqpmnInspctList.lims")
	@ResponseBody
	public List<EqpmnInspcCrrctDto> getEqpmnInspctList(@RequestBody EqpmnInspcCrrctDto eqpmnInspcCrrctDto) {
		try {
			return eqpmnInspcCrrctService.getEqpmnInspctList(eqpmnInspcCrrctDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnInspcCrrctDto, "검교정목록 조회에 실패하였습니다.");
		}
	}

	@RequestMapping(value = "chkExistAtInspctCycle.lims")
	@ResponseBody
	public EqpmnInspcCrrctDto chkExistAtInspctCycle(@RequestBody EqpmnInspcCrrctDto eqpmnInspcCrrctDto) {
		try {
			return eqpmnInspcCrrctService.chkExistAtInspctCycle(eqpmnInspcCrrctDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnInspcCrrctDto, "검교정주기정보 유무 검증에 실패하였습니다.");
		}
	}

	@RequestMapping(value = "saveEqpmnInspctCrrct.lims")
	@ResponseBody
	public int saveEqpmnInspctCrrct(@RequestBody EqpmnInspcCrrctDto eqpmnInspcCrrctDto) {
		try {
			return eqpmnInspcCrrctService.saveEqpmnInspctCrrct(eqpmnInspcCrrctDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnInspcCrrctDto, "검교정정보 등록에 실패하였습니다.");
		}
	}
	
	@RequestMapping(value = "chkDuplicateInspctDte.lims")
	@ResponseBody
	public int chkDuplicateInspctDte(@RequestBody EqpmnInspcCrrctDto eqpmnInspcCrrctDto) {
		try {
			return eqpmnInspcCrrctService.chkDuplicateInspctDte(eqpmnInspcCrrctDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnInspcCrrctDto, "검교정일자 중복 검증에 실패하였습니다.");
		}
	}

	@RequestMapping(value = "getEqpInspctCrrctReq.lims")
	@ResponseBody
	public List<EqpmnInspcCrrctDto> getEqpInspctCrrctReq(@RequestBody EqpmnInspcCrrctDto eqpmnInspcCrrctDto) {
		try {
			return eqpmnInspcCrrctService.getEqpInspctCrrctReq(eqpmnInspcCrrctDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnInspcCrrctDto, "검교정 의뢰목록 조회에 실패하였습니다.");
		}
	}

	@RequestMapping(value = "getEqpInspctCrrctReqExpr.lims")
	@ResponseBody
	public List<EqpmnInspcCrrctDto> getEqpInspctCrrctReqExpr(@RequestBody List<Integer> list) {
		try {
			return eqpmnInspcCrrctService.getEqpInspctCrrctReqExpr(list);
		} catch (Exception e) {
			throw new CustomException(e, list, "의뢰 시험항목 조회에 실패하였습니다.");
		}
	}

	@RequestMapping(value = "delEqpInspctCrrctReq.lims")
	@ResponseBody
	public int delEqpInspctCrrctReq(@RequestBody List<EqpmnInspcCrrctDto> list) {
		try {
			return eqpmnInspcCrrctService.delEqpInspctCrrctReq(list);
		} catch (Exception e) {
			throw new CustomException(e, list, "검교정의뢰 삭제에 실패하였습니다.");
		}
	}

}
