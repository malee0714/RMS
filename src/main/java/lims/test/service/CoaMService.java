package lims.test.service;

import lims.com.vo.ComboVo;
import lims.test.vo.CoaMVo;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public interface CoaMService {
	List<CoaMVo> getCoaList(CoaMVo vo);
	HashMap<String, String> createExcelSample(List<CoaMVo> list, HttpServletResponse response);
	Map<String, String> getExpriemXls(List<CoaMVo> list, HttpServletResponse response);
	Map<String, String> insCoaInfo(List<CoaMVo> list, HttpServletResponse response);
	List<CoaMVo> getReqUpperLotList(CoaMVo vo);
	List<CoaMVo> getCoaUpperList(CoaMVo vo);
	List<CoaMVo> getEntrpsListHasPrint(CoaMVo vo);
	List<ComboVo> getEntrpsPrintCombo(CoaMVo vo);
	CoaMVo getEntrpsPrintInfo(CoaMVo vo);
	int delCoaList(List<CoaMVo> list);

}
