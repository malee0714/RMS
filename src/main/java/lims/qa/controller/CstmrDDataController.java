package lims.qa.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.qa.service.CstmrDDataService;
import lims.qa.vo.CstmrDDataVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/qa")
public class CstmrDDataController {

	@Resource(name = "cstmrDDataServiceImpl")
	private CstmrDDataService cstmrDDataService;

	@SetLocale()
	@RequestMapping(value = "CstmrDData.lims")
	public String DocM (Model model, HttpServletRequest request) {

		return "qa/CstmrDData";
	}

	/**
	 * 문서 목록 조회
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getCstmrDDataList.lims")
	public @ResponseBody List<CstmrDDataVo> getCstmrDDataList(@RequestBody CstmrDDataVo vo, HttpServletRequest request){
		List<CstmrDDataVo> result = cstmrDDataService.getCstmrDDataList(vo);
		return result;
	}

	/**
	 * 문서 이력 조회
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getCstmrDDataHistList.lims")
	public @ResponseBody List<CstmrDDataVo> getCstmrDDataHistList(@RequestBody CstmrDDataVo vo, HttpServletRequest request){
		List<CstmrDDataVo> result = cstmrDDataService.getCstmrDDataHistList(vo);
		return result;
	}

	/**
	 * 문서 이력 조회
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getPrductNmCombo.lims")
	public @ResponseBody List<CstmrDDataVo> getPrductNmCombo(@RequestBody CstmrDDataVo vo, HttpServletRequest request){
		List<CstmrDDataVo> result = cstmrDDataService.getPrductNmCombo(vo);
		return result;
	}
	
	/**
	 * 문서 정보 신규 저장
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/insCstmrDData.lims")
	public @ResponseBody int insCstmrDData(@RequestBody CstmrDDataVo vo, HttpServletRequest request){
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setLastChangerId(UserMVo.getUserId());
		return cstmrDDataService.insCstmrDData(vo);
	}
	
	@RequestMapping(value = "/getWarnAt.lims")
	public @ResponseBody List<CstmrDDataVo> getWarnAt(@RequestBody CstmrDDataVo vo, HttpServletRequest request){
		List<CstmrDDataVo> result = cstmrDDataService.getWarnAt(vo);
		return result;
	}


	
}
