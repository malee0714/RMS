package lims.com.service.impl;

import lims.com.dao.DragDropFileMDao;
import lims.com.service.DragDropFileMService;
import lims.com.vo.FileDetailMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DragDropFileMServiceImpl implements DragDropFileMService{
	
	@Resource(name="dragDropFileMDao")
	DragDropFileMDao dragDropFileDao;
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Value("${file.upload.path}")
	private String fileUploadPath;

	@Override
	public List<FileDetailMVo> getFiles(FileDetailMVo param) {
		List<FileDetailMVo> files = dragDropFileDao.getFiles(param);
		return files;
	}
	
	//프로젝트 선택 시 서버에 저장된 이미지 호출
	public void getImage(String filePath, HttpServletRequest request, HttpServletResponse response){
		String fileType = null;
		byte[] fileBytes = null;
		
		try {
			
			filePath = fileUploadPath + filePath;
			if(filePath != null && !"".equals(filePath)) {
				File file = new File(filePath);
				if(file.exists() == false){
					//DB에서 꺼내온 해당 파일의 경로에 실제 파일이 존재하지 않으면 기본이미지를 가져옴
					filePath = request.getSession().getServletContext().getRealPath("/assets/image/defaultImg300x300.png");
					file = new File(filePath);
				}
				fileBytes = FileUtils.readFileToByteArray(file);
				
				fileType = filePath.substring(filePath.lastIndexOf(".")+1, filePath.length());
				response.setContentLengthLong((file.length()));
				if(fileType.trim().equalsIgnoreCase("jpg")){
					response.setContentType("image/jpeg");
				} else 	if(fileType.trim().equalsIgnoreCase("jpeg")){
					response.setContentType("image/jpeg");		
				} else	if(fileType.trim().equalsIgnoreCase("gif")){
					response.setContentType("image/gif");
				} else 	if(fileType.trim().equalsIgnoreCase("png")){
					response.setContentType("image/png");
				} 
				response.setHeader("Content-Transfer-Encoding", "binary");
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

	@Override
	public int uploadAction(int fileIdx, MultipartHttpServletRequest request) {
		try {
			
			FileDetailMVo fileVO = null;
			final List<MultipartFile> getFiles = request.getFiles("files");
			final String[] uuids = request.getParameterValues("uuids");
			
			if( getFiles.size() > 0 ){
				Assert.notNull(getFiles, "files is null");
				Assert.state(getFiles.size() > 0, "0 files exist");
	
				String uploadPath = getSaveDirPath();//업로드 폴더 경로 생성
				File saveFolder = new File(fileUploadPath+uploadPath);
				if (!saveFolder.exists() || saveFolder.isFile())//해당 경로에 폴더가 존재하지 않으면 폴더 생성
					saveFolder.mkdirs();
				
				String uid;//고유 파일명
				String filePath;//파일 경로
				String fileType;//파일 확장자
				HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
				UserMVo UserMVo = commonFunc.getLoginUser(httpServletRequest);
	
				fileIdx = fileIdx != 0 ? fileIdx :  dragDropFileDao.getFileIdx();
					
				for(int i=0; i<getFiles.size(); i++){
					fileVO = new FileDetailMVo();
					MultipartFile entry = getFiles.get(i);
					
					if (!"".equals(entry.getOriginalFilename())) {						
	    				uid = uuids[i];
	    				
	    				fileType = FilenameUtils.getExtension(entry.getOriginalFilename());
	    				filePath = uploadPath + File.separator + uid + "." + fileType;//파일의 경로 설정  				
	    				fileVO.setAtchmnflSeqno(fileIdx);
	    				fileVO.setOrginlFileNm(entry.getOriginalFilename());//파일명
	    				fileVO.setFileMg(entry.getSize());//파일사이즈
	    				fileVO.setLastChangerId(UserMVo.getUserId());
	    				fileVO.setStreFileNm(filePath);
	
	    				entry.transferTo(new File(fileUploadPath+filePath));//해당 경로에 파일 복사
	    				dragDropFileDao.insUploadFiles(fileVO);
	    				
//	    				httpServletRequest.getRequestURL().toString().indexOf("/chart")
//  	    				FasooExtract fasooExtract = new FasooExtract();
//	    				fasooExtract.DoExtract(fileUploadPath+filePath);
	    			}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			fileIdx = -1;
			return fileIdx;
		} 
		
		return fileIdx;
	}
	



	
	//업로드 경로 생성
	public String getSaveDirPath(){
		Calendar cal = Calendar.getInstance();
		String folderYear;
		String folerMonth;
	    folderYear = String.format("%04d", cal.get(Calendar.YEAR));//현재 년-월에 해당하는 폴더명 설정
	    folerMonth = String.format("%02d", cal.get(Calendar.MONTH) + 1);//현재 년-월에 해당하는 폴더명 설정
		String uploadPath = File.separator  + folderYear + File.separator + folerMonth;
		
		return uploadPath;
	}
	
	
	//파일 다운로드에 필요한 파일 정보 세팅
	@Override
	public void setDownloadData(Map<String, Object> param, HttpServletResponse response) {
		FileDetailMVo vo = new FileDetailMVo();
		Map<String, String> map = new HashMap<String, String>();
		vo = dragDropFileDao.getDownloadFile(param);
		String fileName = vo.getOrginlFileNm();
		map.put("fileName", fileName);
		map.put("fileType", fileName.substring(fileName.indexOf("."), fileName.length()).replace(".", ""));
		map.put("filePath", fileUploadPath + vo.getStreFileNm());
		map.put("streFilePath", vo.getStreFileNm());
		
		downloadAction(map, response);
	}
	
	/**
	 * 파일 다운로드 공통
	 * @param fileData 파일명(fileName) ,파일확장자(fileType), 파일경로(filePath)를 담은 Map
	 */
	@Override
	public void downloadAction(Map<String, String> fileData, HttpServletResponse response) {
		try{
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
						outerFileDownload(fileData, response);
					}
				}

			}
			if (fileBytes != null && fileBytes.length > 0) {
				response.setContentLength(fileBytes.length);
				response.getOutputStream().write(fileBytes);
				response.getOutputStream().flush();
				response.getOutputStream().close();
			}
		} catch (Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * 외부서버 파일 업로드후 다운로드
	 * @param fileData
	 * @param response
	 */
	public void outerFileDownload(Map<String, String> fileData, HttpServletResponse response){
		OutputStream outStream = null;
        URLConnection uCon = null; 
        InputStream is = null;
        HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
        
		try{
			String filePath = "";
			String uploadPath = fileUploadPath + fileData.get("streFilePath");
			String domain = String.valueOf(request.getRequestURL());
			
			String[] uploadArray = fileData.get("streFilePath").split("\\\\");
			
			filePath = "203.229.218.224:23001/AttachFile" + "/File" + fileData.get("streFilePath");
			
			byte[] buf;
			int byteRead;
			int bufferSize = 1024;
			URL url = new URL("http://"+filePath.replaceAll("\\\\", "/"));
			
			String saveDirPath = fileUploadPath + "\\" + uploadArray[1] + "\\" + uploadArray[2] + "\\";//업로드 폴더 경로 생성
			File saveFolder = new File(saveDirPath);
			
			//해당 경로에 폴더가 존재하지 않으면 폴더 생성
			if (!saveFolder.exists() || saveFolder.isFile()){
				saveFolder.mkdirs();
			}
				
			uCon = url.openConnection();
			is = uCon.getInputStream();
			buf = new byte[bufferSize];
						
			outStream = new BufferedOutputStream(new FileOutputStream(uploadPath));
			
			while ((byteRead = is.read(buf)) != -1) {
				outStream.write(buf, 0, byteRead); 
			}
			
			fileData.put("redirect", "true");
			outStream.close();
			is.close();
			
            downloadAction(fileData, response);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				outStream.close();
				is.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
		
	
	
	@Override
	public int deleteAction( FileDetailMVo param, HttpServletRequest request) {
		
		UserMVo UserMVo = commonFunc.getLoginUser(request);
		param.setLastChangerId(UserMVo.getUserId());
		
		//총 파일 데이터 조회
		HashMap<String,Object> map = new HashMap<String,Object>();
		map = dragDropFileDao.checkAmount(param.getAtchmnflSeqno());
		
		//파일 총 데이터 에서 삭제한 파일 데이터 빼기.
		param.setTotFileCnt(Integer.parseInt(map.get("TOT_FILE_CNT").toString()) - 1);
		param.setTotFileMg(Integer.parseInt(map.get("TOT_FILE_MG").toString()) - (int)param.getFileMg());
		dragDropFileDao.UpdAmountAction(param);	
		
		
		//해당 파일 삭제(use_at = 'N')
		int check = dragDropFileDao.deleteFiles(param);
		/*for(int i=0; i<param.size(); i++){
			check = fileUpDownloadDao.deleteFiles(param.get(i));
		}*/
		return check;
	}

	@Override
	public int updOrdAction(List<FileDetailMVo> param) {
		int check = 0;
		for(int i=0; i<param.size(); i++){
			check = dragDropFileDao.updOrdAction(param.get(i));
		}
		return check;
	}

	@Override
	public int amountUploadAction(FileDetailMVo param, HttpServletRequest request) {
		
		try{
			UserMVo UserMVo = commonFunc.getLoginUser(request);
			param.setLastChangerId(UserMVo.getUserId());
			HashMap<String,Object> map = new HashMap<String,Object>();
			map = dragDropFileDao.checkAmount(param.getAtchmnflSeqno());
			//파일 합계 테이블에 같은 키 값이 있으면 실행
			if(map != null){
				//수정
				if(param.isRevision() == false){
					param.setTotFileCnt(param.getTotFileCnt() + Integer.parseInt(map.get("TOT_FILE_CNT").toString()));
					param.setTotFileMg(param.getTotFileMg() + Integer.parseInt(map.get("TOT_FILE_MG").toString()));
					dragDropFileDao.UpdAmountAction(param);
				}
				//개정
				else{
					int oldAtchmnflSeqno = param.getAtchmnflSeqno();
					param.setTotFileCnt(param.getTotFileCnt() + Integer.parseInt(map.get("TOT_FILE_CNT").toString()));
					param.setTotFileMg(param.getTotFileMg() + Integer.parseInt(map.get("TOT_FILE_MG").toString()));
					
					param.setOldAtchmnflSeqno(oldAtchmnflSeqno);
					dragDropFileDao.amountUploadAction(param);				
					dragDropFileDao.insRevisionUploadFiles(param);
				}
			}else{
//				param.setAtchmnflSeqno(dragDropFileDao.getMaxFileNum());
				dragDropFileDao.amountUploadAction(param);			
			}
		}catch(Exception e){
			throw e;
		}
		
						
		
		return param.getAtchmnflSeqno();
	}
	
	
}
