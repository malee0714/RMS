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

import lims.lng.service.CmmnCodeLangMService;
import lims.lng.vo.CmmnCodeLangMVo;
import lims.sys.vo.MenuMVo;
import lims.util.Locale.SetLocale;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/lng")
public class CmmnCodeLangMController {

	@Resource(name = "cmmnCodeLangMServiceImpl")
	private CmmnCodeLangMService cmmnCodeLangMService; 
	
	@SetLocale()
	@RequestMapping(value = "CmmnCodeLangM.lims")
	public String CanM(HttpServletRequest request, Model model) {
		return "lng/CmmnCodeLangM";
	}
	
	@RequestMapping(value = "/getCmmnLang.lims")
	public @ResponseBody List<CmmnCodeLangMVo> getCmmnLang(@RequestBody CmmnCodeLangMVo vo){
		return cmmnCodeLangMService.getCmmnLang(vo);
	}
	
	@RequestMapping(value = "/saveCmmnlang.lims")
	public @ResponseBody int saveCmmnlang(@RequestBody HashMap<String,Object> list,Model model, HttpServletRequest request){
		JSONObject jsonObject = null;
		CmmnCodeLangMVo vo = new CmmnCodeLangMVo();

		Object masterObj = list.get("nationLangCode");
		jsonObject = JSONObject.fromObject(masterObj);
		vo = (CmmnCodeLangMVo) JSONObject.toBean (jsonObject, lims.lng.vo.CmmnCodeLangMVo.class);
		List<Object> detailObj = (List<Object>) list.get("list");
		List<CmmnCodeLangMVo> detailVO = new ArrayList<>();
		
		int i = 0;
		for(Object lstObj : detailObj){
			jsonObject = JSONObject.fromObject(lstObj); 
			detailVO.add(i, (CmmnCodeLangMVo) JSONObject.toBean(jsonObject, lims.lng.vo.CmmnCodeLangMVo.class));
			i++;
		}
		return cmmnCodeLangMService.saveCmmnlang(detailVO, vo);
	}
}
