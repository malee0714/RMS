package lims.rsc.controller;

import lims.rsc.service.EqpmnGageService;
import lims.rsc.vo.EqpmnGageDto;
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
public class EqpmnGageController {

	private final EqpmnGageService eqpmnGageService;

	@Autowired
	public EqpmnGageController(EqpmnGageService eqpmnGageServiceImpl) {
		this.eqpmnGageService = eqpmnGageServiceImpl;
	}

	@Value("${file.upload.path}")
	private String fileUploadPath;
	
	@SetLocale()
	@RequestMapping(value="EqpmnGage.lims")
	public String EqpmnGage(Model model) {
		model.addAttribute("filePath", fileUploadPath.replaceAll("\\\\", "\\\\\\\\"));
		return "rsc/EqpmnGage";
	}
	
	@RequestMapping(value="getEqpmnGageList.lims")
	@ResponseBody
	public List<EqpmnGageDto> getEqpmnGageList(@RequestBody EqpmnGageDto eqpmnGageDto) {
		try {
			return eqpmnGageService.getEqpmnGageList(eqpmnGageDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnGageDto, "GageR&R 목록 조회에 실패하였습니다.");
		}
	}
	
	@RequestMapping(value="saveEqpmnGage.lims")
	@ResponseBody
	public int saveEqpmnGage(@RequestBody EqpmnGageDto eqpmnGageDto) {
		try {
			return eqpmnGageService.saveEqpmnGage(eqpmnGageDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnGageDto, "GageR&R 정보 등록에 실패하였습니다.");
		}
		
	}

	@RequestMapping(value="chkDuplicateRegistDte.lims")
	@ResponseBody
	public int chkDuplicateRegistDte(@RequestBody EqpmnGageDto eqpmnGageDto) {
		try {
			return eqpmnGageService.chkDuplicateRegistDte(eqpmnGageDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnGageDto, "등록일자 중복 검증에 실패하였습니다.");
		}

	}

	@RequestMapping(value = "getEqpGageReq.lims")
	@ResponseBody
	public List<EqpmnGageDto> getEqpGageReq(@RequestBody EqpmnGageDto eqpmnGageDto) {
		try {
			return eqpmnGageService.getEqpGageReq(eqpmnGageDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnGageDto, "GageR&R 의뢰목록 조회에 실패하였습니다.");
		}
	}

	@RequestMapping(value = "getEqpGageResult.lims")
	@ResponseBody
	public List<EqpmnGageDto> getEqpGageResult(@RequestBody EqpmnGageDto eqpmnGageDto) {
		try {
			return eqpmnGageService.getEqpGageResult(eqpmnGageDto);
		} catch (Exception e) {
			throw new CustomException(e, eqpmnGageDto, "GageR&R 결과 조회에 실패하였습니다.");
		}
	}

	@RequestMapping(value = "delEqpGageReq.lims")
	@ResponseBody
	public int delEqpGageReq(@RequestBody List<EqpmnGageDto> list) {
		try {
			return eqpmnGageService.delEqpGageReq(list);
		} catch (Exception e) {
			throw new CustomException(e, list, "GageR&R 의뢰 삭제에 실패하였습니다.");
		}
	}

	@RequestMapping(value = "delEqpGageResult.lims")
	@ResponseBody
	public int delEqpGageResult(@RequestBody List<EqpmnGageDto> list) {
		try {
			return eqpmnGageService.delEqpGageResult(list);
		} catch (Exception e) {
			throw new CustomException(e, list, "GageR&R 결과 삭제에 실패하였습니다.");
		}
	}

}
