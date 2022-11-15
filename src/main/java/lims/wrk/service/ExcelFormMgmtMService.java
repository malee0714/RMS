package lims.wrk.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.wrk.vo.ExcelFormMgmtMVo;

public interface ExcelFormMgmtMService {

	//엑셀 상세 조회
	public List<ExcelFormMgmtMVo> getExcelForm(ExcelFormMgmtMVo vo);

	//엑셀 조회
	public List<ExcelFormMgmtMVo> getExcelInfo(ExcelFormMgmtMVo vo);

	//엑셀 업로드 및 업데이트 까지 포함
	public int exUpload(MultipartHttpServletRequest request);

	//엑셀 다운로드
	public void getExDownload(Map<String, Object> param,HttpServletResponse response);

	//그리드 행삭제
	public int delCelForm(List<ExcelFormMgmtMVo> list);

}
