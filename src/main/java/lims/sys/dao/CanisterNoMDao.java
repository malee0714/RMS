package lims.sys.dao;

import java.util.List;

import lims.sys.vo.CanisterNoMVo;

public interface CanisterNoMDao {

	public List<CanisterNoMVo> getCan(CanisterNoMVo vo);
	public int saveCan(CanisterNoMVo vo);
	public int upCan(CanisterNoMVo vo);
	public int chkNo(CanisterNoMVo vo);
	public int delCan(CanisterNoMVo canisterNoMVo);

}
