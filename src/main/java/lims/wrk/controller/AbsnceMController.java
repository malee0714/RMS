package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.vo.CmpdsUseMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;
import lims.wrk.service.AbsnceMService;
import lims.wrk.service.Impl.AbsnceMServiceImpl;
import lims.wrk.vo.AbsnceMVo;
import lims.wrk.vo.CalcLawMVo;
import lims.wrk.vo.EntrpsFMVo;
import lims.wrk.vo.UnitFMVo;

@Controller
@RequestMapping("/wrk")
public class AbsnceMController {
	
	@Resource(name= "absnceMServiceImpl")
	private AbsnceMService absnceMService;
	
	@SetLocale()
	@RequestMapping(value= "AbsnceM.lims")
	public String AbsnceM(HttpServletRequest request, Model model){
		return "wrk/AbsnceM";
	}
	
	@RequestMapping(value= "getAbsnceList.lims")
	public @ResponseBody List<AbsnceMVo> getAbsnceList(@RequestBody AbsnceMVo vo){ 
		return absnceMService.getAbsnceList(vo);
	}
	
	@RequestMapping(value = "insAbsnceM.lims" )
	public @ResponseBody int insAbsnceM(@RequestBody AbsnceMVo vo, Model model, HttpServletRequest request) {
		// ID 현재 세션에서 얻어와서
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		// vo 수정자에 저장
		vo.setLastChangerId(UserMVo.getUserId());
		return absnceMService.insAbsnceM(vo);
	}
	
	@RequestMapping(value = "updAbsnceM.lims" )
	public @ResponseBody int updAbsnceM(@RequestBody AbsnceMVo vo, Model model, HttpServletRequest request) {
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setLastChangerId(UserMVo.getUserId());
		return absnceMService.updAbsnceM(vo);
	}
	
	@RequestMapping(value = "deleteAbsnM.lims")
	public @ResponseBody int deleteAbsnM(@RequestBody AbsnceMVo vo, Model model, HttpServletRequest request) {
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setLastChangerId(UserMVo.getUserId());
		return absnceMService.deleteAbsnM(vo);
	}
	// 중복 날짜 체크
	@RequestMapping(value = "confirmAbsnceM.lims")
	public @ResponseBody int confirmUnitFM (@RequestBody AbsnceMVo vo,  Model model){
		return  absnceMService.confirmAbsnceM(vo);
	}
	
	

}
