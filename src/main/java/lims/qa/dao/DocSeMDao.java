package lims.qa.dao;

import java.util.List;

import lims.qa.vo.DocSeMVo;

public interface DocSeMDao {

	public int confirmDocSeMGbnList(DocSeMVo vo);
	public List<DocSeMVo> getDocSeMDetailList(DocSeMVo vo);
	public int insDocSeM(DocSeMVo vo);
	public int updDocSeM(DocSeMVo vo);
	public int insDocSeMDetail(DocSeMVo vo);
	public int updDocSeMDetail(DocSeMVo vo);
	public String getAuditAt(DocSeMVo vo);
	public int insAuditAt(DocSeMVo vo);
	public List<DocSeMVo> getDocSeMList(DocSeMVo vo);
	public int updDeleteAtSeM(DocSeMVo docSeMVo);
	public int updDeleteAtSeDetailM(DocSeMVo docSeMVo);
}
