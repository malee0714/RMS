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

import lims.rsc.service.DsuseMService;
import lims.rsc.vo.DlyvyMVo;
import lims.rsc.vo.DsuseMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping(value="/rsc")
public class DsuseMController {
	
	
	@Resource(name = "dsuseMServiceImpl")
	private DsuseMService dsuseMService;
	
	@SetLocale()
	@RequestMapping(value = "DsuseM.lims")
	public String DsuseM (Model model, HttpServletRequest request) {
		
		return "rsc/DsuseM";
	}
	
	// 바코드 조회
	@RequestMapping(value = "getDsuseBacode.lims")
	public @ResponseBody List<DsuseMVo> getDsuseBacode (@RequestBody DsuseMVo vo, Model model){

		
		try {
			List<DsuseMVo> result = dsuseMService.getDsuseBacode(vo);
			
			return result;
		}catch(Exception e) {
			throw new CustomException(e, vo, "바코드가 정상적으로 조회되지 않았습니다.");
		}
	}
	
	// 폐기
	@RequestMapping(value = "insDsuseBacode.lims" )
	public @ResponseBody int insDsuseBacode(@RequestBody List<DsuseMVo> vo, Model model){

				try{
		return dsuseMService.insDsuseBacode(vo);
	}catch (Exception e){
		log.error(e.getMessage(),e);
		throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
	}

	}
	
	
	
}
