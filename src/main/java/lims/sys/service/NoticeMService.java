package lims.sys.service;

import java.util.List;

import lims.sys.vo.NoticeMVo;

public interface NoticeMService {
	public List<NoticeMVo> getNoticeMList(NoticeMVo vo);
	public int saveNoticeM(List<NoticeMVo> vo);
	
}
