package lims.rsc.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.service.MhrlsCmpdsUseMService;
import lims.rsc.vo.MhrlsCmpdsUseMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/reg")
public class MhrlsCmpdsUseMController {
	
	@Resource(name = "MhrlsCmpdsUseMService")
	private MhrlsCmpdsUseMService mhrlsCmpdsUseMService;
	
	/**
	 * 고비용 소모품 사용
	 * @param request
	 * @param model
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "MhrlsCmpdsUseM.lims")
	public String MhrlsCmpdsUseM(HttpServletRequest request, Model model){
		return "rsc/MhrlsCmpdsUseM";
	}
	
	/**
	 * 고비용 소모품 사용 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getMhrlsCmpdsUseMList.lims")
	public @ResponseBody List<MhrlsCmpdsUseMVo> getMhrlsCmpdsUseMList(@RequestBody MhrlsCmpdsUseMVo vo){
		return mhrlsCmpdsUseMService.getMhrlsCmpdsUseMList(vo);
	}
	
	/**
	 * 바코드로 소모품 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getBrcdMhrlsCmpdsUseM.lims")
	public @ResponseBody List<MhrlsCmpdsUseMVo> getBrcdMhrlsCmpdsUseM(@RequestBody MhrlsCmpdsUseMVo vo){
		return mhrlsCmpdsUseMService.getBrcdMhrlsCmpdsUseM(vo);
		
	}
	
	
	/**
	 * 소모품 사용 시간 정보 저장
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/instMhrlsCmpdsUseM.lims")
	public @ResponseBody MhrlsCmpdsUseMVo instMhrlsCmpdsUseM(@RequestBody MhrlsCmpdsUseMVo vo){
		
		if(vo.getCrud().equals("C")){
			mhrlsCmpdsUseMService.instMhrlsCmpdsUseM(vo);
		}
		else if(vo.getCrud().equals("U")){
			mhrlsCmpdsUseMService.updtMhrlsCmpdsUseM(vo);
		}
		return vo;		
	}
	
	/**
	 * 소모품 사용 정보 삭제
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/delMhrlsCmpdsUseM.lims")
	public @ResponseBody MhrlsCmpdsUseMVo delMhrlsCmpdsUseM(@RequestBody MhrlsCmpdsUseMVo vo){
		mhrlsCmpdsUseMService.delMhrlsCmpdsUseM(vo);
		return vo;		
	}
	
}
