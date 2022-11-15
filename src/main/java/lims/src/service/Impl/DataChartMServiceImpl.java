package lims.src.service.Impl;


import java.util.List;

import lims.test.vo.ResultInputMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.src.dao.DataChartMDao;
import lims.src.service.DataChartMService;
import lims.src.vo.DataChartMVo;

@Service
public class DataChartMServiceImpl implements DataChartMService {

	@Autowired
	private DataChartMDao dataChartMDao;

	@Override
	public List<DataChartMVo> getDataChartList(DataChartMVo vo) {
		
		return dataChartMDao.getDataChartList(vo);
		
	}

	@Override
	public List<ResultInputMVo> getDialogClickList(ResultInputMVo vo) {
		// TODO Auto-generated method stub
		return dataChartMDao.getDialogClickList(vo);
	}

}
