package lims.rsc.controller;

import lims.rsc.service.EqpmnRlabltyEvlService;
import lims.rsc.vo.EqpmnRlabltyEvlVo;
import lims.util.Locale.SetLocale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/rsc")
public class EqpmnRlabltyEvlController {

	@Resource(name = "eqpmnRlabltyEvlServiceImpl")
	private EqpmnRlabltyEvlService eqpmnRlabltyEvlService;

	/**
	 * 장비 신뢰성평가 페이지 이동
	 * @param request
	 * @param model
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "EqpmnRlabltyEvl.lims" )
	public String EqpmnRepairM(HttpServletRequest request, Model model) {
		return "rsc/EqpmnRlabltyEvl";
	}

	/**
	 * 장비 신뢰성평가 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/searchEqpmnRlabltyEvlRegst.lims")
	public @ResponseBody List<EqpmnRlabltyEvlVo> searchEqpmnRlabltyEvlRegst(@RequestBody EqpmnRlabltyEvlVo vo, HttpServletRequest request){
		List<EqpmnRlabltyEvlVo> result = eqpmnRlabltyEvlService.searchEqpmnRlabltyEvlRegst(vo);
		return result;
	}

	/**
	 * 장비 신뢰성평가 저장된 시험항목 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/searchEqpmnRlabltyEvlRegstSub.lims")
	public @ResponseBody List<EqpmnRlabltyEvlVo> searchEqpmnRlabltyEvlRegstSub(@RequestBody EqpmnRlabltyEvlVo vo, HttpServletRequest request){
		List<EqpmnRlabltyEvlVo> result = eqpmnRlabltyEvlService.searchEqpmnRlabltyEvlRegstSub(vo);
		return result;
	}

	/**
	 * 장비 신뢰성평가 저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/saveEqpmnRlabltyEvlRegstDate.lims")
	public @ResponseBody int saveEqpmnRlabltyEvlRegstDate(@RequestBody EqpmnRlabltyEvlVo vo, HttpServletRequest request){
		int result = eqpmnRlabltyEvlService.saveEqpmnRlabltyEvlRegstDate(vo);
		return result;
	}

	/**
	 * 장비 신뢰성평가 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/updateEqpmnRlabltyEvlRegstDel.lims")
	public @ResponseBody int updateEqpmnRlabltyEvlRegstDel(@RequestBody EqpmnRlabltyEvlVo vo, HttpServletRequest request){
		int result = eqpmnRlabltyEvlService.updateEqpmnRlabltyEvlRegstDel(vo);
		return result;
	}

	/**
	 * 장비 신뢰성평가 시험항목 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/getRsEqpmnRlabltyEvlExpriem.lims")
	public @ResponseBody List<EqpmnRlabltyEvlVo> getRsEqpmnRlabltyEvlExpriem(@RequestBody EqpmnRlabltyEvlVo vo, HttpServletRequest request){
		List<EqpmnRlabltyEvlVo> result = eqpmnRlabltyEvlService.getRsEqpmnRlabltyEvlExpriem(vo);
		return result;
	}

	/**
	 * 장비 검사 교정  데이터 호출
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/getCmmnInspctCode.lims")
	public @ResponseBody List<EqpmnRlabltyEvlVo> getCmmnInspctCode(@RequestBody EqpmnRlabltyEvlVo vo, HttpServletRequest request){
		List<EqpmnRlabltyEvlVo> result = eqpmnRlabltyEvlService.getCmmnInspctCode(vo);
		return result;
	}

	/**
	 * 장비관리번호로 조회 OR 장비 SELECTBOX로 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/getSelectEqpmnManageNo.lims")
	public @ResponseBody EqpmnRlabltyEvlVo getSelectEqpmnManageNo(@RequestBody EqpmnRlabltyEvlVo vo, HttpServletRequest request){
		EqpmnRlabltyEvlVo result = eqpmnRlabltyEvlService.getSelectEqpmnManageNo(vo);
		return result;
	}

	/**
	 * 장비 중복날짜 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/getChkRegistDate.lims")
	public @ResponseBody int getChkRegistDate(@RequestBody EqpmnRlabltyEvlVo vo, HttpServletRequest request){
		return eqpmnRlabltyEvlService.getChkRegistDate(vo);
	}

}
