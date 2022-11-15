package lims.lng.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.lng.service.DefaultLangMService;
import lims.lng.vo.DefaultLangMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value = "/lng")
public class DefaultLangMController {

	
	@Resource(name = "defaultLangMServiceImpl")
	private DefaultLangMService defaultLangMService;
	
	@SetLocale()
	@RequestMapping(value = "DefaultLangM.lims")
	public String CanM(HttpServletRequest request, Model model) {
		return "lng/DefaultLangM";
	}
	
	// 조회
	@RequestMapping(value = "/getDelang.lims")
	public @ResponseBody List<DefaultLangMVo> getCan(@RequestBody DefaultLangMVo vo){
		return defaultLangMService.getDelang(vo);
	}
	
	// 저장
	@RequestMapping(value = "/saveDelang.lims")
	public @ResponseBody int saveDelang(@RequestBody List<DefaultLangMVo> list,Model model, HttpServletRequest request){
		UserMVo userMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		for (DefaultLangMVo vo : list) {
			vo.setLastChangerId(userMVo.getUserId());
		}
		return defaultLangMService.saveDelang(list);
	}
	
	//중복체크 
	@RequestMapping(value = "/langNmChk.lims")
	public @ResponseBody int chkNo(@RequestBody DefaultLangMVo vo){
		return defaultLangMService.langNmChk(vo);
	}
	
	// 삭제
	@RequestMapping(value = "/delDelang.lims")
	public @ResponseBody int delDelang(@RequestBody List<DefaultLangMVo> list, Model model, HttpServletRequest request) {
		UserMVo userMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		for (DefaultLangMVo vo : list) {
			// 사용 유저 정보 및 검사 기관 정보 값 설정
			vo.setLastChangerId(userMVo.getUserId());
		}
		return defaultLangMService.delDelang(list);
	}
	
}
