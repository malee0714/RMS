package lims.qa.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.qa.service.VocMService;
import lims.qa.vo.VocMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/qa")
public class VocMController {

	@Resource(name = "vocMServiceImpl")
	private VocMService vocMService;

	/**
	 * VOC 페이지 이동
	 * @param request
	 * @param model
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "VocM.lims")
	public String DocM (Model model, HttpServletRequest request) {

		return "qa/VocM";
	}

	
	/**
	 * VOC 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/searchVocList.lims")
	public @ResponseBody List<VocMVo> searchVocList(@RequestBody VocMVo vo, HttpServletRequest request){
		List<VocMVo> result = vocMService.searchVocList(vo);
		return result;
	}
	
	/**
	 * VOC 등록
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/putVoc.lims")
	public @ResponseBody int putVoc(@RequestBody VocMVo vo, HttpServletRequest request){
		int result = vocMService.putVoc(vo);
		return result;
	}
	
	/**
	 * VOC 등록
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/getVocRegist.lims")
	public @ResponseBody List<VocMVo> getVocRegist(@RequestBody VocMVo vo, HttpServletRequest request){
		return vocMService.getVocRegist(vo);
	}
	
	
	/**
	 * VOC 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/updateVocDel.lims")
	public @ResponseBody int updateVocDel(@RequestBody VocMVo vo, HttpServletRequest request){
		int result = vocMService.updateVocDel(vo);
		return result;
	}
	
	
	/**
	 * 원인규명 및 대책수립
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/putDiagnose.lims")
	public @ResponseBody int putDiagnose(@RequestBody VocMVo vo, HttpServletRequest request){
		return vocMService.putDiagnose(vo);
	}
	
	/**
	 * VOC 대책수립 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/getVocCntrplnFoundng.lims")
	public @ResponseBody List<VocMVo> getVocCntrplnFoundng(@RequestBody VocMVo vo, HttpServletRequest request){
		return vocMService.getVocCntrplnFoundng(vo);
	}
	
	/**
	 * VOC 대책등록 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/updateVocCntrplnFoundngDel.lims")
	public @ResponseBody int updateVocCntrplnFoundngDel(@RequestBody VocMVo vo, HttpServletRequest request){
		int result = vocMService.updateVocCntrplnFoundngDel(vo);
		return result;
	}
	
	/**
	 * VOC 유효검증 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/updateVocValidVrifyDel.lims")
	public @ResponseBody int updateVocValidVrifyDel(@RequestBody VocMVo vo, HttpServletRequest request){
		int result = vocMService.updateVocValidVrifyDel(vo);
		return result;
	}
	
	/**
	 * VOC 유효성검증 저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/putValidVrify.lims")
	public @ResponseBody int putValidVrify(@RequestBody VocMVo vo, HttpServletRequest request){
		return vocMService.putValidVrify(vo);
	}
	
	
	/**
	 * VOC 유효검증 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/getVocValidVrify.lims")
	public @ResponseBody List<VocMVo> getVocValidVrify(@RequestBody VocMVo vo, HttpServletRequest request){
		return vocMService.getVocValidVrify(vo);
	}
	
}
