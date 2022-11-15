package lims.com.service;

import lims.com.vo.CmExmntDto;

@FunctionalInterface
public interface CmExmntOperator {
	
	/**
	 * 각 table에 검토 seqno update하는 로직을 구현해야한다.
	 */
	void updateExmntSeqno(CmExmntDto cmExmntDto);
}
