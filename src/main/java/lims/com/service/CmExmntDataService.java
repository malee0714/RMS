package lims.com.service;

import lims.com.vo.CmExmntDto;

import java.util.List;

public interface CmExmntDataService {

	List<CmExmntDto> getExmntHistory(CmExmntDto cmExmntDto);
}
