package lims.com.controller;

import java.util.List;

import javax.annotation.Resource;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import lims.com.dao.LocaleDao;
import lims.com.vo.LocaleVo;
import lims.util.Locale.SetLocale;



@Controller
@RequestMapping("/")
public class LoginMController {
	
	
	@Resource(name = "loginMServiceImpl")
	private lims.com.service.LoginMService LoginMService;
	
	@Autowired
	private LocaleDao LocaleDao;
	
	@SetLocale
	@RequestMapping(value = "login.lims" )
	public String login(Model model) {
		List<LocaleVo> languageList = LocaleDao.getListLanguage();
		model.addAttribute("languageList", languageList);
		return "login";
	}
}
