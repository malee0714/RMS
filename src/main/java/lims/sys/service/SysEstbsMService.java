package lims.sys.service;

import java.util.List;

import lims.sys.vo.SysEstbsMVo;

public interface SysEstbsMService {
	
	public List<SysEstbsMVo> getSysManage(SysEstbsMVo vo);
	
	public int updSysManage(SysEstbsMVo vo);
}
