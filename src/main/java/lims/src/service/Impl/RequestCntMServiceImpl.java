package lims.src.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.src.dao.RequestCntMDao;
import lims.src.service.RequestCntMService;
import lims.src.vo.RequestCntMVo;
import lims.util.GetUserSession;

@Service("RequestCntMService")
public class RequestCntMServiceImpl implements RequestCntMService{

	@Autowired
	private RequestCntMDao requestCntMDao;
	
	/**
	 * 부서별 의뢰건수 조회
	 */
	@Override
	public RequestCntMVo getRequestCntList(RequestCntMVo vo) {
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
		
		/* 의뢰 건수와 의뢰일(범례)을 하나의 쿼리에서 출력할 수 있게
		   vo에 type을 각각 다르게 set해주고 쿼리에서 분기처리 */
		vo.setType("list");      // 건수
		vo.setList(requestCntMDao.getRequestCntList(vo));
		vo.setType("listDate");  // 범례
		vo.setListDate(requestCntMDao.getRequestCntList(vo));
		
		return vo;
	}
}
