package lims.qa.dao;

import lims.com.vo.CmExmntDto;
import lims.qa.vo.AuditManageDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AuditManageDao {

	void insertAuditManage(AuditManageDto auditManageDto);

	void updateAuditManage(AuditManageDto auditManageDto);

	List<AuditManageDto> getAudit(AuditManageDto auditManageDto);

	void updateAuditManageSanctn(AuditManageDto auditManageDto);

	void deleteAuditManage(AuditManageDto auditManageDto);

	void updateExmntSeqno(CmExmntDto cmExmntDto);
}
