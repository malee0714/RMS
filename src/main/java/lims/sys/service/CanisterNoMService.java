package lims.sys.service;

import java.util.List;

import lims.sys.vo.CanisterNoMVo;

public interface CanisterNoMService {
	//조회
	public List<CanisterNoMVo> getCan(CanisterNoMVo vo);
	
	//저장
	public int saveCan(List<CanisterNoMVo> list);
	
	//중복체크
	public int chkNo(CanisterNoMVo vo);
	
	//삭제
	public int delCan(List<CanisterNoMVo> list);

}
