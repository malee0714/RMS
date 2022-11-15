package lims.com.dao;

import lims.com.vo.CmCn;
import lims.com.vo.CmSanctn;
import lims.com.vo.CmSanctnInfo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CmSanctnDao {

	void insertCmCn(CmCn cmCn);
	
	void insertSanctn(CmSanctn cmSanctn);
	
	void updateSanctn(CmSanctn cmSanctn);
	
	void insertSanctnInfo(CmSanctnInfo cmSanctnInfo);

	void deleteSanctnInfo(CmSanctn sanctn);

	void approvalRequest(CmSanctn cmSanctn);

	void updateTotalSanctnUserCount(CmSanctn sanctn);

	void approvalRequestSanctnInfo(CmSanctn cmSanctn);

	CmSanctn getSanctn(CmSanctn cmSanctn);

	void revert(CmSanctn cmSanctn);
}
