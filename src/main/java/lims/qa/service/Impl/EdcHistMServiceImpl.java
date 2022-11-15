package lims.qa.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.qa.dao.EdcHistMDao;
import lims.qa.service.EdcHistMService;
import lims.qa.vo.EdcManageDto;

@Service
public class EdcHistMServiceImpl implements EdcHistMService {

    private final EdcHistMDao edcHistMDao;

    @Autowired
    public EdcHistMServiceImpl(EdcHistMDao edcHistMDao) {
        this.edcHistMDao = edcHistMDao;
    }
    
    @Override
    public List<EdcManageDto> getEdcAllList(EdcManageDto edcManageDto) {
    	return edcHistMDao.getEdcAllList(edcManageDto);
    }
    
    
}
