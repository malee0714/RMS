package lims.qa.dao;

import lims.com.vo.CmExmntDto;
import lims.qa.vo.AuditCarManageDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AuditCarManageDao {
	List<AuditCarManageDto> getAuditCar(AuditCarManageDto auditCarManageDto);

	void updateAuditCarSanctn(AuditCarManageDto auditCarManageDto);

	void insertAuditCar(AuditCarManageDto auditCarManageDto);

	void updateAuditCar(AuditCarManageDto auditCarManageDto);

	void updateExmntSeqno(CmExmntDto cmExmntDto);

	void deleteAuditCar(AuditCarManageDto auditCarManageDto);
}
