package lims.wrk.service.Impl;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.wrk.dao.ChrgTeamMDao;
import lims.wrk.service.ChrgTeamMService;
import lims.wrk.vo.ChrgTeamMVo;
import lombok.var;

/**
 * @author csy
 *
 */
/**
 * @author csy
 *
 */
@Service
public class ChrgTeamMServiceImpl implements ChrgTeamMService{
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
    private ChrgTeamMDao chrgTeamMDao;	
	
	@Override
	public List<ChrgTeamMVo> getChrgTeamList(ChrgTeamMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		return chrgTeamMDao.getChrgTeamList(vo);
	}
	
	@Override
	public List<ChrgTeamMVo> getChrgTeamIpList(ChrgTeamMVo vo) {
		return chrgTeamMDao.getChrgTeamIpList(vo);
	}
	
	@Override
	public List<ChrgTeamMVo> getChrgTeamIpComboList(ChrgTeamMVo vo) {
		return chrgTeamMDao.getChrgTeamIpComboList(vo);
	}
	
	@Override
	public List<ChrgTeamMVo> getUserList(ChrgTeamMVo vo) {	
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		vo.setDeptCode(userMVo.getDeptCode());
		return chrgTeamMDao.getUserList(vo);
	}
	
	@Override
	public List<ChrgTeamMVo> getChrgTeamUserList(ChrgTeamMVo vo) {	
		return chrgTeamMDao.getChrgTeamUserList(vo);
	}
	
	@Override
//	public int saveSanctnLine(HashMap<String, String> map, List<ChrgTeamMVo> vo) {
	public String saveChrgTeam(ChrgTeamMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		String sLastChangerId = userMVo.getUserId();
		
		vo.setLastChangerId(sLastChangerId);
		
		if(vo.getChrgTeamSeqno() == null || vo.getChrgTeamSeqno().equals("")){		
			chrgTeamMDao.insertChrgTeam(vo);			
		}else{			
			chrgTeamMDao.updateChrgTeam(vo);
		}
		
		var addedIpList = vo.getAddedIpList();
		var editedIpList = vo.getEditedIpList();
		var removedIpList = vo.getRemovedIpList();
		var userList = vo.getUserList();
		
		if(addedIpList != null) {
			for(ChrgTeamMVo avo : addedIpList) {
				avo.setChrgTeamSeqno(vo.getChrgTeamSeqno());
				chrgTeamMDao.addChrgIp(avo);
			}
		}
		
		if(editedIpList != null) {
			for(ChrgTeamMVo evo : editedIpList) {
				chrgTeamMDao.editChrgIp(evo);
			}
		}
		
		if(removedIpList != null) {
			for(ChrgTeamMVo rvo : removedIpList) {
				chrgTeamMDao.delChrgIp(rvo);
			}
		}
		
		//담당팀 사용자 삭제/추가
		if(userList.size() > 0){
			chrgTeamMDao.delChrgTeamUser(vo.getChrgTeamSeqno());
			
			for(ChrgTeamMVo ctmVo : userList){
				ctmVo.setChrgTeamSeqno(vo.getChrgTeamSeqno());
				chrgTeamMDao.instChrgTeamUser(ctmVo);
			}
		}
		
//		strChrgTeamSeqno = vo.getChrgTeamSeqno();
//		chrgTeamMDao.deleteChrgTeamUser(vo);
		
		/*for(int i=0; i <vo.size(); i++) {
			vo.get(i).setLastChangerId(sLastChangerId);			
			vo.get(i).setChrgTeamSeqno(strChrgTeamSeqno);
			
			check += chrgTeamMDao.insertChrgTeamUser(vo.get(i));
		}*/
		
		
		
		return vo.getChrgTeamSeqno();
	}

	@Override
	public int deleteChrgTeam(ChrgTeamMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		vo.setLastChangerId(userMVo.getUserId());
		chrgTeamMDao.deleteChrgTeamUser(vo);
		
		return chrgTeamMDao.deleteChrgTeam(vo);
	}
}