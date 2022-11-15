package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;
import lims.wrk.service.PrductUpperMService;
import lims.wrk.vo.PrductUpperMVo;

@Controller
@RequestMapping(value = "/wrk")
public class PrductUpperMController {
	
	
	@Resource(name = "prductUpperMServiceImpl")
	private PrductUpperMService prductUpperMService;
	
	@SetLocale()
	@RequestMapping(value = "PrductUpperM.lims")
	public String CanM(HttpServletRequest request, Model model) {
		return "wrk/PrductUpperM";
	}
	
	
	// 조회
	@RequestMapping(value = "/getPrductUpp.lims")
	public @ResponseBody List<PrductUpperMVo> getPrductUpp(@RequestBody PrductUpperMVo vo){
		return prductUpperMService.getPrductUpp(vo);
	}
	
	// 저장
	@RequestMapping(value = "/savePrductUpp.lims")
	public @ResponseBody int savePrductUpp(@RequestBody List<PrductUpperMVo> list,Model model, HttpServletRequest request){
		UserMVo userMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		for (PrductUpperMVo vo : list) {
			vo.setLastChangerId(userMVo.getUserId());
		}
		return prductUpperMService.savePrductUpp(list);
	}
	
	//중복체크 
	@RequestMapping(value = "/chkNo.lims")
	public @ResponseBody int chkNo(@RequestBody PrductUpperMVo vo){
		System.out.println("체크값"+vo.getCanNoChk());
		return prductUpperMService.chkNo(vo);
	}
	
	// 삭제
	@RequestMapping(value = "/delPrductUpp.lims")
	public @ResponseBody int delPrductUpp(@RequestBody List<PrductUpperMVo> list, Model model, HttpServletRequest request) {
		UserMVo userMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		for (PrductUpperMVo vo : list) {
			// 사용 유저 정보 및 검사 기관 정보 값 설정
			vo.setLastChangerId(userMVo.getUserId());
		}
		return prductUpperMService.delPrductUpp(list);
	}
		
}
