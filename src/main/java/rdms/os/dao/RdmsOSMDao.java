package rdms.os.dao;

import lims.com.vo.FileDetailMVo;
import lims.com.vo.RdmsMVo;
import lims.sys.vo.UserMVo;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public interface RdmsOSMDao {
	public int chkExistRdmsUser(UserMVo vo);
	
	public int insertRdmsUserInfo(UserMVo vo);
	
	public int updateRdmsUserInfo(UserMVo vo);
	
	public int deleteRdmsUserInfo(UserMVo vo);

	public int updateDelRdmsUserInfo(UserMVo vo);
	
	public int resetRdmsPassword(UserMVo vo);
	
	//RDMS 뷰어 리스트 생성
	public int insertRDMSViewer(RdmsMVo map);

	public List<HashMap<String,Object>> getRdmsResultData(RdmsMVo vo);
	
	public List<String> selectRDMSViwer(RdmsMVo map);
	
	public int updRdmsInfo(HashMap<String,Object> map);

	public int updateCloseCnvt(RdmsMVo vo);
	
	public List<RdmsMVo> getBinderColumnInfo(String binderitemvalueId);

	public List<RdmsMVo> getPdfViewerGridData(HashMap<String,String[]> hashMap);

	public FileDetailMVo getblobPdfViewer(RdmsMVo vo);

	public List<FileDetailMVo> getCheckBlobPdfViewer(String[] strArray);
	
	public int delRdmsResultData(RdmsMVo vo);
}
