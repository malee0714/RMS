package lims.qa.dao;

import java.util.List;

import lims.qa.vo.CstmrDDataVo;

public interface CstmrDDataDao {

	public int updCtmrDDeleteAt(CstmrDDataVo vo);

	public int insCstmrDData(CstmrDDataVo vo);

	public List<CstmrDDataVo> getCstmrDDataList(CstmrDDataVo vo);

	public List<CstmrDDataVo> getCstmrDDataHistList(CstmrDDataVo vo);

	public int delCstmrDData(CstmrDDataVo cstmrDDataVo);

	public int updCtmrDLastAt(CstmrDDataVo vo);

	public int updCstmrDData(CstmrDDataVo vo);

	public List<CstmrDDataVo> getPrductNmCombo(CstmrDDataVo vo);

	public int delWdtbTrgter(CstmrDDataVo cstmrDDataVo);

	public int insWdtbTrgter(CstmrDDataVo cstmrDDataVo);

	public int insWdtb(CstmrDDataVo vo);

	public int updWdtbSeqno(CstmrDDataVo vo);

	public int updWdtb(CstmrDDataVo vo);

	public List<CstmrDDataVo> getWarnAt(CstmrDDataVo vo);



	

}
