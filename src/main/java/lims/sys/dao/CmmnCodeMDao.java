package lims.sys.dao;

import lims.sys.vo.CmmnCodeMVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CmmnCodeMDao {

	public int confirmCmmnCodeMGbnList(CmmnCodeMVo vo);
	public int insCmmnCodeM(CmmnCodeMVo vo);
	public int updCmmnCodeM(CmmnCodeMVo vo);
	public int insCmmnCodeMDetail(CmmnCodeMVo vo);
	public int updCmmnCodeMDetail(CmmnCodeMVo vo);
	public List<CmmnCodeMVo> getCmmnCodeMTreeList(CmmnCodeMVo vo);
	public int updCmmnCodeOrdr(CmmnCodeMVo vo);

	//public List<CmmnCodeMVo> getCmmnCodeMList(CmmnCodeMVo vo);
	//public List<CmmnCodeMVo> getCmmnCodeMDetailList(CmmnCodeMVo vo);

}
