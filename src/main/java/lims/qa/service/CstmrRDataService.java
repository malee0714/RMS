package lims.qa.service;

import java.util.List;

import lims.qa.vo.CstmrRDataVo;

public interface CstmrRDataService {

	List<CstmrRDataVo> getCstmrRDataList(CstmrRDataVo vo);

	List<CstmrRDataVo> getCstmrRDataHistList(CstmrRDataVo vo);

	int insCstmrRData(CstmrRDataVo vo);

}
