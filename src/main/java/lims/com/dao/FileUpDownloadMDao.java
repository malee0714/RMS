package lims.com.dao;

import java.util.List;
import java.util.Map;

import lims.com.vo.FileDetailMVo;

public interface FileUpDownloadMDao {

	//파일번호 MAX+1 값 가져오기
	public int getFileIdx();
	
	//파일 업로드
	public int insUploadFiles(FileDetailMVo fileVO);
	
	//기존에 업로드한 파일 가져오기
	public List<FileDetailMVo> getFiles(FileDetailMVo fileVO);
	
	//순서 저장
	public int updReOrderFiles(FileDetailMVo param);
	
	//파일 삭제
	public int deleteFiles(FileDetailMVo fileVO);
	
	//파일 다운로드
	public FileDetailMVo getDownloadFile(Map<String, Object> param);
}
