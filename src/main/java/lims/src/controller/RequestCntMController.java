package lims.src.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.src.service.RequestCntMService;
import lims.src.vo.RequestCntMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/src")
public class RequestCntMController {
	
	@Resource(name = "RequestCntMService")
	private RequestCntMService requestCntMService;
	
	/**
	 * 부서별 의뢰 건수
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "/RequestCntM.lims")
	public String RequestCntM(Model model){
		return "src/RequestCntM";
	}
	
	/**
	 * 부서별 의뢰건수 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getRequestCntList.lims")
	public @ResponseBody RequestCntMVo getRequestCntList(@RequestBody RequestCntMVo vo){
		return requestCntMService.getRequestCntList(vo);
	}
	
}
