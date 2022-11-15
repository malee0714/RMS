
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

import lims.rsc.service.DlyvyMService;
import lims.rsc.vo.CheckMVo;
import lims.rsc.vo.DlyvyMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/rsc")
public class DlyvyMController {
	
	
	@Resource(name = "dlyvyMServiceImpl")
	private DlyvyMService dlyvyMService;
	
	@SetLocale()
	@RequestMapping(value = "DlyvyM.lims")
	public String DlyvyM (Model model, HttpServletRequest request) {
		
		return "rsc/DlyvyM";
	}
	
	// 바코드 조회
	@RequestMapping(value = "getBacode.lims" )
	public @ResponseBody List<DlyvyMVo> getBacode(@RequestBody DlyvyMVo vo, Model model){
	
		
		try {
			List<DlyvyMVo>  result = dlyvyMService.getBacode(vo);
			return result;
		}catch(Exception e) {
			throw new CustomException(e, vo, "바코드가 정상적으로 조회되지 않았습니다.");
		}
	}
	
	// 출고
	@RequestMapping(value = "updateBrcd.lims" )
	public @ResponseBody int updateBrcd(@RequestBody List<DlyvyMVo> vo, Model model){
		try{
		return dlyvyMService.updateBrcd(vo);
	}catch (Exception e){
		log.error(e.getMessage(),e);
		throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
	}
	}
	@RequestMapping(value = "getPopupBrcd.lims")
	public @ResponseBody List<DlyvyMVo> getPopupBrcd(@RequestBody DlyvyMVo vo, Model model){
		List<DlyvyMVo> result = dlyvyMService.getPopupBrcd(vo);
		
		return result;
	}
	
	
}
