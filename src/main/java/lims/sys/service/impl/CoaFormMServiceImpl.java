package lims.sys.service.impl;

import lims.sys.dao.CoaFormMDao;
import lims.sys.service.CoaFormMService;
import lims.sys.vo.CoaFormMVo;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.List;

@Service
public class CoaFormMServiceImpl implements CoaFormMService{

	@Autowired
	private CoaFormMDao coaFormMDao;

	@Value("${file.coa.upload.path}")
	private String fileUploadPath;

	@Override
	public List<CoaFormMVo> getCoaFormMList(CoaFormMVo vo) {
		List<CoaFormMVo> list = coaFormMDao.getCoaFormMList(vo);
		return list;
	}

	@Override
	public int saveCoaFormM(MultipartHttpServletRequest request) {

		//PRINTNG_SEQNO = O, HIST_VER = O : 내용 수정
		//PRINTNG_SEQNO = O, HIST_VER = null : 내용 수정, 첨부파일 수정
		//PRINTNG_SEQNO = null, HIST_VER = null : 신규 등록

		int printngSeqNo = 0;

		try {

			//출력물 등록 및 수정 정보
			CoaFormMVo printngMVo = new CoaFormMVo();
			printngMVo.setPrintngNm(String.valueOf(request.getParameter("printngNm")));
			printngMVo.setPrintngUploadFileNm(String.valueOf(request.getParameter("printngUploadFileNm")));
			printngMVo.setEntrpsSeqno(String.valueOf(request.getParameter("entrpsSeqno")));
			printngMVo.setMtrilSeqno(String.valueOf(request.getParameter("mtrilSeqno")));
			printngMVo.setCtmmnyMtrilCode(String.valueOf(request.getParameter("ctmmnyMtrilCode")));
			printngMVo.setAvrgApplcAt(String.valueOf(request.getParameter("avrgApplcAt")));
			printngMVo.setRm(String.valueOf(request.getParameter("rm")));
			printngMVo.setUseAt(String.valueOf(request.getParameter("useAt")));
			printngMVo.setBplcCode(String.valueOf(request.getParameter("bplcCode")));
			printngMVo.setDwldFileSeCode(String.valueOf(request.getParameter("dwldFileSeCode")));

			String printngSeqnoChk = request.getParameter("printngSeqno");
			String histVerChk = request.getParameter("histVer");
			
			//신규등록하거나 첨부파일을 수정하는 경우
			if ("".equals(printngSeqnoChk) || (!"".equals(printngSeqnoChk) && !"".equals(histVerChk))) {
				//현재 년-월에 해당하는 폴더명 설정
				Calendar cal = Calendar.getInstance();
				String folderYear = String.format("%04d", cal.get(Calendar.YEAR));
				String folderMonth = String.format("%02d", cal.get(Calendar.MONTH) + 1);
				String uploadPath = File.separator  + folderYear + File.separator + folderMonth;

				File saveFolder = new File(fileUploadPath + uploadPath);
				if (!saveFolder.exists() || saveFolder.isFile())
					saveFolder.mkdirs();

				MultipartFile multipartFile = request.getFile("formFile");
				String uid = String.valueOf(java.util.UUID.randomUUID());
				String fileType = FilenameUtils.getExtension(multipartFile.getOriginalFilename());
				String filePath = uploadPath + File.separator + uid + "." + fileType;
				multipartFile.transferTo(new File(fileUploadPath + filePath));

				printngMVo.setPrintngOrginlFileNm(multipartFile.getOriginalFilename());
				printngMVo.setPrintngCours(filePath);
				
				if ("".equals(printngSeqnoChk)) { //신규등록
					printngMVo.setHistVer("1");
					coaFormMDao.insCoaFormM(printngMVo); //COA양식 등록
					coaFormMDao.insCoaFormHistM(printngMVo); //COA양식 이력 등록
				} else { //COA양식 수정, 첨부파일 수정
					printngMVo.setPrintngSeqno(String.valueOf(request.getParameter("printngSeqno")));
					printngMVo.setHistVer(String.valueOf(coaFormMDao.getMaxHistVer(printngMVo)));
					coaFormMDao.updCoaFormM(printngMVo); //COA양식 수정, 첨부파일 수정
					coaFormMDao.insCoaFormHistM(printngMVo); //COA양식 이력 등록
				}
			} else { //첨부파일 변경 없이 COA양식 정보 수정
				printngMVo.setPrintngSeqno(String.valueOf(request.getParameter("printngSeqno")));
				coaFormMDao.updCoaFormM(printngMVo); 
			}

			printngSeqNo = Integer.parseInt(printngMVo.getPrintngSeqno());

		} catch(Exception e) {
			e.printStackTrace();
		}

		return printngSeqNo;
	}

	@Override
	public int deleteCoaFormM(CoaFormMVo vo) {
		return coaFormMDao.deleteCoaFormM(vo);
	}

	@Override
	public void getCoaDownload(String printngSeqno, String histVer, HttpServletResponse response) {

		try {

			CoaFormMVo vo =  coaFormMDao.getCoaFormSeqnoInfo(printngSeqno);
			String fileName = vo.getPrintngOrginlFileNm();
			String filePath = vo.getPrintngCours();
			String docName = URLEncoder.encode(fileName, "UTF-8");

			InputStream is = null;

			response.setHeader("Content-Type","mrd");
			response.setHeader("Content-Disposition", "attachment; filename=" + docName + ";");
			response.setHeader("Content-Transfer-Encoding", "binary");

			File file = new File(fileUploadPath + filePath);
			is = new ByteArrayInputStream(FileUtils.readFileToByteArray(file));
			ServletOutputStream os = response.getOutputStream();
            int binaryRead;

            while ((binaryRead = is.read()) != -1)    {
                os.write(binaryRead);
            }

		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
