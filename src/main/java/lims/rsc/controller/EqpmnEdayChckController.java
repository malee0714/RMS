package lims.rsc.controller;

import lims.rsc.service.EqpmnEdayChckService;
import lims.rsc.vo.EqpmnEdayChckDto;
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
public class EqpmnEdayChckController {

	private final EqpmnEdayChckService eqpmnEdayChckService;

	@Autowired
	public EqpmnEdayChckController(EqpmnEdayChckService eqpmnEdayChckServiceImpl) {
		this.eqpmnEdayChckService = eqpmnEdayChckServiceImpl;
	}

	@SetLocale()
	@RequestMapping(value = "EqpmnEdayChck.lims")
	public String EqpmnEdayChck(Model model) {
		return "rsc/EqpmnEdayChck";
	}

	@SetLocale()
	@RequestMapping(value = "EqpmnEdayChckSearch.lims")
	public String EqpmnEdayChckSearch(Model model) {
		return "rsc/EqpmnEdayChckSearch";
	}

	@RequestMapping(value = "getEqpmnEdayChkList.lims")
	@ResponseBody
	public List<EqpmnEdayChckDto> getEqpmnEdayChkList(@RequestBody EqpmnEdayChckDto eqpmnEdayChckDto) {
		try {
			return eqpmnEdayChckService.getEqpmnEdayChkList(eqpmnEdayChckDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnEdayChckDto, "일상점검 목록이 정상적으로 조회되지 않았습니다.");
		}
	}

	@RequestMapping(value = "chkDuplicateChckDte.lims")
	@ResponseBody
	public int chkDuplicateChckDte(@RequestBody EqpmnEdayChckDto eqpmnEdayChckDto) {
		try {
			return eqpmnEdayChckService.chkDuplicateChckDte(eqpmnEdayChckDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnEdayChckDto, "일상점검정보 중복검증에 실패하였습니다.");
		}
	}

	@RequestMapping(value = "saveEqpEdayChkResult.lims")
	@ResponseBody
	public int saveEqpEdayChkResult(@RequestBody EqpmnEdayChckDto eqpmnEdayChckDto) {
		try {
			return eqpmnEdayChckService.saveEqpEdayChkResult(eqpmnEdayChckDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnEdayChckDto, "일상점검 정보가 정상적으로 등록되지 않았습니다.");
		}
	}
	
	@RequestMapping(value = "getEqpEdayChckExprM.lims")
	@ResponseBody
	public List<EqpmnEdayChckDto> getEqpEdayChckExprM(@RequestBody EqpmnEdayChckDto eqpmnEdayChckDto) {
		try {
			return eqpmnEdayChckService.getEqpEdayChckExprM(eqpmnEdayChckDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnEdayChckDto, "일상점검 시험항목이 정상적으로 조회되지 않았습니다.");
		}
		
	}
	
	@RequestMapping(value = "getEqpEdayChckResult.lims")
	@ResponseBody
	public List<EqpmnEdayChckDto> getEqpEdayChckResult(@RequestBody EqpmnEdayChckDto eqpmnEdayChckDto) {
		try {
			return eqpmnEdayChckService.getEqpEdayChckResult(eqpmnEdayChckDto);
	 	} catch (Exception e) {
			throw new CustomException(e, eqpmnEdayChckDto, "등록된 일상점검 결과가 정상적으로 조회되지 않았습니다.");
		}
	}

	@RequestMapping(value = "getEqpmnListOnPop.lims")
	@ResponseBody
	public List<EqpmnEdayChckDto> getEqpmnListOnPop(@RequestBody EqpmnEdayChckDto eqpmnEdayChckDto) {
		try {
			return eqpmnEdayChckService.getEqpmnListOnPop(eqpmnEdayChckDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnEdayChckDto, "장비목록이 정상적으로 조회되지 않았습니다.");
		}
	}
	
}
