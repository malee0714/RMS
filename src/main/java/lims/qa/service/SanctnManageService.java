package lims.qa.service;

import lims.com.vo.CmRtn;
import lims.qa.vo.SanctnManageDto;

import java.util.List;

public interface SanctnManageService {
	List<SanctnManageDto> getSanctn(SanctnManageDto cmSanctn);

	void confirm(List<SanctnManageDto> confirmList);

	void confirm(SanctnManageDto sanctnManageDto);

	List<CmRtn> getRtn (CmRtn cmSanctn);

	void returnProcess(List<SanctnManageDto> returnList);

	void returnProcess(SanctnManageDto sanctnManageDto);
}
