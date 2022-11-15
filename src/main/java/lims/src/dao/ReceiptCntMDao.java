package lims.src.dao;

import java.util.List;

import lims.src.vo.ReceiptCntMVo;

public interface ReceiptCntMDao {
	/**
	 * 담당 팀별 접수 건수 조회
	 * @param vo
	 * @return
	 */
	public List<ReceiptCntMVo> getReceiptCntList(ReceiptCntMVo vo);
}
