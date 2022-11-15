package lims.src.service;

import java.util.List;

import lims.src.vo.ReceiptCntMVo;

public interface ReceiptCntMService {
	/**
	 * 담당 팀별 접수 건수 조회
	 * @param vo
	 * @return
	 */
	public List<ReceiptCntMVo> getReceiptCntList(ReceiptCntMVo vo);
}
