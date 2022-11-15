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

import lims.lng.service.CountryLangMService;
import lims.lng.vo.CountryLangMVo;
import lims.lng.vo.DefaultLangMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;
import net.sf.json.JSONObject;


@Controller
@RequestMapping(value = "/lng")
public class CountryLangMController {

	
	@Resource(name = "countryLangMServiceImpl")
	private CountryLangMService countryLangMService; 
	
	@SetLocale()
	@RequestMapping(value = "CountryLangM.lims")
	public String CanM(HttpServletRequest request, Model model) {
		return "lng/CountryLangM";
	}
	
	// 조회
	@RequestMapping(value = "/getConlang.lims")
	public @ResponseBody List<CountryLangMVo> getConlang(@RequestBody CountryLangMVo vo){
		return countryLangMService.getConlang(vo);
	}
	

	// 저장
	@RequestMapping(value = "/saveConlang.lims")
	public @ResponseBody int saveConlang(@RequestBody HashMap<String,Object> list,Model model, HttpServletRequest request){
		JSONObject jsonObject = null;
		CountryLangMVo vo = new CountryLangMVo();
		System.out.println(">>> : "+list.get("nationLangCode"));
		Object masterObj = list.get("nationLangCode");
		jsonObject = JSONObject.fromObject(masterObj);
		vo = (CountryLangMVo) JSONObject.toBean (jsonObject, CountryLangMVo.class);
		List<Object> detailObj = (List<Object>) list.get("list");
		List<CountryLangMVo> detailVO = new ArrayList<>();
		
		int i = 0;
		for(Object lstObj : detailObj){
			jsonObject = JSONObject.fromObject(lstObj); 
			detailVO.add(i, (CountryLangMVo) JSONObject.toBean(jsonObject, CountryLangMVo.class));
			i++;
		}
		return countryLangMService.saveConlang(detailVO, vo);
	}
	
	//중복체크 
	@RequestMapping(value = "/conlangChk.lims")
	public @ResponseBody int conlangChk(@RequestBody CountryLangMVo vo){
		System.out.println("체크값"+vo.getConlangChk());
		return countryLangMService.conlangChk(vo);
	}
	
	// 삭제
	@RequestMapping(value = "/delConlang.lims")
	public @ResponseBody int delConlang(@RequestBody List<DefaultLangMVo> list, Model model, HttpServletRequest request) {
		UserMVo userMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		for (DefaultLangMVo vo : list) {
			// 사용 유저 정보 및 검사 기관 정보 값 설정
			vo.setLastChangerId(userMVo.getUserId());	
		}
		return countryLangMService.delConlang(list);
	}
	
}
