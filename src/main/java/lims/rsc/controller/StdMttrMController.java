package lims.rsc.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.service.StdMttrMService;
import lims.rsc.vo.StdMttrMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/reg")
public class StdMttrMController {
	
	@Resource(name="stdMttrMServiceImpl")
	public StdMttrMService stdMttrMService;

	@SetLocale()
	@RequestMapping(value="StdMttrM.lims")
	public String StdMttrM(HttpServletRequest request, Model model){ 
		return "rsc/StdMttrM";
	}
	
	@RequestMapping(value="getStdMttrList.lims")
	public @ResponseBody List<StdMttrMVo> getStdMttrList(@RequestBody StdMttrMVo vo){ 
		return stdMttrMService.getStdMttrList(vo);
	}
	
	@RequestMapping(value="saveStdMttrM.lims")
	public @ResponseBody StdMttrMVo saveStdMttrM(@RequestBody StdMttrMVo vo){ 
		
		return stdMttrMService.saveStdMttrM(vo);
	}
	
	/**
	 * 상위 표준 물질 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value="getUpperStdMttr.lims")
	public @ResponseBody List<StdMttrMVo> getUpperStdMttr(@RequestBody StdMttrMVo vo){
		return stdMttrMService.getUpperStdMttr(vo);
	}
}
