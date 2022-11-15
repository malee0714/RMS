package lims.wrk.service.Impl;

import lims.wrk.dao.ExpriemMDao;
import lims.wrk.service.ExpriemMService;
import lims.wrk.vo.ExpriemMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExpriemMServiceImpl implements ExpriemMService {

	@Autowired
    private ExpriemMDao expriemMDao;

	@Override
	public List<ExpriemMVo> getExpriemMList(ExpriemMVo vo) {
		return expriemMDao.getExpriemMList(vo);
	}

	@Override
	public int insExpriemM(ExpriemMVo vo) {
		return expriemMDao.insExpriem(vo);
	}

	@Override
	public int updExpriemM(ExpriemMVo vo) {
		return expriemMDao.updExpriem(vo);
	}

	@Override
	public int getExpriemNmCnt(ExpriemMVo vo) {
		return expriemMDao.getExpriemNmCnt(vo);
	}

	@Override
	public int deleteExpriem(ExpriemMVo vo) {
		return expriemMDao.deleteExpriem(vo);
	}

	@Override
	public int updExpriemSortOrdr(List<ExpriemMVo> list) {
		int updCnt = list.size();
		for (ExpriemMVo expriemMVo : list)
			updCnt -= expriemMDao.updExpriemSortOrdr(expriemMVo);
		return (updCnt == 0) ? 1 : 99;
	}
}
