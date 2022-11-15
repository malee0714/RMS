package lims.qa.controller;

import lims.com.vo.CmExmntDto;
import lims.qa.service.AuditCarManageService;
import lims.qa.vo.AuditCarManageDto;
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

/**
 * Audit Car를 관리한다.
 * 
 * @author shs
 */
@Controller
@RequestMapping("/qa")
public class AuditCarManageController {

	private final AuditCarManageService auditCarManageServiceImpl;

	@Autowired
	public AuditCarManageController(AuditCarManageService auditCarManageServiceImpl) {
		this.auditCarManageServiceImpl = auditCarManageServiceImpl;
	}
	
	@SetLocale
	@RequestMapping("/AuditCarM.lims")
	public String returnPage(Model model) {
		return "/qa/AuditCarM";
	}
	
	@RequestMapping("/getAuditCar.lims")
	@ResponseBody
	public List<AuditCarManageDto> getAuditCar(@RequestBody AuditCarManageDto auditCarManageDto) {
		return auditCarManageServiceImpl.getAuditCar(auditCarManageDto);
	}
	
	@RequestMapping("/saveAuditCar.lims")
	public ResponseEntity<AuditCarManageDto> saveAuditCar(@RequestBody AuditCarManageDto auditCarManageDto) {
		try {
			auditCarManageServiceImpl.saveAuditCar(auditCarManageDto);
			return ResponseEntity.ok(auditCarManageDto);
		} catch (IllegalStateException | CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, auditCarManageDto, "감사-CAR 저장/수정을 정상적으로 완료하지 못했습니다.");
		}
	}
	
	@RequestMapping("/auditCarApprovalRequest.lims")
	public ResponseEntity<AuditCarManageDto> saveAuditCarApprovalRequest(@RequestBody AuditCarManageDto auditCarManageDto) {
		try {
			auditCarManageServiceImpl.auditCarApprovalRequest(auditCarManageDto);
			return ResponseEntity.ok(auditCarManageDto);
		} catch (IllegalStateException | CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, auditCarManageDto, "감사-CAR 저장/수정 및 결재상신을 정상적으로 완료하지 못했습니다.");
		}
	}
	
	@RequestMapping("/revertAuditCarManage.lims")
	public ResponseEntity<AuditCarManageDto> revertAuditCarManage(@RequestBody AuditCarManageDto auditCarManageDto) {
		try {
			auditCarManageServiceImpl.revertAuditCarManage(auditCarManageDto);
			return ResponseEntity.ok(auditCarManageDto);
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, auditCarManageDto, "회수를 정상적으로 완료하지 못했습니다.");
		}
	}
	
	@RequestMapping("/deleteAuditCar.lims")
	public ResponseEntity<Void> deleteAuditCar(@RequestBody AuditCarManageDto auditCarManageDto) {
		try {
			auditCarManageServiceImpl.deleteAuditCar(auditCarManageDto);
			return ResponseEntity.ok().build();
		} catch (CustomException e ) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, auditCarManageDto, "감사-CAR 삭제를 정상적으로 완료하지 못했습니다.");
		}
	}
	
	/**
	 * 검토 정보 저장
	 * @param cmExmntDto 검토 dto
	 */
	@RequestMapping("/auditCarManageSaveExmnt.lims")
	public ResponseEntity<Void> auditCarManageSaveExmnt(@RequestBody CmExmntDto cmExmntDto) {
		try {
			auditCarManageServiceImpl.saveExmnt(cmExmntDto);
			return ResponseEntity.ok().build();
		} catch (CustomException e) {
			throw e;
		}
	}
}
