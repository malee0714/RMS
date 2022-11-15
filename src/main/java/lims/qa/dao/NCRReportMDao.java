package lims.qa.dao;

import java.util.List;

import lims.req.vo.RequestMVo;
import lims.test.vo.ResultInputMVo;
import lims.test.vo.RoaMVo;
import org.springframework.stereotype.Repository;

import lims.qa.vo.NCRReportMVo;

@Repository
public interface NCRReportMDao {
	public int insNCRReport(NCRReportMVo vo);
	public int updNCRReport(NCRReportMVo vo);
	public List<NCRReportMVo> getNCRReportList(NCRReportMVo vo);
	public List<NCRReportMVo> getExpriemListSch(NCRReportMVo vo);

    int deleteNCRReport(NCRReportMVo ncrSeqno);

    List<RoaMVo> getRequestExpriemListSch(RoaMVo vo);

    void insertNcrExpriem(NCRReportMVo item);
}
