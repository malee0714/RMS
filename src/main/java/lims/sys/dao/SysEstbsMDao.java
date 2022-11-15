package lims.sys.dao;

import java.util.List;

import lims.sys.vo.SysEstbsMVo;

public interface SysEstbsMDao {
	
	public List<SysEstbsMVo> getSysManage(SysEstbsMVo vo);
	
	public int updSysManage(SysEstbsMVo vo);
}
