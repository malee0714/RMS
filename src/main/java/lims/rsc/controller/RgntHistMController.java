package lims.rsc.controller;

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

import lims.rsc.service.RgntHistMService;
import lims.rsc.vo.RgntHistMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/rsc")
public class RgntHistMController {
	
	
	@Resource(name = "rgntHistMServiceImpl")
	private RgntHistMService useRegMService;
	
	@SetLocale()
	@RequestMapping(value = "RgntHistM.lims")
	public String UseRegM (Model model, HttpServletRequest request) {
		
		return "rsc/RgntHistM";
	}

	// 사용량 등록 바코드 조회
	@RequestMapping(value = "getPrduct.lims" )
	public @ResponseBody List<RgntHistMVo> getPrduct(@RequestBody RgntHistMVo vo, Model model){
	
		try {
			List<RgntHistMVo> result = useRegMService.getPrduct(vo);
			
			return result;
			
		}catch(Exception e) {
			throw new CustomException(e, vo, "시약 및 소모품목록이 정상적으로 조회되지 않았습니다.");
		}
	}
	
	// 사용량 등록 바코드 조회
	@RequestMapping(value = "getHistlist.lims" )
	public @ResponseBody List<RgntHistMVo> getHistlist(@RequestBody RgntHistMVo vo, Model model){
		
		try {
			List<RgntHistMVo> result = useRegMService.getHistlist(vo);
			return result;
		}catch(Exception e) {
			throw new CustomException(e, vo, "바코드 사용이력이 정상적으로 조회되지 않았습니다.");
		}

	}
	
}
