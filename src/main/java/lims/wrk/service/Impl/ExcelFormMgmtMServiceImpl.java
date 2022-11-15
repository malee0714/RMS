package lims.wrk.service.Impl;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialException;


import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import lims.com.service.CommonService;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.wrk.dao.ExcelFormMgmtMDao;
import lims.wrk.service.ExcelFormMgmtMService;
import lims.wrk.vo.ExcelFormMgmtMVo;

@Service
public class ExcelFormMgmtMServiceImpl implements ExcelFormMgmtMService{
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;


	@Autowired
	private ExcelFormMgmtMDao excelFormMgmtMDao;

	@Override
	public List<ExcelFormMgmtMVo> getExcelForm(ExcelFormMgmtMVo vo){
		return excelFormMgmtMDao.getExcelForm(vo);
	}

	@Override
	public List<ExcelFormMgmtMVo> getExcelInfo(ExcelFormMgmtMVo vo){
		return excelFormMgmtMDao.getExcelInfo(vo);
	}

	@Override
	public int exUpload(MultipartHttpServletRequest request) {

		ObjectMapper mapper = new ObjectMapper();

		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		String param = (String) request.getParameter("param"); //그리드 값
		String excelSeqno = (String) request.getParameter("excelSeqno"); //시퀀스
	    String celSeqno = (String) request.getParameter("celSeqno"); //셀번호

		ExcelFormMgmtMVo excelFormMgmtMVo = new ExcelFormMgmtMVo();
		excelFormMgmtMVo.setRm((String) request.getParameter("rm")); //비고
		excelFormMgmtMVo.setExcelFormNm((String) request.getParameter("excelFormNm")); //양식명
		excelFormMgmtMVo.setSheetChoiseNm((String) request.getParameter("sheetChoiseNm")); //작업시트명
		excelFormMgmtMVo.setSheetPrntngNm((String) request.getParameter("sheetPrntngNm")); //인쇄시트명
		excelFormMgmtMVo.setUseAt((String) request.getParameter("useAt")); //사용 여부

	    try {
			if(commonFunc.isEmpty(excelSeqno)) {
				//신규
				MultipartFile file = multi.getFile("formFile");
				String excelFileNm = file.getOriginalFilename();

				excelFormMgmtMVo.setData(file.getBytes());
				excelFormMgmtMVo.setFileData(file.getBytes());
				excelFormMgmtMVo.setExcelFileNm(excelFileNm);
				excelFormMgmtMVo.setHistVer("0");
				excelFormMgmtMDao.saveExFile(excelFormMgmtMVo); //엑셀파일관리 저장(비고)
				excelFormMgmtMDao.saveExVer(excelFormMgmtMVo); //버전 저장 무조건 INSERT
				//엑셀셀관리 저장
				List<HashMap<String, Object>> myObjects =
						mapper.readValue(param, new TypeReference<List<HashMap<String, Object>>>(){});
				for(int i=0; i<myObjects.size(); i++) {
					myObjects.get(i).put("excelSeqno", excelFormMgmtMVo.getExcelSeqno());
					myObjects.get(i).put("useAt", excelFormMgmtMVo.getUseAt());
					excelFormMgmtMDao.saveExForm(myObjects.get(i));
				}
			} else {
				if (!commonFunc.isEmpty((String) request.getParameter("histVer"))) {
					//파일추가(버전 업데이트)
					MultipartFile file = multi.getFile("formFile");
					String excelFileNm = file.getOriginalFilename();

					excelFormMgmtMVo.setData(file.getBytes());
					excelFormMgmtMVo.setFileData(file.getBytes());
					excelFormMgmtMVo.setExcelFileNm(excelFileNm);
					excelFormMgmtMVo.setExcelSeqno(excelSeqno);
					excelFormMgmtMVo.setHistVer((String) request.getParameter("histVer"));
					excelFormMgmtMDao.upDataExFile(excelFormMgmtMVo); //엑셀파일관리 업데이트  (비고) --> 버전 + 1
					excelFormMgmtMDao.saveExVer(excelFormMgmtMVo); //버전 저장
				} else {
					//파일 없이 그리드 값, 폼 값 변경할때
					excelFormMgmtMVo.setExcelSeqno(excelSeqno);
					excelFormMgmtMVo.setCelSeqno(celSeqno);
					excelFormMgmtMDao.upExFile(excelFormMgmtMVo); //엑셀 양식 폼 수정
				}

				List<HashMap<String, Object>> list =
						mapper.readValue(param, new TypeReference<List<HashMap<String, Object>>>() {});
				if(list.size() > 0) {
					list.forEach(v -> {
						v.put("excelSeqno", excelFormMgmtMVo.getExcelSeqno());
						if (commonFunc.isEmpty(v.get("celSeqno")))
							excelFormMgmtMDao.saveExForm(v); // 엑셀 셀관리 (그리드값) 저장
						else
							excelFormMgmtMDao.upExForm(v); // 엑셀 셀관리 업데이트);
					});
				}
			}
		} catch(Exception e) {
	    	e.printStackTrace();
		}
		return 1;
	}

	@Override
	public void getExDownload(Map<String, Object> param, HttpServletResponse response) {

		ExcelFormMgmtMVo fileVo = new ExcelFormMgmtMVo();
		fileVo = excelFormMgmtMDao.getDownFile(param);
		String excelFileNm = fileVo.getExcelFileNm();
		String docName = null;
		ExcelFormMgmtMVo fileInfo = null;
		InputStream is = null;

	    try {
            ExcelFormMgmtMVo param2 = new ExcelFormMgmtMVo();
            String excelSeqno = fileVo.getExcelSeqno();
            param2.setExcelSeqno(excelSeqno);

            fileInfo = fileVo = excelFormMgmtMDao.getDownFile(param);
            response.setContentType("application/vnd.ms-excel");
            docName = URLEncoder.encode(excelFileNm, "UTF-8");
			response.setHeader("Content-Disposition", "attachment;filename=" + docName + ";");
			response.setHeader("Content-Transfer-Encoding", "binary");

            is = new ByteArrayInputStream(fileInfo.getData());
            ServletOutputStream os = response.getOutputStream();

            int binaryRead;
            while((binaryRead = is.read()) != -1) {
                os.write(binaryRead);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

	@Override
	public int delCelForm(List <ExcelFormMgmtMVo> list) {
		int count = 0;
		if(list.isEmpty())
			return count;

		for(int i=0; i<list.size(); i++)
			count = excelFormMgmtMDao.delCelForm(list.get(i));

		return count;
	}
}
