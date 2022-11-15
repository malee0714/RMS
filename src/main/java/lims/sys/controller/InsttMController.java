package lims.sys.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.service.InsttMService;
import lims.sys.vo.InsttMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;


@Controller
@RequestMapping("/sys")
public class InsttMController {
	
	
	@Resource(name = "insttMServiceImpl")
	private InsttMService insttM;
	
	@SetLocale()
	@RequestMapping(value = "InsttM.lims" )
	public String test(Model model) {
		return "sys/InsttM";
	}
	
	@RequestMapping(value = "getInsttMList.lims" )
	public @ResponseBody List<InsttMVo> getMenuMList(@RequestBody InsttMVo vo, Model model) {
		
		return insttM.getInsttMList(vo);
	}
	
	@RequestMapping(value = "insInsttM.lims" )
	public @ResponseBody int insInsttM(@RequestBody InsttMVo vo, Model model, HttpServletRequest request) {
		// ID 현재 세션에서 얻어와서
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		// vo 수정자에 저장
		vo.setLastChangerId(UserMVo.getUserId());
		return insttM.insInsttM(vo);
	}
	
	@RequestMapping(value = "updInsttM.lims" )
	public @ResponseBody int updInsttM(@RequestBody InsttMVo vo, Model model, HttpServletRequest request) {
		// ID 현재 세션에서 얻어와서
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		// vo 수정자에 저장
		vo.setLastChangerId(UserMVo.getUserId());
		return insttM.updInsttM(vo);
	}
}
