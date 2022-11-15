package lims.com.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.com.vo.FileDetailMVo;


public interface DragDropFileMService {

	public List<FileDetailMVo> getFiles( FileDetailMVo param );
	
	public void getImage(String filePath, HttpServletRequest request, HttpServletResponse response);
	
	public int uploadAction(int fileIdx, MultipartHttpServletRequest request);
	
	public int amountUploadAction(FileDetailMVo param, HttpServletRequest request);
	
//	public int amountUpdateAction(FileDetailMVo param, HttpServletRequest request);
	
	public void setDownloadData(Map<String, Object> param, HttpServletResponse response);
	
	public void downloadAction(Map<String, String> param, HttpServletResponse response);
	
	public int deleteAction( FileDetailMVo param , HttpServletRequest request);
	
	public int updOrdAction( List<FileDetailMVo> param );
}
