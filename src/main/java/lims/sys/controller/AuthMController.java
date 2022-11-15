package lims.sys.controller;

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

import lims.sys.service.AuthMService;
import lims.sys.vo.AuthMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/sys")
public class AuthMController {
	
	@Resource(name = "authMServiceImpl")
	private AuthMService AuthMService;
	
	@SetLocale()
	@RequestMapping(value = "AuthM.lims" )
	public String AthM(HttpServletRequest request, Model model) {
		return "sys/AuthM";
	}
	
	// 조회
	@RequestMapping("/getAthMList.lims")
	public @ResponseBody List<AuthMVo> getAthMList(@RequestBody AuthMVo AuthMVo){
		
		List<AuthMVo> result = AuthMService.getAthMList(AuthMVo);
		return result;
	}
	@RequestMapping("/getAllMenuList.lims")
	public  @ResponseBody List<AuthMVo> getAllMenuList(@RequestBody AuthMVo AuthMVo){
		List<AuthMVo> result = AuthMService.getAllMenuList(AuthMVo);
		return result;
	}
	@RequestMapping("/getAthMenuList.lims")
	public  @ResponseBody List<AuthMVo> getAthMenuList(@RequestBody AuthMVo AuthMVo){
		List<AuthMVo> result = AuthMService.getAthMenuList(AuthMVo);
		return result;
	}
	
	@RequestMapping("/getAllUserList.lims")
	public  @ResponseBody List<UserMVo> getAllUserList(@RequestBody UserMVo vo){
		List<UserMVo> result = AuthMService.getAllUserList(vo);
		return result;
	}
	@RequestMapping("/getAthUserList.lims")
	public  @ResponseBody List<UserMVo> getAthUserList(@RequestBody UserMVo vo){
		List<UserMVo> result = AuthMService.getAthUserList(vo);
		return result;
	}
	
	// 권한메뉴 관리
	@RequestMapping("/insAthMenu.lims")
	public  @ResponseBody String insAthMenu(@RequestBody  HashMap<String, Object> map, Model model, HttpServletRequest request ){
		JSONObject jsonObject = null;
		
		List<Object> addedObj = (List<Object>) map.get("addedRowItems");
		List<Object> editedObj = (List<Object>) map.get("editedRowItems");
		List<Object> removedObj = (List<Object>) map.get("removedRowItems");
		List<AuthMVo> addedRowItems = new ArrayList<>();
		List<AuthMVo> editedRowItems = new ArrayList<>();
		List<AuthMVo> removeRowItems = new ArrayList<>();
		
		int i = 0;
		
		for(Object lstObj : addedObj )
		{
			jsonObject = JSONObject.fromObject(lstObj);
			addedRowItems.add(i, (AuthMVo) JSONObject.toBean(jsonObject, lims.sys.vo.AuthMVo.class)); 
			i++;
		}
				
		i = 0;
		
		for(Object lstObj : editedObj )
		{
			jsonObject = JSONObject.fromObject(lstObj);
			editedRowItems.add(i, (AuthMVo) JSONObject.toBean(jsonObject, lims.sys.vo.AuthMVo.class)); 
			i++;
		}
		
		i = 0;
		
		for(Object lstObj : removedObj )
		{
			jsonObject = JSONObject.fromObject(lstObj);
			removeRowItems.add(i, (AuthMVo) JSONObject.toBean(jsonObject, lims.sys.vo.AuthMVo.class)); 
			i++;
		}
		
		return AuthMService.insAthMenu(addedRowItems, editedRowItems, removeRowItems);
	}
	
	// 권한사용자 관리
	@RequestMapping("/insAthUser.lims")
	public  @ResponseBody String insAthUser(@RequestBody  HashMap<String , Object> map, Model model, HttpServletRequest request ){
		JSONObject jsonObject = null;
		
		List<Object> addedObj = (List<Object>) map.get("addedRowItems");
		List<Object> editedObj = (List<Object>) map.get("editedRowItems");
		List<Object> removedObj = (List<Object>) map.get("removedRowItems");
		List<UserMVo> addedRowItems = new ArrayList<>();
		List<UserMVo> editedRowItems = new ArrayList<>();
		List<UserMVo> removeRowItems = new ArrayList<>();
		
		int i = 0;
		
		for(Object lstObj : addedObj )
		{
			jsonObject = JSONObject.fromObject(lstObj);
			addedRowItems.add(i, (UserMVo) JSONObject.toBean(jsonObject, lims.sys.vo.UserMVo.class)); 
			i++;
		}
				
		i = 0;
		
		for(Object lstObj : editedObj )
		{
			jsonObject = JSONObject.fromObject(lstObj);
			editedRowItems.add(i, (UserMVo) JSONObject.toBean(jsonObject, lims.sys.vo.UserMVo.class)); 
			i++;
		}
		
		i = 0;
		
		for(Object lstObj : removedObj )
		{
			jsonObject = JSONObject.fromObject(lstObj);
			removeRowItems.add(i, (UserMVo) JSONObject.toBean(jsonObject, lims.sys.vo.UserMVo.class)); 
			i++;
		}
		
		return AuthMService.insAthUser(addedRowItems, editedRowItems, removeRowItems);
	}
	
	// 권한그룹 관리
	@RequestMapping("/insAthGroup.lims")
	public @ResponseBody int insAthGroup(@RequestBody  AuthMVo vo,  Model model, HttpServletRequest request ){
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setLastChangerId(UserMVo.getUserId());

		return AuthMService.insAthGroup(vo);
	}
	
	// 권한그룹 관리
	@RequestMapping("/updAthGroup.lims")
	public  @ResponseBody int updAthGroup(@RequestBody AuthMVo vo,  Model model, HttpServletRequest request ){
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setLastChangerId(UserMVo.getUserId());

		return AuthMService.updAthGroup(vo);
	}
	
}
