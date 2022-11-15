package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.util.Locale.SetLocale;
import lims.wrk.service.EntrpsSpecSanctnMServcie;
import lims.wrk.vo.EntrpsSpecMVo;

@Controller
@RequestMapping(value = "/wrk")
public class EntrpsSpecSanctnMController {
	 
	@Resource(name = "EntrpsSpecSanctnMServcie")
	private  EntrpsSpecSanctnMServcie entrpsSpecSanctnMServcie;
	
	/**
	 * 고객사 규격 결재
	 * @param request
	 * @param model
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "EntrpsSpecSanctnM.lims")
	public String EntrpsSpecSanctnM(HttpServletRequest request, Model model){
		return "wrk/EntrpsSpecSanctnM";
	}
	
	/**
	 * 결재 대기 상태 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getApprovalCnt.lims")
	public @ResponseBody int getApprovalCnt(@RequestBody EntrpsSpecMVo vo){
		return entrpsSpecSanctnMServcie.getApprovalCnt(vo);
	}
	
	/**
	 * 결재 승인
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/insApprovalSanctn.lims")
	public @ResponseBody int insApprovalSanctn(@RequestBody List<EntrpsSpecMVo> vo, HttpServletRequest request){
		return entrpsSpecSanctnMServcie.insApprovalSanctn(vo);
	}
	
	/**
	 * 반려
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/insReturnSanctn.lims")
	public @ResponseBody int insReturnSanctn(@RequestBody EntrpsSpecMVo vo, HttpServletRequest request){
		return entrpsSpecSanctnMServcie.insReturnSanctn(vo);
	}

}
