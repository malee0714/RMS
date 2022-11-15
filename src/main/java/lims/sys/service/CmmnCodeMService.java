package lims.sys.service;

import lims.sys.vo.CmmnCodeMVo;

import java.util.List;

public interface CmmnCodeMService {

	public int confirmCmmnCodeMGbnList(CmmnCodeMVo vo);
	public String getHostAddress(String ip);
	public List<CmmnCodeMVo> getCmmnCodeMTreeList(CmmnCodeMVo vo);
	public int saveCmmnCodeM(List<CmmnCodeMVo> list);
	public int sortCmmnCodeOrdr(List<CmmnCodeMVo> list);

//	public List<CmmnCodeMVo> getCmmnCodeMList(CmmnCodeMVo vo);
//	public List<CmmnCodeMVo> getCmmnCodeMDetailList(CmmnCodeMVo vo);
//	public int putCmmnCodeM(List<CmmnCodeMVo>vo);
//	public int putCmmnCodeMDetail(List<CmmnCodeMVo> vo);

}
