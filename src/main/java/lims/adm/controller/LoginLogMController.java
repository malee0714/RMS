package lims.adm.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.adm.service.LoginLogMService;
import lims.adm.vo.LoginLogMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/adm")
public class LoginLogMController {
	
	
	@Resource(name="loginLogMServiceImpl")
	private LoginLogMService LoginLogMImpl;
	
	@SetLocale()
	@RequestMapping("/LoginLogM")
	public String LoginLogM(Model model){
		return "adm/LoginLogM";
	}
	
	@RequestMapping("/getLogingLoigMList")
	public @ResponseBody List<LoginLogMVo> getLogingLoigMList(@RequestBody LoginLogMVo LoginLogMVo, HttpServletRequest request){
		return LoginLogMImpl.getLogingLoigMList(LoginLogMVo);
	}
	
	
}
