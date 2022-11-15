package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.CndtnCheckMVo;

public interface CndtnCheckMDao {

	public List<CndtnCheckMVo> getcndtn(CndtnCheckMVo vo);
	
	public List<CndtnCheckMVo> getCnd(CndtnCheckMVo vo);


	public int saveCndtn(CndtnCheckMVo vo);

	public int saveCndtnDetail(CndtnCheckMVo cndtnCheckMVo);

	public List<CndtnCheckMVo> getCndVal(CndtnCheckMVo vo);

	public int upCndtnDetail(CndtnCheckMVo cndtnCheckMVo);

	public int upCndtn(CndtnCheckMVo vo);

	public List<CndtnCheckMVo> selectmhr(CndtnCheckMVo vo);

	public List<CndtnCheckMVo> getchValueList(CndtnCheckMVo vo);

	public List<CndtnCheckMVo> getchkValueList(CndtnCheckMVo vo);
	
	public List<CndtnCheckMVo> getchkValueDateList(CndtnCheckMVo vo);

}
