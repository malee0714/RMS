package lims.req.service;

import java.util.List;

import lims.req.vo.RequestSanctnMVo;

public interface RequestSanctnMService {

	//의뢰결재 조회
	List<RequestSanctnMVo> getRequestSanctnList(RequestSanctnMVo vo);

	//의뢰결재 시험항목 조회
	List<RequestSanctnMVo> getExpriemSanctnList(RequestSanctnMVo vo);

	//의뢰결재 승인
	int updApproval(List<RequestSanctnMVo> list);

	//의뢰결재 반려
	int updRtn(List<RequestSanctnMVo> list);
}
