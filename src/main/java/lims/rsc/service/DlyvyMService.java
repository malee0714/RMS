package lims.rsc.service;

import java.util.HashMap;
import java.util.List;

import lims.rsc.vo.DlyvyMVo;

public interface DlyvyMService {
	public List<DlyvyMVo> getBacode(DlyvyMVo vo);
	public int updateBrcd(List<DlyvyMVo> vo);
	public List<DlyvyMVo> getPopupBrcd(DlyvyMVo vo);
}
