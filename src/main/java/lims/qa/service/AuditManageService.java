package lims.qa.service;

import lims.com.vo.CmExmntDto;
import lims.qa.vo.AuditManageDto;

import java.util.List;

public interface AuditManageService {
	void saveAuditManage(AuditManageDto auditManageDto);

	List<AuditManageDto> getAudit(AuditManageDto auditManageDto);

	void approvalRequestAuditManage(AuditManageDto auditManageDto);

	void deleteAuditManage(AuditManageDto auditManageDto);
	
	void saveExmnt(CmExmntDto cmExmntDto);

	void revertAuditManage(AuditManageDto auditManageDto);
}
