package lims.com.dao;

import java.util.List;
import java.util.Map;

import lims.com.vo.MainVo;
import lims.rsc.vo.CmpdsUseMVo;
import lims.rsc.vo.MrlsEdayChckMVo;
import lims.src.vo.ImpartclLogMVo;
import lims.sys.vo.UserMVo;

public interface MainDao {
	
	public MainVo getSelProEa(MainVo vo);
	public MainVo getUrl();
	public MainVo getAprData(MainVo vo);
	public List<MainVo> getNewOrgList();
	public List<MainVo> getDocReturnList();
	public List<MainVo> getSampleReturnList();
	public List<MainVo> getPrtHisList();
	public MainVo getOneDayCnt(MainVo vo);
	public List<MainVo> getTotalSale();
	public List<MainVo> getAreaSale();
	
	public int getUserPasswordCheck(UserMVo vo);
	public int saveUserPassword(UserMVo vo);
	public List<UserMVo> getUserChangeBestInspctInsttList(UserMVo vo);
	public List<UserMVo> getUserChangeInspctInsttList(UserMVo vo);
	public List<UserMVo> getUserChangeUserList(UserMVo vo);
	

	public List<MainVo> getAbsntList(MainVo vo);
	public MainVo getJobrealmctn(MainVo vo);
	public List<MainVo> getRequestMainPopupList(MainVo vo);
	public MainVo getTimelimit(MainVo vo);
	public MainVo getRequestProgress(MainVo vo);
	
	
	public List<MainVo> getBbsList(MainVo vo);
	public List<MainVo> gettcmList(MainVo vo);
	public List<MainVo> getIsscList(MainVo vo);
	
	public List<ImpartclLogMVo> getOnlineParticleList();
	public List<MrlsEdayChckMVo> getMhrlsEdayChckList();
	public List<CmpdsUseMVo> getConStandList();
	public List<MainVo> getInspctList(MainVo vo);
	public List<MainVo> getPrductList(MainVo vo);
	public List<MainVo> getValidList(MainVo vo);
	public List<MainVo> getRefromList(MainVo vo);
	public Map<String, Object> getBbsData(Map<String, Object> map);

}
