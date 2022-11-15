package lims.src.dao;

import java.util.List;

import lims.src.vo.DataChartMVo;
import lims.test.vo.ResultInputMVo;

public interface DataChartMDao {

	List<DataChartMVo> getDataChartList(DataChartMVo vo);

	List<ResultInputMVo> getDialogClickList(ResultInputMVo vo);
}
