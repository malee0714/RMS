package lims.qa.service;

import lims.com.vo.CmExmntDto;
import lims.qa.vo.AuditCarManageDto;

import java.util.List;

public interface AuditCarManageService {

	List<AuditCarManageDto> getAuditCar(AuditCarManageDto auditCarManageDto);

	void saveAuditCar(AuditCarManageDto auditCarManageDto);

	void auditCarApprovalRequest(AuditCarManageDto auditCarManageDto);

	void deleteAuditCar(AuditCarManageDto auditCarManageDto);
	
	void saveExmnt(CmExmntDto cmExmntDto);

	void revertAuditCarManage(AuditCarManageDto auditCarManageDto);
}
