package lims.sys.service.impl;


import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.com.service.CommonService;
import lims.sys.dao.AuthMDao;
import lims.sys.service.AuthMService;
import lims.sys.vo.AuthMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;

@Service
public class AuthMServiceImpl implements AuthMService{
	
	@Autowired
    private AuthMDao AuthMDao;
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Override
	public List<AuthMVo> getAthMList(AuthMVo param) {
		return AuthMDao.getAthMList(param);
	}

	@Override
	public List<AuthMVo> getAllMenuList(AuthMVo param) {
		return AuthMDao.getAllMenuList(param);
	}

	@Override
	public List<AuthMVo> getAthMenuList(AuthMVo param) {
		return AuthMDao.getAthMenuList(param);
	}
	
	@Override
	public List<UserMVo> getAllUserList(UserMVo param) {
		return AuthMDao.getAllUserList(param);
	}

	@Override
	public List<UserMVo> getAthUserList(UserMVo param) {
		return AuthMDao.getAthUserList(param);
	}
	
	@Override
	public String insAthMenu(List<AuthMVo> addedRowItems, List<AuthMVo> editedRowItems, List<AuthMVo> removedRowItems) {
		String [] arr = new String[2];
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int count = 0;
		if(!addedRowItems.isEmpty()){
			for(int i=0; i <addedRowItems.size(); i++) {
				addedRowItems.get(i).setLastChangerId(userMVo.getUserId());
				count = AuthMDao.insAthMenu(addedRowItems.get(i));
				
				Arrays.fill(arr, "");
				arr[0] = addedRowItems.get(i).getAuthorCode();
				arr[1] = addedRowItems.get(i).getMenuSeqno();
				/* audit 테이블 없어서 주석       -김경훈 - */
//				commonService.auditTrail("CM03000003", "CM04000001", arr, null);
			}	
		}
		
		if(!removedRowItems.isEmpty()){
			for(int i=0; i <removedRowItems.size(); i++) {
				removedRowItems.get(i).setLastChangerId(userMVo.getUserId());
				count = AuthMDao.delAthMenu(removedRowItems.get(i));
				Arrays.fill(arr, "");
				arr[0] = removedRowItems.get(i).getAuthorCode();
				arr[1] = removedRowItems.get(i).getMenuSeqno();
				/* audit 테이블 없어서 주석       -김경훈 - */
//				commonService.auditTrail("CM03000003", "CM04000003", arr, null);
			}	
		}
		 
		 
		return (count > 0) ? "Y" : "N";
	}
	
	@Override
	public String insAthUser(List<UserMVo> addedRowItems, List<UserMVo> editedRowItems, List<UserMVo> removedRowItems) {
		String [] arr = new String[2];
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int count = 0;
		if(!addedRowItems.isEmpty()){
			for(int i=0; i <addedRowItems.size(); i++) {
				addedRowItems.get(i).setLastChangerId(userMVo.getUserId());
				addedRowItems.get(i).setInqireAuthorAt((addedRowItems.get(i).getInqireAuthorAt() == "true") ? "Y" : "N");
				addedRowItems.get(i).setStreAuthorAt((addedRowItems.get(i).getStreAuthorAt() == "true") ? "Y" : "N");
				addedRowItems.get(i).setDeleteAuthorAt((addedRowItems.get(i).getDeleteAuthorAt() == "true") ? "Y" : "N");
				addedRowItems.get(i).setOutptAuthorAt((addedRowItems.get(i).getOutptAuthorAt() == "true") ? "Y" : "N");
				count = AuthMDao.insAthUser(addedRowItems.get(i));
				Arrays.fill(arr, "");
				arr[0] = addedRowItems.get(i).getAuthorCode();
				arr[1] = addedRowItems.get(i).getUserId();
				/* audit 테이블 없어서 주석       -김경훈 - */
//				commonService.auditTrail("CM03000004", "CM04000001", arr, null);
			}	
			
		}
		
		if(!editedRowItems.isEmpty()){
			for(int i=0; i <editedRowItems.size(); i++) {
				editedRowItems.get(i).setLastChangerId(userMVo.getUserId());
				count = AuthMDao.updAthUserSS(editedRowItems.get(i));
				Arrays.fill(arr, "");
				arr[0] = editedRowItems.get(i).getAuthorCode();
				arr[1] = editedRowItems.get(i).getUserId();
				/* audit 테이블 없어서 주석       -김경훈 - */
//				commonService.auditTrail("CM03000004", "CM04000002",arr, null);
			}	
			
		}
		
		if(!removedRowItems.isEmpty()){
			for(int i=0; i <removedRowItems.size(); i++) {
				removedRowItems.get(i).setLastChangerId(userMVo.getUserId());
				count = AuthMDao.delAthUser(removedRowItems.get(i));
				Arrays.fill(arr, "");
				arr[0] = removedRowItems.get(i).getAuthorCode();
				arr[1] = removedRowItems.get(i).getUserId();
				/* audit 테이블 없어서 주석       -김경훈 - */
//				commonService.auditTrail("CM03000004", "CM04000003", arr, null);
			}	
			
		}
		
		
		return (count > 0) ? "Y" : "N";
	}

	@Override
	public int insAthGroup(AuthMVo vo) {
		return AuthMDao.insAthGroup(vo);
	}

	@Override
	public int updAthGroup(AuthMVo vo) {
		return AuthMDao.updAthGroup(vo);
	}
	
}
