package lims.wrk.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.wrk.dao.ExprMthMDao;
import lims.wrk.service.ExprMthMService;
import lims.wrk.vo.ExprMthMVo;

@Service
public class ExprMthMServiceImpl implements ExprMthMService {

	@Autowired
    private ExprMthMDao exprMthMDao;

	@Override
	public List<ExprMthMVo> getExprMthMList(ExprMthMVo vo) {
		return exprMthMDao.getExprMthMList(vo);
	}

	@Override
	public int insExprMthM(ExprMthMVo vo) {
		return exprMthMDao.insExprMthM(vo);
	}

	@Override
	public int updExprMthM(ExprMthMVo vo) {
		return exprMthMDao.updExprMthM(vo);
	}
}
