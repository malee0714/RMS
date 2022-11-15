package lims.test.dao;

import java.util.List;

import lims.test.vo.RoaMVo;
import org.springframework.stereotype.Repository;

import lims.com.vo.MesPIVo;
import lims.com.vo.WdtbVo;
import lims.qa.vo.NCRReportMVo;
import lims.test.vo.ResultInputMVo;
import lims.wrk.vo.CalcLawMVo;
import lims.wrk.vo.ExprMthMVo;
import lims.wrk.vo.PrductMVo;

@Repository
public interface ResultInputMDao {
	public List<ResultInputMVo> getReqestListSch(ResultInputMVo vo);

	public List<ResultInputMVo> getExpriemListSch(ResultInputMVo vo);

	public String checkReqestProGrs(ResultInputMVo vo);

	public int updateExpriemResult(ResultInputMVo vo);

	public int updateExpriem(ResultInputMVo vo);

	public int insertNomfrmInfo(CalcLawMVo vo);

	public int returnExpriem(ResultInputMVo vo);

	public List<ResultInputMVo> getExpriemCalcNomfrm(ResultInputMVo vo);

	public int insertNCRReport(NCRReportMVo vo);

	public int insertNCRDetailReport(NCRReportMVo vo);

	public int insReReqest(ResultInputMVo vo);

	public int insReExpriem(ResultInputMVo vo);

	public int insReExpriemResult(ResultInputMVo vo);

	public int insReExpriemResultNomfrm(ResultInputMVo vo);

	public int insertWdtbInfo(WdtbVo vo);

	public int insertWdtbInfoSender(WdtbVo vo);

	public List<PrductMVo> getMtrilTarget(String lotNo);

	public int completeResultInput(ResultInputMVo vo);

	List<NCRReportMVo> checkDuplicateNcrExpriem(NCRReportMVo ncr);

	void updateRequestProcess(ResultInputMVo firstVo);
}