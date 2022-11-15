package lims.sys.controller;

import java.util.List;

import javax.annotation.Resource;

import lims.util.CommonFunc;
import lims.util.GetUserSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.service.UserMService;
import lims.sys.vo.InsttMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/wrk")
public class UserMController {

	@Resource(name = "userMServiceImpl")
	private UserMService userMService;

	@Autowired
	CommonFunc commonFunc;

	@SetLocale()
	@RequestMapping(value = "UserM.lims")
	public String userMPage(Model model) {
		return "sys/UserM";
	}

	@RequestMapping(value = "getUserMList.lims" )
	public @ResponseBody List<UserMVo> getUserMList(@RequestBody UserMVo vo) {
		return userMService.getUserMList(vo);
	}

	@RequestMapping(value = "getDeptComboList.lims")
	public @ResponseBody List<UserMVo> getDeptComboList(@RequestBody UserMVo vo) {
		return userMService.getDeptComboList(vo);
	}

	@RequestMapping(value = "getSbscrbConfmUserList.lims")
	public @ResponseBody List<UserMVo> getSbscrbConfmUserList(@RequestBody UserMVo vo) {
		return userMService.getSbscrbConfmUserList(vo);
	}
	
	@RequestMapping(value = "updNotUse.lims")
	public @ResponseBody int updNotUse(@RequestBody List<UserMVo> list) {
		return userMService.updNotUse(list);
	}
	
	@RequestMapping(value = "getNotLoginSixMonth.lims")
	public @ResponseBody List<UserMVo> getNotLoginSixMonth() {
		return userMService.getNotLoginSixMonth();
	}
	
	@RequestMapping(value = "updSbscrbConfm.lims")
	public @ResponseBody int updSbscrbConfm(@RequestBody List<UserMVo> list) {
		return userMService.updSbscrbConfm(list);
	}

	@RequestMapping(value = "updResetPassword.lims")
	public @ResponseBody int updResetPassword(@RequestBody List<UserMVo> list) {
		return userMService.updResetPassword(list);
	}

	@RequestMapping(value = "getLoginIdChk.lims")
	public @ResponseBody int getLoginIdChk(@RequestBody UserMVo vo, Model model){
		return userMService.getLoginIdChk(vo);
	}

	@RequestMapping(value = "getAuthorSeCode.lims")
	public @ResponseBody List<UserMVo> getAuthorSeCode(@RequestBody UserMVo vo, Model model) {
		return userMService.getAuthorSeCode(vo);
	}

	@RequestMapping(value = "getSignAtchmnflSeqno.lims")
	public @ResponseBody List<UserMVo> getSignAtchmnflSeqno(@RequestBody UserMVo vo, Model model) {
		return userMService.getSignAtchmnflSeqno(vo);
	}

	@RequestMapping(value = "putUserM.lims")
	public @ResponseBody int putUserM(@RequestBody UserMVo vo) {
		//일반, 고객사 권한 사용자는 자신의 아이디만 수정 가능하도록 분기
		if ("SY09000003".equals(GetUserSession.getAuthorSeCode()) || "SY09000004".equals(GetUserSession.getAuthorSeCode()))
			if (commonFunc.isEmpty(vo.getUserId()) || !vo.getUserId().equals(GetUserSession.getUserId()))
				return 99;
		return userMService.putUserM(vo);
	}

	@RequestMapping(value = "deleteUserInfo.lims")
	public @ResponseBody String deleteUserInfo(@RequestBody UserMVo vo) {
		return userMService.deleteUserInfo(vo);
	}

	@RequestMapping(value = "getUserAuthList.lims" )
	public @ResponseBody List<UserMVo> getUserAuthList(@RequestBody UserMVo vo, Model model) {
		return userMService.getUserAuthList(vo);
	}

	//공통으로 사용하는 기관정보
	@RequestMapping(value = "getInspctCode.lims")
	public @ResponseBody List<InsttMVo> getInspctCode(@RequestBody InsttMVo vo, Model model) {
		return userMService.getInspctCode(vo);
	}

	//부서별 고객사 저장
	@RequestMapping(value = "/updCustomerResult.lims")
	public @ResponseBody int updCustomerResult(@RequestBody UserMVo vo){
		return userMService.updCustomerResult(vo);
	}
}
