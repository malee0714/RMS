package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.vo.ProductMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;
import lims.wrk.service.EntrpsSpecMService;
import lims.wrk.vo.EntrpsSpecMVo;
import lims.wrk.vo.PrductMVo;

@Controller
@RequestMapping(value = "/wrk")
public class EntrpsSpecMController {

	@Resource(name = "EntrpsSpecMService")
	private EntrpsSpecMService entrpsSpecMService;

	/**
	 * 고객사 규격관리 페이지
	 * @param request
	 * @param model
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "EntrpsSpecM.lims")
	public String EntrpsSpecM(HttpServletRequest request, Model model){
		return "wrk/EntrpsSpecM";
	}

	/**
	 * 제품목록 규격결재 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getPrductList.lims")
	public @ResponseBody List<EntrpsSpecMVo> getPrductList(@RequestBody EntrpsSpecMVo vo,HttpServletRequest request){
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setSanctnerId(UserMVo.getUserId());

		return entrpsSpecMService.getPrductList(vo);

	}
	/**
	 * 제품목록 규격관리 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getPrductListManage.lims")
	public @ResponseBody List<EntrpsSpecMVo> getPrductListManage(@RequestBody EntrpsSpecMVo vo,HttpServletRequest request){
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setSanctnerId(UserMVo.getUserId());

		return entrpsSpecMService.getPrductListManage(vo);

	}

	/**
	 * 자재팝업 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getProductPopList.lims")
	public @ResponseBody List<ProductMVo> getProductPopList(@RequestBody PrductMVo vo){
		return entrpsSpecMService.getProductPopList(vo);

	}


	/**
	 * 시험항목 정보 그리드 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getPrductCtmmnySdspcList.lims")
	public @ResponseBody List<EntrpsSpecMVo> getPrductCtmmnySdspcList(@RequestBody EntrpsSpecMVo vo){
		return entrpsSpecMService.getPrductCtmmnySdspcList(vo);

	}

	/**
	 * 자재정보 그리드 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getPrductCtmmnyMtrilList.lims")
	public @ResponseBody List<EntrpsSpecMVo> getPrductCtmmnyMtrilList(@RequestBody EntrpsSpecMVo vo){
		return entrpsSpecMService.getPrductCtmmnyMtrilList(vo);
	}

	/**
	 * 결재정보 그리드 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getCmSanctnList.lims")
	public @ResponseBody List<EntrpsSpecMVo> getCmSanctnList(@RequestBody EntrpsSpecMVo vo){
		return entrpsSpecMService.getCmSanctnList(vo);
	}

	/**
	 * 제품 시험항목 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getPrductExpriemList.lims")
	public @ResponseBody List<PrductMVo> getPrductExpriemList(@RequestBody PrductMVo vo){
		return entrpsSpecMService.getPrductExpriemList(vo);

	}

	/**
	 * 제품 고객사 정보 히스토리
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getPrductHist.lims")
	public @ResponseBody List<EntrpsSpecMVo> getPrductHist(@RequestBody EntrpsSpecMVo vo){
		return entrpsSpecMService.getPrductHist(vo);

	}

	/**
	 * 현재 정보가 개정승인요청을 했는지 구분
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getAmendmentAt.lims")
	public @ResponseBody String getAmendmentAt(@RequestBody EntrpsSpecMVo vo){
		return entrpsSpecMService.getAmendmentAt(vo);

	}

	/**
	 * 고객사 규격관리 저장
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/saveEntrpsSpecM.lims")
	public @ResponseBody int saveEntrpsSpecM(@RequestBody EntrpsSpecMVo vo, HttpServletRequest request){
		int result = 0;
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setLastChangerId(UserMVo.getUserId());

		//신규저장
		if(vo.getCrud().equals("C") || vo.getCrud().equals("R")){
			result = entrpsSpecMService.saveEntrpsSpecM(vo);
		}
		//수정
		else if(vo.getCrud().equals("U")){
			result = entrpsSpecMService.updateEntrpsSpecM(vo);
		}
		else if(vo.getCrud().equals("D")){
			result = entrpsSpecMService.delSyPrductCtmmny(vo);
		}
		return result;
	}
	
	/**
	 * 결재 상신
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/insConfirmM.lims")
	public @ResponseBody int insConfirmM(@RequestBody EntrpsSpecMVo vo, HttpServletRequest request){
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setLastChangerId(UserMVo.getUserId());
		return entrpsSpecMService.insConfirmM(vo);
	}

}
