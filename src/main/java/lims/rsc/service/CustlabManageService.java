package lims.rsc.service;

import lims.rsc.vo.CustlabExpriemDto;
import lims.rsc.vo.CustlabDto;
import lims.rsc.vo.CustlabProductDto;
import lims.rsc.vo.CustlabWorkerDto;

import java.util.List;

public interface CustlabManageService {

	List<CustlabDto> getCustlab(CustlabDto custlabDto);

	void saveCustlab(CustlabDto custlabDto);
	
	void deleteCustlab(CustlabDto custlabDto);

	List<CustlabWorkerDto> getCustlabWorkers(CustlabWorkerDto workerDto);

	List<CustlabProductDto> getCustlabProducts(CustlabDto custlabDto);

	List<CustlabExpriemDto> getCustlabDayExpriems(CustlabDto custlabDto);

	String selectchrgDeptCode (CustlabDto custlabDto);
}
