package lims.qa.dao;

import java.util.List;

import lims.qa.vo.CstmrRDataVo;

public interface CstmrRDataDao {

	public int updCtmrRDeleteAt(CstmrRDataVo vo);

	public int insCstmrRData(CstmrRDataVo vo);

	public List<CstmrRDataVo> getCstmrRDataList(CstmrRDataVo vo);

	public List<CstmrRDataVo> getCstmrRDataHistList(CstmrRDataVo vo);

	public int delCstmrRData(CstmrRDataVo cstmrRDataVo);

	public int updCtmrRLastAt(CstmrRDataVo vo);

	public int updCstmrRData(CstmrRDataVo vo);

	public int updWdtbSeqno(CstmrRDataVo vo);



	

}
