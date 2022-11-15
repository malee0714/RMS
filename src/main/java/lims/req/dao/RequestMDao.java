package lims.req.dao;

import lims.req.vo.RequestAuditVo;
import lims.req.vo.RequestMVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RequestMDao {
	List<RequestMVo> getMtrilEqpSeCombo(RequestMVo vo);
	List<RequestMVo> getMtrilVendorCombo(RequestMVo vo);
	List<RequestMVo> getRequestList(RequestMVo vo);
	int insSameLotNoChk(RequestMVo vo);
	String getReqestNo(RequestMVo vo);
	int insReqest(RequestMVo vo);
	int insExpriem(RequestMVo vo);
	int updReqest(RequestMVo vo);
	int delExpriem(RequestMVo vo);
	int delReqestAllExpriem(RequestMVo vo);
	int delReqest(RequestMVo vo);
	List<RequestMVo> getExpriemList(RequestMVo vo);
	String getReMatchingLotNo(RequestMVo vo);
	List<RequestMVo> getVendorLotNoList(RequestMVo vo);
	void insInitIREResults(RequestMVo vo);
	void delExpriemResults(RequestMVo vo);
	List<RequestMVo> getRequestMtrilExpriem(RequestMVo vo);
	void insertRequestAudit(RequestAuditVo vo);
	String getProgrsCode(RequestMVo vo);
	void updMinProgrsSittnCode(RequestMVo vo);
	List<RequestMVo> getsploreCylndrList(RequestMVo vo);
	List<RequestMVo> getsploreItemList(RequestMVo vo);
	List<RequestMVo> getmtrilSeqno(RequestMVo vo);

}
