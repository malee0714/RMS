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

import lims.sys.vo.CmmnCodeMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;
import lims.wrk.service.UnitFMService;
import lims.wrk.vo.UnitFMVo;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/wrk")
public class UnitFMController {
	
	@Resource(name = "unitFMServiceImpl")
	private UnitFMService unitFMService;
	
	
	/**
	 * 
	 * @param request
	 * @param model
	 * @return 페이지 이동
	 */
	@SetLocale()
	@RequestMapping(value = "UnitFM.lims" )
	public String UnitM(HttpServletRequest request, Model model) {		
		return "wrk/UnitFM";
		
	}

//	//시험항목수수료조회 Grid
	@RequestMapping("/getUnitFList")
	public @ResponseBody List<UnitFMVo> getUnitList(@RequestBody UnitFMVo vo, HttpServletRequest request){		
		return unitFMService.getUnitList(vo);
	}
	
	//저장
	@RequestMapping("/saveUnitF.lims")
	public @ResponseBody int saveUnit(@RequestBody HashMap<String, Object> map, Model model, HttpServletRequest request){
		//map objcet를 JSONObject에 담을 변수 
		JSONObject jsonObject = null;
		
		// jsp에서 받아온 added map을 담당그룹ListVO에 담는다
		List<Object> detailObj = (List<Object>) map.get("addedRowItems");
		List<UnitFMVo> addedUnitFMVo = new ArrayList<>();
		int i = 0;
		
		for(Object lstObj : detailObj )
		{
			jsonObject = JSONObject.fromObject(lstObj);
			addedUnitFMVo.add(i, (UnitFMVo) JSONObject.toBean(jsonObject, lims.wrk.vo.UnitFMVo.class)); 
			i++;
		}
		
		// jsp에서 받아온 edit map을 담당그룹ListVO에 담는다
		List<Object> detailObj1 = (List<Object>) map.get("editedRowItems");
		List<UnitFMVo> editedUnitFMVo = new ArrayList<>();
		i = 0;
		
		for(Object lstObj : detailObj1 )
		{
			jsonObject = JSONObject.fromObject(lstObj);
			editedUnitFMVo.add(i, (UnitFMVo) JSONObject.toBean(jsonObject, lims.wrk.vo.UnitFMVo.class)); 
			i++;
		}
		
		// jsp에서 받아온 edit map을 담당그룹ListVO에 담는다
		List<Object> detailObj2 = (List<Object>) map.get("removedRowItems");
		List<UnitFMVo> removedUnitFMVo = new ArrayList<>();
		i = 0;
		
		for(Object lstObj : detailObj2 )
		{
			jsonObject = JSONObject.fromObject(lstObj);
			removedUnitFMVo.add(i, (UnitFMVo) JSONObject.toBean(jsonObject, lims.wrk.vo.UnitFMVo.class)); 
			i++;
		}
		
		return unitFMService.saveUnit(addedUnitFMVo, editedUnitFMVo, removedUnitFMVo);
	}
	@RequestMapping(value = "insUnitFM.lims" )
	public @ResponseBody int insUnitFM(@RequestBody UnitFMVo vo, Model model, HttpServletRequest request) {
		// ID 현재 세션에서 얻어와서
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		// vo 수정자에 저장
		vo.setLastChangerId(UserMVo.getUserId());
		return unitFMService.insUnitFM(vo);
	}
	
	@RequestMapping(value = "updUnitFM.lims" )
	public @ResponseBody int updUnitFM(@RequestBody UnitFMVo vo, Model model, HttpServletRequest request) {
		
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setLastChangerId(UserMVo.getUserId());
		return unitFMService.updUnitFM(vo);
	}
	
	@RequestMapping(value = "delUnitFM.lims")
	public @ResponseBody int delUnitFM(@RequestBody UnitFMVo vo, Model model, HttpServletRequest request) {
		
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		
		vo.setLastChangerId(UserMVo.getUserId());
		return unitFMService.delUnitFM(vo);
	}
	// 단위명 중복 값 체크
	@RequestMapping(value = "confirmUnitFM.lims")
	public @ResponseBody int confirmUnitFM (@RequestBody UnitFMVo vo,  Model model){
		return  unitFMService.confirmUnitFM(vo);
	}
	
}
