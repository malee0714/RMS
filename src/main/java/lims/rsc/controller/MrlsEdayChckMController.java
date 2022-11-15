package lims.rsc.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.service.MrlsEdayChckMService;
import lims.rsc.vo.MrlsEdayChckMVo;
import lims.req.vo.RequestMVo;
import lims.sys.vo.CanisterNoMVo;
import lims.rsc.vo.QualfStdrMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/reg")
public class MrlsEdayChckMController {
	
	
	@Resource(name="mrlsEdayChckMServiceImpl")
	private MrlsEdayChckMService mrlsEdayChckMService;
	
	@SetLocale()
	@RequestMapping("/MrlsEdayChckM.lims")
	public String MrlsEdayChckM(HttpServletRequest request, Model model) {
		return "reg/MrlsEdayChckM";
	}
	
	//검사 교정 목록 조회
	@RequestMapping(value = "/searchMrlsChk.lims")
	public @ResponseBody List<MrlsEdayChckMVo> searchMrlsChk(@RequestBody MrlsEdayChckMVo vo){
		return mrlsEdayChckMService.searchMrlsChk(vo);
	}

	
	// 의뢰 결과 헤더 조회
	@RequestMapping(value = "/searchReqVal.lims")
	public @ResponseBody List<MrlsEdayChckMVo> searchReqVal(@RequestBody MrlsEdayChckMVo vo){
		return mrlsEdayChckMService.searchReqVal(vo);
	}
	
	// 의뢰 결과 값 조회
	@RequestMapping(value = "/searchValDetail.lims")
	public @ResponseBody List<MrlsEdayChckMVo> searchValDetail(@RequestBody MrlsEdayChckMVo vo){
		return mrlsEdayChckMService.searchValDetail(vo);
	}
	// 의뢰추가 조회
	@RequestMapping(value = "/searchReqList.lims")
	public @ResponseBody List<MrlsEdayChckMVo> searchReqList(@RequestBody MrlsEdayChckMVo vo){
		return mrlsEdayChckMService.searchReqList(vo);
	}
	
	// 차트 조회
	@RequestMapping(value = "/MecChartList.lims")
	public @ResponseBody List<MrlsEdayChckMVo> MecChartList(@RequestBody MrlsEdayChckMVo vo){
		return mrlsEdayChckMService.MecChartList(vo);
	}
	
	// 저장
	@RequestMapping(value = "/saveMrlsChk.lims")
	public @ResponseBody int saveMrlsChk(@RequestBody MrlsEdayChckMVo vo) {
		return mrlsEdayChckMService.saveMrlsChk(vo);
	}
	
	//의뢰 목록 삭제
	@RequestMapping(value ="/delReqDetail.lims")
	public @ResponseBody int delReqDetail(@RequestBody List<MrlsEdayChckMVo> list, Model model, HttpServletRequest request) {
		UserMVo userMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		for(MrlsEdayChckMVo vo : list) {
			vo.setLastChangerId(userMVo.getUserId());
		}
		
		return mrlsEdayChckMService.delReqDetail(list);
	}
	
	//의뢰 목록 삭제
	@RequestMapping(value ="/delReqAll.lims")
	public @ResponseBody int delReqAll(@RequestBody MrlsEdayChckMVo vo, Model model, HttpServletRequest request) {
		
		return mrlsEdayChckMService.delReqAll(vo);
	}
	

	
	
	
}
