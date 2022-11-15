package lims.com.dao;

import lims.com.vo.FileDetailMVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface DragDropFileMDao {
	
	public List<FileDetailMVo> getFiles(FileDetailMVo param);
	
	public int insUploadFiles(FileDetailMVo param);
	
	//파일 다운로드
	public FileDetailMVo getDownloadFile(Map<String, Object> param);
	
	public int amountUploadAction(FileDetailMVo param);
	
	public HashMap<String,Object> checkAmount(int param);
	
	public int UpdAmountAction(FileDetailMVo param);
	
	public int getFileIdx();
	public int getMaxFileNum();
	
	public int deleteFiles(FileDetailMVo param);
	
	public int updOrdAction(FileDetailMVo param);

	public int insRevisionUploadFiles(FileDetailMVo vo);
}
