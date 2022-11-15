package lims.src.service;

import java.util.List;

import lims.src.vo.DataChartMVo;
import lims.test.vo.ResultInputMVo;

public interface DataChartMService {

	List<DataChartMVo> getDataChartList(DataChartMVo vo);

	List<ResultInputMVo> getDialogClickList(ResultInputMVo vo);
	
}
