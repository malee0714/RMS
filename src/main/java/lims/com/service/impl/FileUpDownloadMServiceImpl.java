package lims.com.service.impl;

import lims.com.dao.FileUpDownloadMDao;
import lims.com.service.FileUpDownloadMService;
import lims.com.vo.FileDetailMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.util.FasooExtract;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.net.URLEncoder;
import java.util.*;

@Service
@PropertySource("classpath:property/fileUploadPath.properties")
public class FileUpDownloadMServiceImpl implements FileUpDownloadMService {

	@Resource(name="fileUpDownloadMDao")
	private FileUpDownloadMDao fileUpDownloadDao;
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Value("${file.upload.path}")
	private String fileUploadPath;

	//파일 업로드(의뢰기관 등록)
	@Override
	public List<FileDetailMVo> uploadAction(String existFileIdx, String fileCtg, List<Integer> ordList, MultipartHttpServletRequest request) {
		FileDetailMVo fileVO = null;
		try {
			final List<MultipartFile> getFiles = request.getFiles("files");
			
			Assert.notNull(getFiles, "files is null");
			Assert.state(getFiles.size() > 0, "0 files exist");
	
			String uploadPath = getSaveDirPath(fileCtg);//업로드 폴더 경로 생성
			File saveFolder = new File(fileUploadPath+uploadPath);
			if (!saveFolder.exists() || saveFolder.isFile())//해당 경로에 폴더가 존재하지 않으면 폴더 생성
				saveFolder.mkdirs();
			
			UUID uid;//고유 파일명
			String filePath;//파일 경로
			String fileType;//파일 확장자
			HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			UserMVo UserMVo = commonFunc.getLoginUser(httpServletRequest);

			int fileIdx;
			if(!"".equals(existFileIdx))//이미 파일번호를 가진 의뢰기관이라면 해당 의뢰기관의 파일번호를 세팅
				fileIdx = Integer.parseInt(existFileIdx);
			else
				fileIdx = fileUpDownloadDao.getFileIdx();
			
			for(int i=0; i<getFiles.size(); i++){
				fileVO = new FileDetailMVo();
				MultipartFile entry = getFiles.get(i);
				
				if (!"".equals(entry.getOriginalFilename())) {
    				uid = UUID.randomUUID();//고유 파일명 랜덤 생성
    				
    				fileType = FilenameUtils.getExtension(entry.getOriginalFilename());
    				filePath = uploadPath + File.separator + uid + "." + fileType;//파일의 경로 설정
    				
    				fileVO.setAtchmnflSeqno(fileIdx);
    				fileVO.setOrginlFileNm(entry.getOriginalFilename());//파일명
    				fileVO.setFileMg(entry.getSize());//파일사이즈
    				fileVO.setLastChangerId(UserMVo.getUserId());
    				fileVO.setStreFileNm(filePath);

    				entry.transferTo(new File(fileUploadPath+filePath));//해당 경로에 파일 복사
    				fileUpDownloadDao.insUploadFiles(fileVO);
    				
    				FasooExtract fasooExtract = new FasooExtract();
    				fasooExtract.DoExtract(fileUploadPath+filePath);
    			}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 

		return fileUpDownloadDao.getFiles(fileVO);//업로드를 실행한 의뢰기관이 가진 파일 정보들을 리턴
	}
	
	//기존에 업로드한 파일 가져오기
	@Override
	public List<FileDetailMVo> getExistFiles(FileDetailMVo param) {
		return fileUpDownloadDao.getFiles(param);
	}
	
	//순서 저장
	@Override
	public int updReOrderFiles(List<FileDetailMVo> param) {
		int check = 0;
		for(int i=0; i<param.size(); i++){
//			param.get(i).setOrd(param.get(i).getOrd());
			check = fileUpDownloadDao.updReOrderFiles(param.get(i));
		}
		return check;
	}

	//파일 삭제
	@Override
	public int deleteFiles(List<FileDetailMVo> param) {
		int check = 0;
		for(int i=0; i<param.size(); i++){
			check = fileUpDownloadDao.deleteFiles(param.get(i));
		}
		return check;
	}
	
	@Override
	public void CuOrgMFileDownload(Map<String, Object> param, HttpServletResponse response) {
		FileDetailMVo vo = new FileDetailMVo();
		Map<String, String> map = new HashMap<String, String>();
		vo = fileUpDownloadDao.getDownloadFile(param);
		String fileName = vo.getOrginlFileNm();
		map.put("fileName", fileName);
		map.put("fileType", fileName.substring(fileName.indexOf("."), fileName.length()).replace(".", ""));
		map.put("filePath", fileUploadPath+vo.getStreFileNm());
		
		downloadAction(map, response);
	}

	/**
	 * 파일 다운로드
	 * @param fileData 파일명(fileName) ,파일확장자(fileType), 파일경로(filePath)를 담은 Map
	 */
	@Override
	public void downloadAction(Map<String, String> fileData, HttpServletResponse response) {

		try {
			String fileName = fileData.get("fileName");
			String fileType = fileData.get("fileType");
			String filePath = fileData.get("filePath");
			String docName = null;
			byte[] fileBytes = null;
			
			if (fileType.trim().equalsIgnoreCase("txt")) {
				response.setContentType("text/plain");
			} else if (fileType.trim().equalsIgnoreCase("doc")) {
				response.setContentType("application/msword");
			} else if (fileType.trim().equalsIgnoreCase("xls")) {
				response.setContentType("application/vnd.ms-excel");
			} else if (fileType.trim().equalsIgnoreCase("pdf")) {
				response.setContentType("application/pdf");
			} else if (fileType.trim().equalsIgnoreCase("ppt")) {
				response.setContentType("application/ppt");
			} else if(fileType.trim().equalsIgnoreCase("csv")) {
				response.setContentType("text/csv; charset=MS949");
			} else {
				response.setContentType("application/octet-stream");
			}

			docName = URLEncoder.encode(fileName, "UTF-8");
			response.setHeader("Content-Disposition", "attachment;filename=" + docName + ";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			
			if (filePath != null && !"".equals(filePath)) {
				File file = new File(filePath);
				if (file.isFile()) {
					fileBytes = FileUtils.readFileToByteArray(file);
				} else {
					if (fileData.containsKey("redirect") == false) {
						DragDropFileMServiceImpl dragDropFileMServiceImpl = new DragDropFileMServiceImpl();
						dragDropFileMServiceImpl.outerFileDownload(fileData, response);
					}
				}				
			}

			if (fileBytes != null && fileBytes.length > 0) {
				response.setContentLength(fileBytes.length);
				response.getOutputStream().write(fileBytes);
				response.getOutputStream().flush();
 				response.getOutputStream().close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//업로드 경로 생성
	public String getSaveDirPath(String fileCtg){
		Calendar cal = Calendar.getInstance();
		String folderYear;
		String folerMonth;
	    folderYear = String.format("%04d", cal.get(Calendar.YEAR));//현재 년-월에 해당하는 폴더명 설정
	    folerMonth = String.format("%02d", cal.get(Calendar.MONTH) + 1);//현재 년-월에 해당하는 폴더명 설정
		String uploadPath = fileCtg + File.separator  + folderYear + File.separator + folerMonth;
		
		return uploadPath;
	}
}
