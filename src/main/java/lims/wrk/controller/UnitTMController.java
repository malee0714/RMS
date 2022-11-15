package lims.wrk.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.vo.MenuMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;
import lims.wrk.service.UnitTMService;
import lims.wrk.vo.EntrpsMVo;
import lims.wrk.vo.UnitTMVo;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/wrk")
public class UnitTMController {
	
	
	@Resource(name = "unitTMServiceImpl")
	
	private UnitTMService unitTMServiceImpl;
	
	
	/**
	 * 
	 * @param request
	 * @param model
	 * @return 페이지 이동
	 */
	@SetLocale()
	@RequestMapping(value = "UnitTM.lims" )
	public String UnitM(HttpServletRequest request, Model model) {		
		return "wrk/UnitTM";
		
	}
	
	//시험항목수수료조회 Grid
	@RequestMapping("/getUnitTList")
	public @ResponseBody List<UnitTMVo> getUnitList(@RequestBody UnitTMVo vo, HttpServletRequest request){		
		return unitTMServiceImpl.getUnitList(vo);
	}
	@RequestMapping(value = "insUnitTM.lims" )
	public @ResponseBody int insUnitTM(@RequestBody UnitTMVo vo, Model model, HttpServletRequest request) {
		// ID 현재 세션에서 얻어와서
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		// vo 수정자에 저장
		vo.setLastChangerId(UserMVo.getUserId());
		return unitTMServiceImpl.insUnit(vo);
	}
	@RequestMapping(value = "updateUnit.lims" )
	public @ResponseBody int updateUnit(@RequestBody UnitTMVo vo, Model model, HttpServletRequest request) {
		// ID 현재 세션에서 얻어와서
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		// vo 수정자에 저장
		vo.setLastChangerId(UserMVo.getUserId());
		return unitTMServiceImpl.updateUnit(vo);
	}
	@RequestMapping(value = "overlapUnit.lims" )
	public @ResponseBody int overlapUnit(@RequestBody UnitTMVo vo, /*int  count,*/ Model model, HttpServletRequest request) {
	//	System.out.println(count);
	//	return count;
		return unitTMServiceImpl.overlapUnit(vo);
	}
	
	@RequestMapping(value = "deleteUnit.lims" )
	public @ResponseBody int deleteUnit(@RequestBody UnitTMVo vo, Model model, HttpServletRequest request) {
		// ID 현재 세션에서 얻어와서
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		// vo 수정자에 저장
		vo.setLastChangerId(UserMVo.getUserId());
		System.out.println("test"+vo.getLastChangerId());
		return unitTMServiceImpl.deleteUnit(vo);
	}
}
