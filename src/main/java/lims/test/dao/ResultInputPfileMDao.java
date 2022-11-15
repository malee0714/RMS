package lims.test.dao;

import java.util.List;

import lims.test.vo.ResultInputPfileMVo;

public interface ResultInputPfileMDao {

	public String getSittnCode(ResultInputPfileMVo pfileVo);
	public String getReqSeqno(ResultInputPfileMVo pfileVo);
	public String getReqestExpriemSeqno(ResultInputPfileMVo pfileVo);
	
	public int saveGo(ResultInputPfileMVo pfileVo);



}
