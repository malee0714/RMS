package lims.sys.service;

import java.util.List;

import lims.sys.vo.NoticeWriteMVo;

public interface NoticeWriteMService {
	public List<NoticeWriteMVo> getBbsCode(NoticeWriteMVo vo);
	public List<NoticeWriteMVo> getNoticeWriteMList(NoticeWriteMVo vo);
	public NoticeWriteMVo getNoticeAnswerM(NoticeWriteMVo vo);
	public int saveNoticeWriteM(NoticeWriteMVo vo);
	public int countNoticeWriteM(NoticeWriteMVo vo);
	public int saveNoticeAnswerM(NoticeWriteMVo vo);
}
