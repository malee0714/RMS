package lims.com.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.com.vo.FileDetailMVo;

public interface FileUpDownloadMService {
	
	//파일 업로드
	public List<FileDetailMVo> uploadAction(String existFileIdx, String fileCtg, List<Integer> ordList, MultipartHttpServletRequest request);

	//기존에 업로드한 파일 가져오기
	public List<FileDetailMVo> getExistFiles(FileDetailMVo param);
	
	//순서 저장
	public int updReOrderFiles(List<FileDetailMVo> param);
	
	//파일 삭제
	public int deleteFiles(List<FileDetailMVo> param);
	
	//파일 다운로드(의뢰기관 등록)
	public void CuOrgMFileDownload(Map<String, Object> param, HttpServletResponse response);
	
	//파일 다운로드
	public void downloadAction(Map<String, String> param, HttpServletResponse response);
}
