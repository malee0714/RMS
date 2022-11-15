package lims.rsc.dao;

import lims.rsc.vo.EqpmnGageDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EqpmnGageDao {
	
	List<EqpmnGageDto> getEqpmnGageList(EqpmnGageDto eqpmnGageDto);
	int insEqpmnGage(EqpmnGageDto eqpmnGageDto);
	int updEqpmnGage(EqpmnGageDto eqpmnGageDto);
	int chkDuplicateRegistDte(EqpmnGageDto eqpmnGageDto);
	List<EqpmnGageDto> getEqpGageResult(EqpmnGageDto eqpmnGageDto);
	List<EqpmnGageDto> getEqpGageReq(EqpmnGageDto eqpmnGageDto);
	int insEqpGageReq(EqpmnGageDto eqpmnGageDto);
	int delEqpGageReq(EqpmnGageDto eqpmnGageDto);
	int insEqpGageResult(EqpmnGageDto eqpmnGageDto);
	int updEqpGageResult(EqpmnGageDto eqpmnGageDto);
	
}
