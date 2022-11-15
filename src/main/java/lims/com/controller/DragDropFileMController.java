package lims.com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.com.service.DragDropFileMService;
import lims.com.vo.FileDetailMVo;

@Controller
@RequestMapping("/sys")
public class DragDropFileMController {
	
	@Resource(name="dragDropFileMServiceImpl")
	DragDropFileMService dragDropFileMServiceImpl;
	
	@RequestMapping("dropZone.lims")
	public @ResponseBody int dropZone(){
		return 0;
	}
	
	@RequestMapping("/dragDropGetFileList.lims")
	public @ResponseBody List<FileDetailMVo> dragDropGetFileList( @RequestBody FileDetailMVo param){
		return dragDropFileMServiceImpl.getFiles(param);
	}
	
	@RequestMapping("/dragDropGetImage.lims")
	public @ResponseBody void dragDropGetImage( @RequestParam(value="filePath") String filePath, HttpServletRequest request, HttpServletResponse response){
		dragDropFileMServiceImpl.getImage(filePath, request, response);
	}
	
	@RequestMapping("/dragDropUploadAction.lims")
	public @ResponseBody int dragDropUploadAction( @RequestParam(value="fileIdx", defaultValue="0") String fileIdx, final MultipartHttpServletRequest request ){
		return dragDropFileMServiceImpl.uploadAction(Integer.parseInt(fileIdx.replace(",", "")), request);
	}
	
	//총 파일 정보 insert
	@RequestMapping("/dragDropAmountUpload.lims")
	public @ResponseBody int dragDropAmountUpload(@RequestBody FileDetailMVo param, HttpServletRequest request){
		
		return dragDropFileMServiceImpl.amountUploadAction(param, request);
				
	}
	
//	//총 파일 정보 insert
//	@RequestMapping("/dragDropAmountUpdate.lims")
//	public @ResponseBody int dragDropAmountUpdate(@RequestBody FileDetailMVo param, HttpServletRequest request){
//		
//		return dragDropFileMServiceImpl.amountUpdateAction(param, request);
//				
//	}
	
	
	@RequestMapping("/dragDropDeleteAction.lims")
	public @ResponseBody int dragDropDeleteAction( @RequestBody FileDetailMVo param,  HttpServletRequest request){
		return dragDropFileMServiceImpl.deleteAction(param, request);
	}
	
	@RequestMapping("/dragDropUpdOrd.lims")
	public @ResponseBody int dragDropUpdOrdAction( @RequestBody List<FileDetailMVo> param ){
		return dragDropFileMServiceImpl.updOrdAction(param);
	}
	
	//파일 다운로드
	@RequestMapping("/dragDropDownloadAction.lims")
	public void CuOrgMFileDownload(@RequestParam(value="atchmnflSeqno", required=false) int atchmnflSeqno,
							   				   @RequestParam(value="fileSeqno", required=false) int fileSeqno, 
							   				   HttpServletResponse response){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("atchmnflSeqno", atchmnflSeqno);
		param.put("fileSeqno", fileSeqno);
		dragDropFileMServiceImpl.setDownloadData(param, response);
	}

}

