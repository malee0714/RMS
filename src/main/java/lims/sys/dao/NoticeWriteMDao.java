package lims.sys.dao;

import java.util.List;

import lims.sys.vo.NoticeWriteMVo;


public interface NoticeWriteMDao {
	public List<NoticeWriteMVo> getBbsCode(NoticeWriteMVo vo);
	public List<NoticeWriteMVo> getNoticeWriteMList(NoticeWriteMVo vo);
	public int insNoticeWriteM(NoticeWriteMVo vo);
	public int updNoticeWriteM(NoticeWriteMVo vo);
	public int delNoticeWriteM(NoticeWriteMVo vo);
	public int countNoticeWriteM(NoticeWriteMVo vo);
	public NoticeWriteMVo getNoticeAnswerM(NoticeWriteMVo vo);
	public int insNoticeAnswerM(NoticeWriteMVo vo);
	public int updNoticeAnswerM(NoticeWriteMVo vo);
	public int delNoticeAnswerM(NoticeWriteMVo vo);
	public String chkLoginAuthor();
}
