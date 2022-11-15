package lims.src.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.src.service.CstdySmpleMService;
import lims.src.vo.CstdySmpleMVo;
import lims.src.vo.RequestCntMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/req")
public class CstdySmpleMContoller {
	
	@Resource(name = "CstdySmpleMService")
	private CstdySmpleMService cstdySmpleMService;
	
	/**
	 * 접수 건수 조회
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "/CstdySmpleM.lims")
	public String CstdySmpleM(Model model){
		return "req/CstdySmpleM";
	}
	
	
	
	/**
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getCstdyList.lims")
	public @ResponseBody List<CstdySmpleMVo>  getCstdyList(@RequestBody CstdySmpleMVo vo){
		return cstdySmpleMService.getCstdyList(vo);
	}
	/**

	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/delRequestCntList.lims")
	public @ResponseBody int delRequestCntList(@RequestBody List<CstdySmpleMVo> vo){
		try{
			return cstdySmpleMService.delRequestCntList(vo);
			}catch (Exception e){
				throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
			}
		
	}
}
