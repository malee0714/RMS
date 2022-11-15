package lims.sys.dao;

import java.util.List;
import java.util.Map;

import lims.sys.vo.NoticeMVo;


public interface NoticeMDao {
	public List<NoticeMVo> getNoticeMList(NoticeMVo vo);
	public int insNoticeM(NoticeMVo vo);
	public int updNoticeM(NoticeMVo vo);

}
