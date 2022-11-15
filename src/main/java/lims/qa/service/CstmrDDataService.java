package lims.qa.service;

import java.util.List;

import lims.qa.vo.CstmrDDataVo;

public interface CstmrDDataService {

	List<CstmrDDataVo> getCstmrDDataList(CstmrDDataVo vo);

	List<CstmrDDataVo> getCstmrDDataHistList(CstmrDDataVo vo);

	int insCstmrDData(CstmrDDataVo vo);

	List<CstmrDDataVo> getPrductNmCombo(CstmrDDataVo vo);

	List<CstmrDDataVo> getWarnAt(CstmrDDataVo vo);

}
