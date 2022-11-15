package lims.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.sys.dao.SysEstbsMDao;
import lims.sys.service.SysEstbsMService;
import lims.sys.vo.SysEstbsMVo;

@Service
public class SysEstbsMServiceImpl implements SysEstbsMService {
	
	@Autowired
	private SysEstbsMDao sysEstbsMDao;
	
	@Override
	public List<SysEstbsMVo> getSysManage(SysEstbsMVo vo) {
		return sysEstbsMDao.getSysManage(vo);
	}
	
	@Override
	public int updSysManage(SysEstbsMVo vo) {
		return sysEstbsMDao.updSysManage(vo);
	}
}
