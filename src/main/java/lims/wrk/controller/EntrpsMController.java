package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lims.wrk.service.EntrpsMService;
import lims.wrk.vo.EntrpsMDto;
import lims.wrk.vo.EntrpsMVo;

@Controller
@RequestMapping("/wrk")
public class EntrpsMController {
	
	@Resource(name="entrpsMServiceImpl")
	private EntrpsMService entrpsMServiceImpl;
	
	@SetLocale()
	@RequestMapping("/EntrpsM")
	public String EntrpsM(Model model,HttpServletRequest request){
		return "wrk/EntrpsM";
	}
	
	@RequestMapping("/getEntrpsMList.lims")
	public @ResponseBody List<EntrpsMDto> getEntrpsMList(@RequestBody EntrpsMVo EntrpsMVo, HttpServletRequest request){
		return entrpsMServiceImpl.getEntrpsMList(EntrpsMVo);
	}

	// 업체 정보 저장.
	@RequestMapping("/saveEntrpsM.lims")
	public ResponseEntity<EntrpsMDto> saveEntrpsM(@RequestBody EntrpsMDto vo) {
		try {
			entrpsMServiceImpl.saveEntrpsM(vo);
			return ResponseEntity.ok(vo);
		} catch (CustomException e) {
			throw e;
		}
	}
	
	// 업체 이름 확인.
	@RequestMapping("/entrpsNmValidation.lims")
	@ResponseBody
	public int entrpsNmValidation(@RequestBody EntrpsMDto vo){
		return entrpsMServiceImpl.entrpsNmValidation(vo);
	}
	
}
