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

import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;
import lims.wrk.service.EntrpsFMService;
import lims.wrk.vo.EntrpsFMVo;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/wrk")
public class EntrpsFMController {
	
	
	@Resource(name="entrpsFMServiceImpl")
	private EntrpsFMService EntrpsFMServiceImpl;
	
	@SetLocale()
	@RequestMapping("/EntrpsFM")
	public String EntrpsFM(Model model,HttpServletRequest request){
		return "wrk/EntrpsFM";
	}
	
	@RequestMapping("/getEntrpsFMList")
	public @ResponseBody List<EntrpsFMVo> getEntrpsFMList(@RequestBody EntrpsFMVo EntrpsFMVo, HttpServletRequest request){
		return EntrpsFMServiceImpl.getEntrpsFMList(EntrpsFMVo);
	}
	
	//업체관리 중복 체크
	@RequestMapping(value = "/userValidationF.lims")
	public @ResponseBody int userValidationF(@RequestBody EntrpsFMVo vo, Model model){
		return EntrpsFMServiceImpl.userValidationF(vo);
	}
	
	//업체정보 등록
	@RequestMapping("/insEntrpsFM")
	public @ResponseBody int insEntrpsFM(@RequestBody EntrpsFMVo vo) {
			return EntrpsFMServiceImpl.insEntrpsFM(vo);
	}
	
	//업체정보 삭제
	@RequestMapping("/deleteEntrpsFM")
	public @ResponseBody int deleteEntrpsFM(@RequestBody EntrpsFMVo vo) {
			return EntrpsFMServiceImpl.deleteEntrpsFM(vo);
	}
	
	//업체정보 클릭 시 업체담당자 정보
	@RequestMapping("/getEntrpscFMList")
	public @ResponseBody List<EntrpsFMVo> getEntrpscFMList(@RequestBody EntrpsFMVo EntrpsFMVo, HttpServletRequest request){
		return EntrpsFMServiceImpl.getEntrpscFMList(EntrpsFMVo);
	}
	
//	//업제담당자 정보 등록
//	@RequestMapping("/insEntrpscFM")
//	public @ResponseBody int insEntrpscFM(@RequestBody List<EntrpsFMVo> vo) {
//		return EntrpsFMServiceImpl.insEntrpscFM(vo);
//	}
//	
	
	
}
