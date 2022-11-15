package lims.wrk.dao;

import java.util.List;
import lims.wrk.vo.EntrpsFMVo;

public interface EntrpsFMDao {
	
	List<EntrpsFMVo> getEntrpsFMList(EntrpsFMVo EntrpsFMVo);
	public Integer insEntrpsFM(EntrpsFMVo vo);
	public int userValidationF(EntrpsFMVo vo);
	public Integer updEntrpsFM(EntrpsFMVo vo);
	public int insEntrpscFM(EntrpsFMVo vo);
	public Integer deleteEntrpsFM(EntrpsFMVo vo);
	List<EntrpsFMVo> getEntrpscFMList(EntrpsFMVo EntrpsFMVo);
	public Integer updEntrpscFM(EntrpsFMVo vo);
	public Integer delEntrpscFM(EntrpsFMVo vo);
	public int chkEntrpInfo(EntrpsFMVo vo);
}
