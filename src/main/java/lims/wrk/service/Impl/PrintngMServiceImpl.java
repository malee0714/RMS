package lims.wrk.service.Impl;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.wrk.dao.PrintngMDao;
import lims.wrk.service.PrintngMService;
import lims.wrk.vo.PrintngMVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PrintngMServiceImpl implements PrintngMService{

	@Autowired
    private PrintngMDao printngMDao;

	@Value("${file.rd.upload.path}")
	private String fileUploadPath;

	@Override
	public List<PrintngMVO> getPrintngMList(PrintngMVO vo) {
		return printngMDao.getPrintngMList(vo);
	}
	
	@Override
	public int savePrintngM(MultipartHttpServletRequest request) {

		// PRINTNG_SEQNO = O, HIST_VER = O : 내용,첨부파일 수정
		// PRINTNG_SEQNO = O, HIST_VER = null : 내용만 수정
		// PRINTNG_SEQNO = null, HIST_VER = null : 신규 등록

		try {

			// 출력물 등록 및 수정 정보
			PrintngMVO printngMVo = new PrintngMVO();
			printngMVo.setPrintngNm(String.valueOf(request.getParameter("printngNm")));
			printngMVo.setPrintngUploadFileNm(String.valueOf(request.getParameter("printngUploadFileNm")));
			printngMVo.setRm(String.valueOf(request.getParameter("rm")));
			printngMVo.setUseAt(String.valueOf(request.getParameter("useAt")));

			
			String printngSeqnoChk = request.getParameter("printngSeqno");
			String histVerChk = request.getParameter("histVer");
			
			// 신규 or 내용,첨부파일 수정인 경우
			if("".equals(printngSeqnoChk)  || (!"".equals(printngSeqnoChk) && !"".equals(histVerChk))) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("printngUploadFileNm", printngMVo.getPrintngUploadFileNm());
				if(!"".equals(printngSeqnoChk)) { // update할 때만 seqno put
					map.put("printngSeqno", String.valueOf(printngSeqnoChk));
				}
				
				int chk = printngMDao.chkPrintngFileNm(map); // 출력물 파일명 중복여부 체크
				if(chk == 0) {
					Calendar cal = Calendar.getInstance();
					String folderYear = String.format("%04d", cal.get(Calendar.YEAR)); // 현재 년-월에 해당하는 폴더명 설정
					String folerMonth = String.format("%02d", cal.get(Calendar.MONTH) + 1); // 현재 년-월에 해당하는 폴더명 설정
					String name = printngMVo.getPrintngUploadFileNm();
					int index = name.lastIndexOf(".");
					String name2 = name.substring(0,index);
					String uploadPath ='/'+name2+ '/'  + folderYear + '/' + folerMonth; // 년-월

					File saveFolder = new File(fileUploadPath + uploadPath);
					log.debug("생성 경로 >>>>>>>>>>>>>>>"+fileUploadPath + uploadPath);
					
					log.debug("저장 경로 >>>>>>>"+saveFolder);

					if (!saveFolder.exists() || saveFolder.isFile())
						saveFolder.mkdirs();

					MultipartFile multipartFile = request.getFile("formFile"); // 다중 업로드할 파일들

					if("".equals(printngSeqnoChk)) {
						printngMVo.setHistVer("1");
					}
					else{
						printngMVo.setPrintngSeqno(printngSeqnoChk);
						printngMVo.setHistVer(String.valueOf(printngMDao.getMaxHistVer(printngMVo))); // 출력물 버전 +1
					}
					
					String fileName = name2+"_"+printngMVo.getHistVer();
					String fileType = FilenameUtils.getExtension(multipartFile.getOriginalFilename()); // 파일명에서 파일 확장자 추출
					String filePath = uploadPath + "/" + fileName + "." + fileType;
					
					log.debug(">>>>>>>>>>>>>>>>명칭변경"+fileUploadPath + filePath);
					multipartFile.transferTo(new File(fileUploadPath + filePath)); // 업로드한 파일을 지정한 파일(경로)로 저장 
					
					// 파일명, 경로 set
					printngMVo.setPrintngOrginlFileNm(multipartFile.getOriginalFilename());
					printngMVo.setPrintngCours(filePath);

					if("".equals(printngSeqnoChk)) {
						printngMDao.insPrintngM(printngMVo); // 신규등록
						printngMDao.insPrintngHistM(printngMVo); // 출력물 이력 등록 (버전 1)
					} else {
						printngMVo.setPrintngSeqno(String.valueOf(request.getParameter("printngSeqno")));
						printngMDao.updPrintngM(printngMVo); // 내용 수정, 첨부파일 수정
						printngMDao.insPrintngHistM(printngMVo); // 출력물 이력 등록
					}
				}else {
					return 0; // 업로드 파일명 중복체크에 걸림
				}
				
			}else {
				printngMVo.setPrintngSeqno(String.valueOf(request.getParameter("printngSeqno")));
				printngMDao.updPrintngM(printngMVo); // 첨부파일 변경 없이 출력물 내용 수정
			}

		} catch(Exception e) {
			e.printStackTrace();
		}

		return 1;
	}

	@Override
	public int deletePrintngM(PrintngMVO vo) {
		return printngMDao.deletePrintngM(vo);
	}

	@Override
	public void getRdDownload(String printngSeqno, String histVer, HttpServletResponse response) {

		try {

			PrintngMVO vo =  printngMDao.getPrintngSeqnoInfo(printngSeqno);
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