package lims.req.service;

import lims.req.vo.RequestMVo;

import java.util.List;

public interface RequestMService {
	List<RequestMVo> getMtrilEqpSeCombo(RequestMVo vo);
	List<RequestMVo> getMtrilVendorCombo(RequestMVo vo);
	List<RequestMVo> getRequestList(RequestMVo vo);
	RequestMVo insReqest(RequestMVo vo);
	String updReqest(RequestMVo vo);
	String delReqest(RequestMVo vo);
	List<RequestMVo> getExpriemList(RequestMVo vo);
	List<RequestMVo> getReMatchingLotNo(List<RequestMVo> list);
	List<RequestMVo> getVendorLotNoList(RequestMVo vo);
	List<RequestMVo> getRequestMtrilExpriem(RequestMVo vo);
	List<RequestMVo> getsploreCylndrList(RequestMVo vo);
	List<RequestMVo> getsploreItemList(RequestMVo vo);
	List<RequestMVo> getmtrilSeqno(RequestMVo vo);

}
