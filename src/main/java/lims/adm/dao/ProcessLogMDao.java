package lims.adm.dao;

import java.util.List;

import lims.adm.vo.ProcessLogMVo;

public interface ProcessLogMDao {
	List<ProcessLogMVo> getProcessLogMList(ProcessLogMVo ProcessLogMVo);
}