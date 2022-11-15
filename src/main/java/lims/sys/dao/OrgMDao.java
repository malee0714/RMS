package lims.sys.dao;

import java.util.List;

import lims.sys.vo.OrgMVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrgMDao {

	//최상위 조직 콤보박스
	public List<OrgMVo> getBestComboList(OrgMVo vo);

	//상위 조직 콤보박스
	public List<OrgMVo> getUpperComboList(OrgMVo vo);
	
	//권한 콤보박스
	public List<OrgMVo> getAuthorCodeList(OrgMVo vo);
	
	//상위 조직 콤보박스(모든 사업장)
	public List<OrgMVo> getUpperComboListAll(OrgMVo vo);
	
	//조회
	public List<OrgMVo> getOrgMList(OrgMVo vo);

	//등록
	public int insOrgM(OrgMVo vo);

	//수정
	public int updOrgM(OrgMVo vo);

}
