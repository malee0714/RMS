package lims.com.service.impl;

import lims.com.dao.CmExmntDao;
import lims.com.service.CmExmntDataService;
import lims.com.vo.CmExmntDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CmExmntDataServiceImpl implements CmExmntDataService {

	private final CmExmntDao cmExmntDao;

	@Autowired
	public CmExmntDataServiceImpl(CmExmntDao cmExmntDao) {
		this.cmExmntDao = cmExmntDao;
	}

	@Override
	public List<CmExmntDto> getExmntHistory(CmExmntDto cmExmntDto) {
		return cmExmntDao.getExmntHistory(cmExmntDto);
	}
}
