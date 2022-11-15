package lims.wrk.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lims.wrk.vo.ExcelFormMgmtMVo;

public interface ExcelFormMgmtMDao {

	public List<ExcelFormMgmtMVo> getExcelForm(ExcelFormMgmtMVo vo);

	public List<ExcelFormMgmtMVo> getExcelInfo(ExcelFormMgmtMVo vo);

	public int saveExForm(HashMap<String, Object> map);

	public int saveExVer(ExcelFormMgmtMVo excelFormMgmtMVo);

	public int saveExFile(ExcelFormMgmtMVo excelFormMgmtMVo);

	public ExcelFormMgmtMVo getDownFile(Map<String, Object> param);

	public int upExForm(HashMap<String, Object> hashMap);

	public int upExFile(ExcelFormMgmtMVo excelFormMgmtMVo);

	public int delCelForm(ExcelFormMgmtMVo excelFormMgmtMVo);

	public int upDataExFile(ExcelFormMgmtMVo excelFormMgmtMVo);

}
