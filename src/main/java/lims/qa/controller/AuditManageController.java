package lims.qa.controller;

import lims.com.vo.CmExmntDto;
import lims.qa.service.AuditManageService;
import lims.qa.vo.AuditManageDto;
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
 * Audit 감사정보를 관리한다.
 * 
 * @author shs
 */
@Controller
@RequestMapping("/qa")
public class AuditManageController {

	private final AuditManageService auditManageServiceImpl;

	@Autowired
	public AuditManageController(AuditManageService auditManageServiceImpl) {
		this.auditManageServiceImpl = auditManageServiceImpl;
	}
	
	@RequestMapping("/AuditM.lims")
	@SetLocale
	public String page(Model model) {
		return "/qa/AuditM";
	}

	@RequestMapping("/getAudit.lims")
	@ResponseBody
	public List<AuditManageDto> getAudit(@RequestBody AuditManageDto auditManageDto) {
		return this.auditManageServiceImpl.getAudit(auditManageDto);
	}
	
	@RequestMapping("/saveAuditManage.lims")
	public ResponseEntity<AuditManageDto> saveAuditManage(@RequestBody AuditManageDto auditManageDto) {
		try {
			auditManageServiceImpl.saveAuditManage(auditManageDto);
			return ResponseEntity.ok(auditManageDto);
		} catch (CustomException e ) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, auditManageDto, "감사정보 저장/수정을 정상적으로 완료하지 못했습니다.");
		}
	}
	
	@RequestMapping("/approvalRequestAuditManage.lims")
	public ResponseEntity<AuditManageDto> approvalRequestAuditManage(@RequestBody AuditManageDto auditManageDto) {
		try {
			auditManageServiceImpl.approvalRequestAuditManage(auditManageDto);
			return ResponseEntity.ok(auditManageDto);
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, auditManageDto, "감사정보 저장/수정을 정상적으로 완료하지 못했습니다.");
		}
	}
	
	@RequestMapping("/revertAuditManage.lims")
	public ResponseEntity<AuditManageDto> revertAuditManage(@RequestBody AuditManageDto auditManageDto) {
		try {
			auditManageServiceImpl.revertAuditManage(auditManageDto);
			return ResponseEntity.ok(auditManageDto);
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, auditManageDto, "회수를 정상적으로 완료하지 못했습니다.");
		}
	}
	
	@RequestMapping("/deleteAuditManage.lims")
	public ResponseEntity<Void> deleteAuditManage(@RequestBody AuditManageDto auditManageDto) {
		try {
			auditManageServiceImpl.deleteAuditManage(auditManageDto);
			return ResponseEntity.ok().build();
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, auditManageDto, "감사정보 삭제를 정상적으로 완료하지 못했습니다.");
		}
	}

	/**
	 * 검토 정보 저장
	 * @param cmExmntDto 검토 dto
	 */
	@RequestMapping("/auditManageSaveExmnt.lims")
	public ResponseEntity<Void> auditManageSaveExmnt(@RequestBody CmExmntDto cmExmntDto) {
		try {
			auditManageServiceImpl.saveExmnt(cmExmntDto);
			return ResponseEntity.ok().build();
		} catch (CustomException e) {
			throw e;
		}   
	}
}
