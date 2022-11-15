package lims.com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.com.service.FileUpDownloadMService;
import lims.com.vo.FileDetailMVo;

@Controller
@RequestMapping("/com")
public class FileUpDownloadMController {
	
	
	@Resource(name="fileUpDownloadMServiceImpl")
	private FileUpDownloadMService fileUpDownloadServiceImpl;
	
	/**
	 * @param existFileIdx 파일번호 (PK)
	 * @param fileCtg 첨부파일 구분자(일단 보류하고 고정값 처리)
	 * @param ordList 파일들의 순서 인덱스를 담은 배열
	 * @param request File Object를 담은 요청 객체
	 * @return 업로드를 수행한 파일번호에 해당하는 파일 데이터를 리턴
	 */
	@RequestMapping("/uploadAction")
	public @ResponseBody List<FileDetailMVo> uploadAction(@RequestParam(value="existFileIdx", defaultValue="") String existFileIdx,
																			 @RequestParam(value="fileCtg", defaultValue="File") String fileCtg, 
																			 @RequestParam(value="ordList", required=false) List<Integer> ordList,
																			 final MultipartHttpServletRequest request){
		return fileUpDownloadServiceImpl.uploadAction(existFileIdx, fileCtg, ordList, request);
	}
	
	//기존에 업로드한 파일 가져오기
	@RequestMapping("/getExistFiles")
	public @ResponseBody List<FileDetailMVo> getExistFiles(@RequestBody FileDetailMVo param){
		return fileUpDownloadServiceImpl.getExistFiles(param);
	}
	
	//순서 저장
	@RequestMapping("/reOrderFiles")
	public @ResponseBody int updReOrderFiles(@RequestBody List<FileDetailMVo> param){
		return fileUpDownloadServiceImpl.updReOrderFiles(param);
	}
	
	//파일 삭제
	@RequestMapping("/deleteFiles")
	public @ResponseBody int deleteFiles(@RequestBody List<FileDetailMVo> param){
		return fileUpDownloadServiceImpl.deleteFiles(param);
	}
	
	//파일 다운로드
	@RequestMapping("/CuOrgMFileDownload")
	public void CuOrgMFileDownload(@RequestParam(value="fileIdx", required=false) int fileIdx,
							   			@RequestParam(value="fileSeq", required=false) int fileSeq, 
							   			HttpServletResponse response){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("fileIdx", fileIdx);
		param.put("fileSeq", fileSeq);
		fileUpDownloadServiceImpl.CuOrgMFileDownload(param, response);
	}
}
