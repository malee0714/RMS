package lims.src.dao;

import java.util.List;

import lims.src.vo.PedigeeMVo;
import lims.sys.vo.InsttMVo;
import lims.test.vo.IssueMVo;

public interface PedigeeRealMDao {
	public List<PedigeeMVo> getUpperReqestPedigee(PedigeeMVo vo);
}
