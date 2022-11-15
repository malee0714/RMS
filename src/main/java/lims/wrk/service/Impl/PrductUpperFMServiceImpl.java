package lims.wrk.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.antlr.grammar.v3.CodeGenTreeWalker.element_action_return;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.com.service.CommonService;
import lims.util.CommonFunc;
import lims.wrk.dao.PrductUpperFMDao;
import lims.wrk.dao.PrductUpperMDao;
import lims.wrk.service.PrductUpperFMService;
import lims.wrk.vo.PrductUpperMVo;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PrductUpperFMServiceImpl implements PrductUpperFMService {
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;

	@Autowired
	private PrductUpperFMDao DAO;

	@Autowired
	private PrductUpperMDao PrductUpperMDao;

	// 조회
	@Override
	public List<PrductUpperMVo> getPrductUppFM(PrductUpperMVo vo) {
		return PrductUpperMDao.getPrductUpp(vo);
	}

	// 삭제
	@Override
	public int delPrductUppFM(PrductUpperMVo vo) {
		return DAO.delPrductUppFM(vo);
	}

	// 저장
	@Override
	public int savePrductUppFM(PrductUpperMVo vo) {
		int result = 0;
		String PrductUpperSeqno = vo.getPrductUpperSeqno();
		if (PrductUpperSeqno == "" || PrductUpperSeqno == null) {

			int chk = DAO.chkNo(vo);
			if (chk >= 1) {
				return result;
			} else {
				result = DAO.savePrductUppFM(vo);
			}

		} else {
			int chk = DAO.chkNo(vo);

			if (chk >= 1) { // 중복된 값이 있을때

				PrductUpperMVo ChkVO = DAO.chkPrductUpp(vo);

				log.info(vo.getPrductUpperSeqno() + "" + ChkVO.getPrductUpperSeqno());
				if (vo.getPrductUpperSeqno().equals(ChkVO.getPrductUpperSeqno())) {

					return DAO.upPrductUppFM(vo);

				} else {
					return result;
				}

			} else {
				return DAO.upPrductUppFM(vo);

			}
		}

		return result;

	}

	@Override
	public int chkNo(PrductUpperMVo vo) {

		return DAO.chkNo(vo);
	}

	@Override
	public PrductUpperMVo chkPrductUpp(PrductUpperMVo vo) {
		// TODO Auto-generated method stub
		return DAO.chkPrductUpp(vo);
	}

}
