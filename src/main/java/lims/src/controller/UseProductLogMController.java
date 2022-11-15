package lims.src.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.vo.RgntHistMVo;
import lims.src.service.UseProductLogMService;

@Controller
@RequestMapping("/src")
public class UseProductLogMController {
	
	@Resource(name = "useProductLogMServiceImpl")
	private UseProductLogMService useProductLogMService;
	
	@RequestMapping(value = "UseProductLogM.lims" )
	public String UseProductLogM(HttpServletRequest request, Model model) {		
		return "src/UseProductLogM";
	}
	
	// 사용량 등록 바코드 조회
	@RequestMapping(value = "getUseBacode.lims" )
	public @ResponseBody List<RgntHistMVo> getUseBacode(@RequestBody RgntHistMVo vo, Model model){
		List<RgntHistMVo> result = useProductLogMService.getUseBacode(vo);
		
		return result;
	}
}
