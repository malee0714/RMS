package lims.rsc.service;

import java.util.HashMap;
import java.util.List;

import lims.rsc.vo.DsuseMVo;

public interface DsuseMService {
	public List<DsuseMVo> getDsuseBacode(DsuseMVo vo);
	public int insDsuseBacode (List<DsuseMVo> vo);
}
