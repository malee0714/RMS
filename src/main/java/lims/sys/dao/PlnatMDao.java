package lims.sys.dao;

import java.util.List;

import lims.sys.vo.PlnatMVo;

public interface PlnatMDao {

	//사업장 조회
	public List<PlnatMVo> getPlnatMList(PlnatMVo vo);

	//사업장 수 초과 체크
	public int bplcCoCheck(int sumBplcCo);

	//사업장 등록
	public int insPlnat(PlnatMVo vo);

	//품질비 조회
	public List<PlnatMVo> getPlnatQlityCtAmMList(PlnatMVo vo);

	//품질비 등록
	public int insPlnatQlityCtAm(PlnatMVo vo);

	//품질비 수정
	public int updPlnatQlityCtAm(PlnatMVo vo);

	//품질비 삭제
	public int delPlnatQlityCtAm(PlnatMVo vo);

	public int insLbcst(PlnatMVo vo);

	public int upLbcst(PlnatMVo vo);

	public List<PlnatMVo> getlbcstList(PlnatMVo vo);
}
