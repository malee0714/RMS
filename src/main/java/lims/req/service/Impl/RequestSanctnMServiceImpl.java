package lims.req.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.req.dao.RequestSanctnMDao;
import lims.req.service.RequestSanctnMService;
import lims.req.vo.RequestSanctnMVo;

@Service
public class RequestSanctnMServiceImpl implements RequestSanctnMService {

	@Autowired
	private RequestSanctnMDao requestSanctnMDao;

	@Override
	public List<RequestSanctnMVo> getRequestSanctnList(RequestSanctnMVo vo) {
		return requestSanctnMDao.getRequestSanctnList(vo);
	}

	@Override
	public List<RequestSanctnMVo> getExpriemSanctnList(RequestSanctnMVo vo) {
		return requestSanctnMDao.getExpriemSanctnList(vo);
	}

	@Override
	public int updApproval(List<RequestSanctnMVo> list) {
		int resultCount = list.size();
		for (RequestSanctnMVo requestSanctnMVo : list) {
			//의뢰 결재 정보 승인
			resultCount -= requestSanctnMDao.updApproval(requestSanctnMVo);
			//다음 결재자 조회
			int nextSanctnerCnt = requestSanctnMDao.getNextSanctnerCnt(requestSanctnMVo);
			if(nextSanctnerCnt <= 0) {
				//결재 진행상황 MIN
				requestSanctnMDao.updSanctnTableProgresSetMinVal(requestSanctnMVo);
			} else {
				//다음 결재 진행을 위한 결재대기예정자 >>> 결재대기 진행상황 변경
				requestSanctnMDao.updNextSanctnProgres(requestSanctnMVo);
			}
		}
		return resultCount == 0 ? 1 : 99;
	}

	@Override
	public int updRtn(List<RequestSanctnMVo> list) {
		//반려, 결재, 결재정보 테이블 반려처리
		int resultCount = list.size();
		for (RequestSanctnMVo requestSanctnMVo : list) {
			//반려 등록
			requestSanctnMDao.insRnt(requestSanctnMVo);
			//결재 진행상황 반려
			int resultCnt = requestSanctnMDao.updRtnSanctn(requestSanctnMVo);
			if(resultCnt == 1) {
				resultCount -= resultCnt;
				//결재정보 진행상황 반려
				requestSanctnMDao.updRtnSanctnInfo(requestSanctnMVo);
			}
		}

		return resultCount == 0 ? 1 : 99;
	}

}
