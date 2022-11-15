package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.EntrpsMDto;
import lims.wrk.vo.EntrpsMVo;

public interface EntrpsMService {
	
	List<EntrpsMDto> getEntrpsMList(EntrpsMVo EntrpsMVo);
	
	public void saveEntrpsM(EntrpsMDto vo);
	
	public int entrpsNmValidation(EntrpsMDto vo);
	
}