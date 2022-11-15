package lims.qa.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.qa.service.CstmrRDataService;
import lims.qa.vo.CstmrRDataVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/qa")
public class CstmrRDataController {

	@Resource(name = "cstmrRDataServiceImpl")
	private CstmrRDataService cstmrRDataService;

	@SetLocale()
	@RequestMapping(value = "CstmrRData.lims")
	public String DocM (Model model, HttpServletRequest request) {

		return "qa/CstmrRData";
	}

	/**
	 * 문서 목록 조회
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getCstmrRDataList.lims")
	public @ResponseBody List<CstmrRDataVo> getCstmrRDataList(@RequestBody CstmrRDataVo vo, HttpServletRequest request){
		List<CstmrRDataVo> result = cstmrRDataService.getCstmrRDataList(vo);
		return result;
	}

	/**
	 * 문서 이력 조회
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getCstmrRDataHistList.lims")
	public @ResponseBody List<CstmrRDataVo> getCstmrRDataHistList(@RequestBody CstmrRDataVo vo, HttpServletRequest request){
		List<CstmrRDataVo> result = cstmrRDataService.getCstmrRDataHistList(vo);
		return result;
	}

	/**
	 * 문서 정보 신규 저장
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/insCstmrRData.lims")
	public @ResponseBody int insCstmrRData(@RequestBody CstmrRDataVo vo, HttpServletRequest request){
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setLastChangerId(UserMVo.getUserId());
		return cstmrRDataService.insCstmrRData(vo);
	}
	
	


	
}
