package lims.qa.service;

import java.util.List;

import lims.qa.vo.DocSeMVo;

public interface DocSeMService {
	public int confirmDocSeMGbnList(DocSeMVo vo);
	public List<DocSeMVo> getDocSeMDetailList(DocSeMVo vo);
	public int putDocSeM(DocSeMVo vo);
	public int putDocSeMDetail(DocSeMVo vo);
	public List<DocSeMVo> getDocSeMList(DocSeMVo vo);
}
