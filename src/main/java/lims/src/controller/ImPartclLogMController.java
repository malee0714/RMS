package lims.src.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.src.service.ImPartclLogMService;
import lims.src.vo.ImpartclLogMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/src")
public class ImPartclLogMController {
	
	@Resource(name = "imPartclLogMServiceImpl")
	private ImPartclLogMService imPartclLogMServiceImpl;
	
	@SetLocale()
	@RequestMapping(value = "ImPartclLogM.lims" )
	public String ImPartclLogM(HttpServletRequest request, Model model) {		
		return "src/ImPartclLogM";
	}
	
	/**
	 * 
	 * @param vo
	 * @return 먼지리스트
	 */
	@RequestMapping(value = "getParticleList.lims" )
	public @ResponseBody List<ImpartclLogMVo> getParticleList(@RequestBody ImpartclLogMVo vo) {		
		return imPartclLogMServiceImpl.getParticleList(vo);
	}
	
	/**
	 * 
	 * @param vo
	 * @return 장비리스트
	 */
	@RequestMapping(value = "getMhrlsList.lims" )
	public @ResponseBody List<ImpartclLogMVo> getMhrlsList() {		
		return imPartclLogMServiceImpl.getMhrlsList();
	}
}
