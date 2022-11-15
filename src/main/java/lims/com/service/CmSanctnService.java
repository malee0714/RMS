package lims.com.service;

import lims.com.vo.CmSanctn;
import lims.qa.vo.AuditManageDto;

/**
 * 결재에 대한 기능을 정의한다.
 * 
 * @author shs
 */
public interface CmSanctnService {

	<T extends CmSanctn> void approvalRequest(T cmSanctn);
	<T extends CmSanctn> void saveSanctn(T cmSanctn);
	<T extends CmSanctn> void revert(T cmSanctn);
}
