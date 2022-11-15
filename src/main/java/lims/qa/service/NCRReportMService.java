package lims.qa.service;

import java.util.List;

import lims.qa.vo.NCRReportMVo;
import lims.req.vo.RequestMVo;
import lims.test.vo.ResultInputMVo;
import lims.test.vo.RoaMVo;

public interface NCRReportMService {
	int saveNCRReport(NCRReportMVo vo);
	List<NCRReportMVo> getNCRReportList(NCRReportMVo vo);

	List<NCRReportMVo> getExpriemListSch(NCRReportMVo vo);

    int deleteNCRReport(NCRReportMVo ncrSeqno);

    List<RoaMVo> getRequestExpriemListSch(RoaMVo vo);
}
