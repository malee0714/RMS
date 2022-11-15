package lims.src.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.src.dao.ReceiptCntMDao;
import lims.src.service.ReceiptCntMService;
import lims.src.vo.ReceiptCntMVo;
import lims.util.GetUserSession;

@Service("ReceiptCntMService")
public class ReceiptCntMServiceImpl implements ReceiptCntMService{

	@Autowired
	private ReceiptCntMDao receiptCntMDao;
	
	/**
	 * 담당 팀별 접수 건수 조회
	 */
	@Override
	public List<ReceiptCntMVo> getReceiptCntList(ReceiptCntMVo vo) {
		// TODO Auto-generated method stub
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
		return receiptCntMDao.getReceiptCntList(vo);
	}

}
