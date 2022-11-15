package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.CLManageMVo;

public interface CLManageMService {
	public List<CLManageMVo> getCLManageList(CLManageMVo vo);
	public int updateCLM(List<CLManageMVo> list);
}
