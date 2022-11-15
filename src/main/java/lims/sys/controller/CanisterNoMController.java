package lims.sys.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.service.CanisterNoMService;
import lims.sys.vo.CanisterNoMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value = "/sys")
public class CanisterNoMController {
	
	@Resource(name = "canisterNoMServiceImpl")
	private CanisterNoMService canisterNoMService;
	
	@SetLocale()
	@RequestMapping(value = "CanisterNoM.lims")
	public String CanM(HttpServletRequest request, Model model) {
		return "sys/CanisterNoM";
	}
	
	// 조회
	@RequestMapping(value = "/getCan.lims")
	public @ResponseBody List<CanisterNoMVo> getCan(@RequestBody CanisterNoMVo vo){
		return canisterNoMService.getCan(vo);
	}
	
	// 저장
	@RequestMapping(value = "/saveCan.lims")
	public @ResponseBody int saveCan(@RequestBody List<CanisterNoMVo> list,Model model, HttpServletRequest request){
		UserMVo userMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		for (CanisterNoMVo vo : list) {
			vo.setLastChangerId(userMVo.getUserId());
		}
		return canisterNoMService.saveCan(list);
	}
	
	//중복체크 
	@RequestMapping(value = "/chkNo.lims")
	public @ResponseBody int chkNo(@RequestBody CanisterNoMVo vo){
		return canisterNoMService.chkNo(vo);
	}
	
	// 삭제
	@RequestMapping(value = "/delCan.lims")
	public @ResponseBody int delCan(@RequestBody List<CanisterNoMVo> list, Model model, HttpServletRequest request) {
		UserMVo userMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		for (CanisterNoMVo vo : list) {
			// 사용 유저 정보 및 검사 기관 정보 값 설정
			vo.setLastChangerId(userMVo.getUserId());
		}
		return canisterNoMService.delCan(list);
	}
		
}
