package lims.req.dao;

import java.util.List;

import lims.req.vo.RequestSanctnMVo;

public interface RequestSanctnMDao {

	//의뢰결재 조회
	List<RequestSanctnMVo> getRequestSanctnList(RequestSanctnMVo vo);

	//의뢰결재 시험항목 조회
	List<RequestSanctnMVo> getExpriemSanctnList(RequestSanctnMVo vo);

	//의뢰결재 승인
	int updApproval(RequestSanctnMVo vo);

	//다음 결재자 조회
	int getNextSanctnerCnt(RequestSanctnMVo vo);

	//결재 진행상황 MIN
	void updSanctnTableProgresSetMinVal(RequestSanctnMVo vo);

	//다음 결재 진행을 위한 결재대기예정자 >>> 결재대기 진행상황 변경
	void updNextSanctnProgres(RequestSanctnMVo vo);
	
	//반려 등록
	void insRnt(RequestSanctnMVo vo);

	//의뢰결재 반려
	int updRtnSanctn(RequestSanctnMVo vo);

	//의뢰결재정보 반려
	void updRtnSanctnInfo(RequestSanctnMVo vo);
}
