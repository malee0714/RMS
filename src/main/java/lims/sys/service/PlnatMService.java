package lims.sys.service;

import java.util.List;

import lims.sys.vo.PlnatMVo;

public interface PlnatMService {

	//사업장 조회
	public List<PlnatMVo> getPlnatMList(PlnatMVo vo);

	//사업장 등록
	public int insPlnat(List<PlnatMVo> list);

	//품질비 조회
	public List<PlnatMVo> getPlnatQlityCtAmMList(PlnatMVo vo);

	//품질비 등록 수정 삭제
	public int putPlnatQlityCtAm(PlnatMVo vo);

	public List<PlnatMVo> getlbcstList(PlnatMVo vo);
}
