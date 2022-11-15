package lims.sys.service;

import java.util.List;

import lims.sys.vo.InsttMVo;
import lims.sys.vo.MenuMVo;

public interface InsttMService {
	public List<InsttMVo> getInsttMList(InsttMVo vo);
	public int insInsttM(InsttMVo vo);
	public int updInsttM(InsttMVo vo);
}
