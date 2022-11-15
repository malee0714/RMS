package lims.rsc.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.rsc.service.RgntMService;
import lims.rsc.vo.RgntMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping(value="/rsc")
public class RgntMController{

	
	@Resource(name="rgntMServiceImpl")
	public RgntMService RgntMService;

	@SetLocale()
	@RequestMapping(value="RgntM.lims")
	public String RgntM( Model model){ 
		return "rsc/RgntM";
	}
	
	/**
	 * 기기관리 조회
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getRgntMList.lims")
	public @ResponseBody List<RgntMVo> getRgntMList(@RequestBody RgntMVo vo, HttpServletRequest request){
	
		try {
			return  RgntMService.getRgntMList(vo);
		}catch(Exception e) {
			throw new CustomException(e, vo, "시약 및 소모품목록이 정상적으로 조회되지 않았습니다.");
		}
	}
	@RequestMapping(value = "/listPrevnt.lims")
	public @ResponseBody List<RgntMVo> listPrevnt(@RequestBody RgntMVo vo, HttpServletRequest request){
	
		try {
			return  RgntMService.listPrevnt(vo);
		}catch(Exception e) {
			throw new CustomException(e, vo, "시약 및 소모품목록이 정상적으로 조회되지 않았습니다.");
		}
	}
	
	@RequestMapping(value="/saveRgntM.lims")
	public @ResponseBody String saveRgntM(@RequestBody RgntMVo list){ 
		try{
		return RgntMService.saveRgntM(list);
		}catch (Exception e){
			throw new CustomException(e,list,"저장이 정상적으로 처리되지 않았습니다");
		}
	}
	@RequestMapping(value="/savePrevnt.lims")
	public @ResponseBody int savePrevnt(@RequestBody RgntMVo list){
		try{
			return RgntMService.savePrevnt(list);
		}catch (Exception e){
			throw new CustomException(e,list,"저장이 정상적으로 처리되지 않았습니다");
		}
	}
	@RequestMapping(value="/delPrevnt.lims")
	public @ResponseBody int delPrevnt(@RequestBody RgntMVo list){
		try{
			return RgntMService.delPrevnt(list);
		}catch (Exception e){
			throw new CustomException(e,list,"저장이 정상적으로 처리되지 않았습니다");
		}
	}

	
	@RequestMapping(value="/getPrductdate.lims")
	public @ResponseBody RgntMVo getPrductdate(@RequestBody RgntMVo list){ 
		
		try {
			return RgntMService.getPrductdate(list);
		}catch(Exception e) {
			throw new CustomException(e, list, "시약 및 소모품목록 데이터가 정상적으로 조회되지 않았습니다.");
		}
	}
	
	@RequestMapping(value="/getprductSeqno.lims")
	public @ResponseBody List<RgntMVo> getprductSeqno(@RequestBody RgntMVo list){ 
		
		try {
			return RgntMService.getprductSeqno(list);
		}catch(Exception e) {
			throw new CustomException(e, list, "시퀀스번호가 정상적으로 조회되지 않았습니다.");
		}
	}
	@RequestMapping(value="/nowInvntryupdate.lims")
	public @ResponseBody int nowInvntryupdate(@RequestBody RgntMVo list){ 
		try{
			return RgntMService.nowInvntryupdate(list);
			}catch (Exception e){
				throw new CustomException(e,list,"저장이 정상적으로 처리되지 않았습니다");
			}

	}
	@RequestMapping(value="/nowInvntrydelet.lims")
	public @ResponseBody int nowInvntrydelet(@RequestBody List<RgntMVo> vo){ 
		try{
			return RgntMService.nowInvntrydelet(vo);
			}catch (Exception e){
				throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
			}

	}
	@RequestMapping(value="/deletRgntM.lims")
	public @ResponseBody HashMap<String,String> deletRgntM(@RequestBody RgntMVo vo){ 
		try{
		return RgntMService.deletRgntM(vo);
	}catch (Exception e){
		throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
	}
	}
	@RequestMapping(value="/deletPrevntlist.lims")
	public @ResponseBody int deletRgntM(@RequestBody List<RgntMVo> vo){ 
		try{
		return RgntMService.deletPrevntlist(vo);
	}catch (Exception e){
		throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
	}
	}
	

//	@RequestMapping(value="/saveimagefile.lims")
//	public @ResponseBody HashMap<String, Object> saveimagefile(MultipartHttpServletRequest request) throws Exception{	 
//		try{
//		return RgntMService.saveimagefile(request);
//	}catch (Exception e){
//		throw new CustomException(e,request,"저장이 정상적으로 처리되지 않았습니다");
//	}
//	}
	
}
