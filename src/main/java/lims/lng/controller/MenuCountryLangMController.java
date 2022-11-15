package lims.lng.controller;

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

import lims.lng.service.MenuCountryLangMService;
import lims.sys.vo.MenuMVo;
import lims.util.Locale.SetLocale;
import net.sf.json.JSONObject;


@Controller
@RequestMapping(value = "/lng")
public class MenuCountryLangMController {

	
	@Resource(name = "menuCountryLangMServiceImpl")
	private MenuCountryLangMService menuCountryLangMService; 
	
	@SetLocale()
	@RequestMapping(value = "MenuCountryLangM.lims")
	public String CanM(HttpServletRequest request, Model model) {
		return "lng/MenuCountryLangM";
	}
	
	// 조회
	@RequestMapping(value = "/getMconlang.lims")
	public @ResponseBody List<MenuMVo> getMconlang(@RequestBody MenuMVo vo){
		return menuCountryLangMService.getMconlang(vo);
	}
	
	// 저장
	@RequestMapping(value = "/saveMconlang.lims")
	public @ResponseBody int saveMconlang(@RequestBody HashMap<String,Object> list,Model model, HttpServletRequest request){
		JSONObject jsonObject = null;
		MenuMVo vo = new MenuMVo();
		System.out.println(">>> : "+list.get("nationLangCode"));
		Object masterObj = list.get("nationLangCode");
		jsonObject = JSONObject.fromObject(masterObj);
		vo = (MenuMVo) JSONObject.toBean (jsonObject, lims.sys.vo.MenuMVo.class);
		List<Object> detailObj = (List<Object>) list.get("list");
		List<MenuMVo> detailVO = new ArrayList<>();
		
		int i = 0;
		for(Object lstObj : detailObj){
			jsonObject = JSONObject.fromObject(lstObj); 
			detailVO.add(i, (MenuMVo) JSONObject.toBean(jsonObject, lims.sys.vo.MenuMVo.class));
			i++;
		}
		return menuCountryLangMService.saveMconlang(detailVO, vo);
	}
}
