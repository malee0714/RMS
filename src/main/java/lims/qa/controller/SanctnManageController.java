package lims.qa.controller;

import lims.com.vo.CmRtn;
import lims.qa.service.SanctnManageService;
import lims.qa.vo.SanctnManageDto;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/qa")
public class SanctnManageController {

	private final SanctnManageService sanctnManageServiceImpl;

	@Autowired
	public SanctnManageController(SanctnManageService sanctnManageServiceImpl) {
		this.sanctnManageServiceImpl = sanctnManageServiceImpl;
	}
	
	@SetLocale
	@RequestMapping("/SanctnM.lims")
	public String returnPage(Model model) {
		return "/qa/SanctnM";
	}
	
	@RequestMapping("/getSanctn.lims")
	@ResponseBody
	public List<SanctnManageDto> getSanctn(@RequestBody SanctnManageDto cmSanctn) {
		return sanctnManageServiceImpl.getSanctn(cmSanctn);
	}
	@RequestMapping("/getRtn.lims")
	@ResponseBody
	public List<CmRtn> getRtn(@RequestBody CmRtn cmRtn) {
		return sanctnManageServiceImpl.getRtn(cmRtn);
	}
	
	@RequestMapping("/confirm/list.lims")
	public ResponseEntity<Void> confirm(@RequestBody List<SanctnManageDto> confirmList) {
		try {
			sanctnManageServiceImpl.confirm(confirmList);
			return ResponseEntity.ok().build();
		} catch (IllegalStateException e) {
			throw new CustomException(e, e.getMessage());
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, "결재가 정상적으로 완료되지 않았습니다.");
		}
	}
	
	@RequestMapping("/confirm.lims")
	public ResponseEntity<Void> confirm(@RequestBody SanctnManageDto sanctnManageDto) {
		try {
			sanctnManageServiceImpl.confirm(sanctnManageDto);
			return ResponseEntity.ok().build();
		} catch (IllegalStateException e) {
			throw new CustomException(e, e.getMessage());
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, "결재가 정상적으로 완료되지 않았습니다.");
		}
	}
	
	@RequestMapping("/return/list.lims")
	public ResponseEntity<Void> returnProcess(@RequestBody List<SanctnManageDto> returnList) {
		try {
			sanctnManageServiceImpl.returnProcess(returnList);
			return ResponseEntity.ok().build();
		} catch (IllegalStateException e) {
			throw new CustomException(e, e.getMessage());
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, "반려가 정상적으로 완료되지 않았습니다.");
		}
	}
	
	@RequestMapping("/return.lims")
	public ResponseEntity<Void> returnProcess(@RequestBody SanctnManageDto sanctnManageDto) {
		try {
			sanctnManageServiceImpl.returnProcess(sanctnManageDto);
			return ResponseEntity.ok().build();
		} catch (IllegalStateException e) {
			throw new CustomException(e, e.getMessage());
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, "반려가 정상적으로 완료되지 않았습니다.");
		}
	}
}
