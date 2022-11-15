package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.vo.CanisterNoMVo;
import lims.sys.vo.MenuMVo;
import lims.sys.vo.UserMVo;
import lims.wrk.service.MenuLabelLangMService;
import lims.wrk.vo.MenuLabelLangMVo;
;

@Controller
@RequestMapping(value = "/wrk")
public class MenuLabelLangMController {
	@Resource(name = "menuLabelLangMServiceImpl")
	private MenuLabelLangMService menuLabelLangMService; 
	
	@RequestMapping(value = "MenuLabelLangM.lims")
	public String CanM(HttpServletRequest request, Model model) {
		return "wrk/MenuLabelLangM";
	}
	
	// 조회
	@RequestMapping(value = "/getLablang.lims")
	public @ResponseBody List<MenuMVo> getLablang(@RequestBody MenuMVo vo){
		return menuLabelLangMService.getLablang(vo);
	}
	
	// 조회
	@RequestMapping(value = "/getLabinfolang.lims")
	public @ResponseBody List<MenuLabelLangMVo> getLabinfolang(@RequestBody MenuLabelLangMVo vo){
		return menuLabelLangMService.getLabinfolang(vo);
	}
	
	// 저장
	@RequestMapping(value = "/savelabellang.lims")
	public @ResponseBody int savelabellang(@RequestBody List<MenuLabelLangMVo> list,Model model, HttpServletRequest request){
		UserMVo userMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		for (MenuLabelLangMVo vo : list) {
			vo.setLastChangerId(userMVo.getUserId());
		}
		return menuLabelLangMService.savelabellang(list);
	}
	
	// 삭제
	@RequestMapping(value = "/delLablang.lims")
	public @ResponseBody int delLablang(@RequestBody List<MenuLabelLangMVo> list, Model model, HttpServletRequest request) {
		UserMVo userMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		for (MenuLabelLangMVo vo : list) {
			// 사용 유저 정보 및 검사 기관 정보 값 설정
			vo.setLastChangerId(userMVo.getUserId());
		}
		return menuLabelLangMService.delLablang(list);
	}
}
