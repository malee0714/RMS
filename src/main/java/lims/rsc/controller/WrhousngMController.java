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

import lims.rsc.service.CheckMService;
import lims.rsc.service.PurchsRequestFixMService;
import lims.rsc.service.WrhousngMService;
import lims.rsc.vo.CheckMVo;
import lims.rsc.vo.DlyvyMVo;
import lims.rsc.vo.PurchsRequestFixMVo;
import lims.rsc.vo.PurchsRequestMVo;
import lims.rsc.vo.WrhousngMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;
@Slf4j
@Controller
@RequestMapping(value="/rsc")
public class WrhousngMController {
	
	
	@Resource(name = "wrhousngMServiceImpl")
	private WrhousngMService wrhousngMService;
	
	@SetLocale()
	@RequestMapping(value = "WrhousngM.lims")
	public String wrhousngM(Model model, HttpServletRequest request) {
		
		return "rsc/WrhousngM";
	}
	
	// 입고 그리드 조회
	@RequestMapping(value = "getWrhousngList.lims")
	public @ResponseBody List<WrhousngMVo> getWrhousngList (@RequestBody  WrhousngMVo vo, Model model){
		try{
		return wrhousngMService.getWrhousngList(vo);
		}catch(Exception e) {
			throw new CustomException(e, vo, "입고목록이 정상적으로 조회되지 않았습니다.");
		}
	}
	
	// 입고 그리드 저장 및 수정
	@RequestMapping(value = "insWrhousng.lims")
	public @ResponseBody int insWrhousng(@RequestBody WrhousngMVo vo){
	try{
		int result = wrhousngMService.insWrhousng(vo);	
		return result;
	}catch (Exception e){
		log.error(e.getMessage(),e);
		throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
	}
	}

	@RequestMapping(value = "insWareBrcd.lims")
	public @ResponseBody int insWareBrcd(@RequestBody WrhousngMVo vo, Model model){
		try{
		return wrhousngMService.insWareBrcd(vo);
		}catch (Exception e){
			log.error(e.getMessage(),e);
			throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
		}
	}
	
	
	@RequestMapping(value = "deletBrcd.lims")
	public @ResponseBody int deletBrcd(@RequestBody WrhousngMVo vo,Model model){
		try{
		return wrhousngMService.deletBrcd(vo);
	}catch (Exception e){
		log.error(e.getMessage(),e);
		throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
	}
	}
	@RequestMapping(value = "getexpriemList.lims")
	public @ResponseBody List<WrhousngMVo> getexpriemList (@RequestBody  WrhousngMVo vo, Model model){

		return wrhousngMService.getexpriemList(vo);
	}
	@RequestMapping(value = "getbrcdList.lims")
	public @ResponseBody List<WrhousngMVo> getbrcdList (@RequestBody  WrhousngMVo vo, Model model){
		
		return wrhousngMService.getbrcdList(vo);
	}
	@RequestMapping(value = "getbrcdSeqno.lims")
	public @ResponseBody List<WrhousngMVo> getbrcdSeqno (@RequestBody   List<WrhousngMVo> list, Model model){
		return wrhousngMService.getbrcdSeqno(list);
	}
	
	
	@RequestMapping(value = "selectBrcd.lims")
	public @ResponseBody List<WrhousngMVo> selectBrcd(@RequestBody WrhousngMVo vo,Model model){
		return wrhousngMService.selectBrcd(vo);
	}
	@RequestMapping(value = "updbrcdlist.lims")
	public @ResponseBody int updbrcdlist(@RequestBody WrhousngMVo vo,Model model){
		try{
		return wrhousngMService.updbrcdlist(vo);
	}catch (Exception e){
		log.error(e.getMessage(),e);
		throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
	}
	}
	@RequestMapping(value = "deletbrcdlist.lims")
	public @ResponseBody int deletbrcdlist(@RequestBody List<WrhousngMVo> vo,Model model){
		try{
			return wrhousngMService.deletbrcdlist(vo);
		}catch (Exception e){
			log.error(e.getMessage(),e);
			throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
		}
	}
	@RequestMapping(value = "deletbrcdrowlist.lims")
	public @ResponseBody int deletbrcdrowlist(@RequestBody WrhousngMVo vo,Model model){
		try{
		return wrhousngMService.deletbrcdrowlist(vo);
	}catch (Exception e){
		log.error(e.getMessage(),e);
		throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
	}

	}

	@RequestMapping(value = "deletexpriem.lims")
	public @ResponseBody int deletexpriem(@RequestBody WrhousngMVo vo,Model model){
		try{
			return wrhousngMService.deletexpriem(vo);
		}catch (Exception e){
			log.error(e.getMessage(),e);
			throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
		}

	}

	@RequestMapping(value = "wrhsdlvrQydelet.lims")
	public @ResponseBody int wrhsdlvrQydelet(@RequestBody List<WrhousngMVo> vo,Model model){
		try{
		return wrhousngMService.wrhsdlvrQydelet(vo);
	}catch (Exception e){
		log.error(e.getMessage(),e);
		throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
	}
	}
	
	
	
	
}
