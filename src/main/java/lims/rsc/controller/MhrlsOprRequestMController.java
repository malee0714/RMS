package lims.rsc.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.req.vo.RequestMVo;
import lims.rsc.service.MhrlsOprRequestMService;
import lims.rsc.vo.MhrlsOprRequestMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/reg")
public class MhrlsOprRequestMController {	
	
	@Resource(name = "MhrlsOprRequestMService")
	private MhrlsOprRequestMService mhrlsOprRequestMService;
	
	@SetLocale()
	@RequestMapping(value = "MhrlsOprRequestM.lims" )
	public String MhrlsRepairHistM(HttpServletRequest request, Model model) {
		return "rsc/MhrlsOprRequestM";
	}
	
	/**
	 * 기기 가동 목록 조회
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getMhrlsOprList.lims")
	public @ResponseBody List<MhrlsOprRequestMVo> getMhrlsOprList(@RequestBody MhrlsOprRequestMVo vo, HttpServletRequest request){
		List<MhrlsOprRequestMVo> result = mhrlsOprRequestMService.getMhrlsOprList(vo);
		return result;
	}
	
	/**
	 * 기기 관리 번호로 조회 
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getMhrlsManageNoList.lims")
	public @ResponseBody List<MhrlsOprRequestMVo> getMhrlsManageNoList(@RequestBody MhrlsOprRequestMVo vo, HttpServletRequest request){
		List<MhrlsOprRequestMVo> result = mhrlsOprRequestMService.getMhrlsManageNoList(vo);
		return result;
	}
	
	/**
	 * 의뢰 정보 목록 조회
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getImReqestList.lims")
	public @ResponseBody List<RequestMVo> getImReqestList(@RequestBody RequestMVo vo, HttpServletRequest request){
		List<RequestMVo> result = mhrlsOprRequestMService.getImReqestList(vo);
		return result;
	}
	
	/**
	 * 기기가동, 기기 가동 의뢰 정보 저장
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/insMhrlsOprRequest.lims")
	public @ResponseBody int insMhrlsOprRequest(@RequestBody MhrlsOprRequestMVo vo, HttpServletRequest request){
				
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setLastChangerId(UserMVo.getUserId());
		int result = mhrlsOprRequestMService.insMhrlsOprRequest(vo);
		
		return result;
	}
	
	/**
	 * 의뢰정보 바코드 조회
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getImReqestBacdList.lims")
	public @ResponseBody List<RequestMVo> getImReqestBacdList(@RequestBody RequestMVo vo, HttpServletRequest request){
		List<RequestMVo> result = mhrlsOprRequestMService.getImReqestBacdList(vo);
		return result;
	}
	
	/**
	 * 기기 가동 목록 삭제
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/delMhrlsOprRequest.lims")
	public @ResponseBody int delMhrlsOprRequest(@RequestBody MhrlsOprRequestMVo vo, HttpServletRequest request){
				
		int result = mhrlsOprRequestMService.delMhrlsOprRequest(vo);
		
		return result;
	}
}
