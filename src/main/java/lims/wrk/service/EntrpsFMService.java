package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.EntrpsFMVo;
import lims.wrk.vo.EntrpsMVo;

public interface EntrpsFMService {
	public int userValidationF(EntrpsFMVo vo);
	List<EntrpsFMVo> getEntrpsFMList(EntrpsFMVo EntrpsFMVo);
	public Integer insEntrpsFM(EntrpsFMVo EntrpsFMVo);
	public Integer deleteEntrpsFM(EntrpsFMVo EntrpsFMVo);
	public Integer updEntrpsFM(EntrpsFMVo EntrpsFMVo);
//	public int insEntrpscFM(List<EntrpsFMVo> vo);
	List<EntrpsFMVo> getEntrpscFMList(EntrpsFMVo EntrpsFMVo);

}