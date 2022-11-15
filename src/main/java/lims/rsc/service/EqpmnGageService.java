package lims.rsc.service;

import lims.rsc.vo.EqpmnGageDto;

import java.util.List;

public interface EqpmnGageService {

	List<EqpmnGageDto> getEqpmnGageList(EqpmnGageDto eqpmnGageDto);
	int saveEqpmnGage(EqpmnGageDto eqpmnGageDto);
	int chkDuplicateRegistDte(EqpmnGageDto eqpmnGageDto);
	List<EqpmnGageDto> getEqpGageResult(EqpmnGageDto eqpmnGageDto);
	List<EqpmnGageDto> getEqpGageReq(EqpmnGageDto eqpmnGageDto);
	int delEqpGageReq(List<EqpmnGageDto> list);
	int delEqpGageResult(List<EqpmnGageDto> list);

}
