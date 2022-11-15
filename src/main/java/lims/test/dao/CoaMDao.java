package lims.test.dao;

import lims.com.vo.ComboVo;
import lims.com.vo.FileDetailMVo;
import lims.test.vo.CoaMVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CoaMDao {
	List<CoaMVo> getCoaList(CoaMVo vo);
	FileDetailMVo getCoaFileInfo(CoaMVo vo);
	List<CoaMVo> getReqestInfo(CoaMVo vo);
	List<CoaMVo> getExprResultList(CoaMVo vo);
	int insAtchmnfl(FileDetailMVo vo);
	int insAtchmnflDetail(FileDetailMVo vo);
	int insCoaInfo(CoaMVo vo);
	int insCoaReqPrdct(CoaMVo vo);
	int insCoaReqUpper(CoaMVo vo);
	int updProgrsSittnCode(CoaMVo vo);
	int upperExiemProgrsSittnCode(CoaMVo vo);
	String getProgrsSittnCode(CoaMVo vo);
	int updCoaPblictAtchmnflSeqno(CoaMVo vo);
	List<CoaMVo> getReqUpperLotList(CoaMVo vo);
	List<CoaMVo> getCoaUpperList(CoaMVo vo);
	List<CoaMVo> getEntrpsListHasPrint(CoaMVo vo);
	List<ComboVo> getEntrpsPrintCombo(CoaMVo vo);
	CoaMVo getEntrpsPrintInfo(CoaMVo vo);
	int delCoaList(CoaMVo coaMVo);

}
