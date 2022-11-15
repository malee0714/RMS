package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.util.Locale.SetLocale;
import lims.wrk.service.ExprMthMService;
import lims.wrk.vo.ExprMthMVo;

@Controller
@RequestMapping("/wrk")
public class ExprMthMController {

	@Resource(name = "exprMthMServiceImpl")
	private ExprMthMService exprMthMService;

	@SetLocale()
	@RequestMapping(value = "ExprMthM.lims" )
	public String test(Model model) {
		return "wrk/ExprMthM";
	}

	// 시험방법 조회
	@RequestMapping(value = "getExprMthMList.lims" )
	public @ResponseBody List<ExprMthMVo> getExprMthMList(@RequestBody ExprMthMVo vo, Model model) {
		return exprMthMService.getExprMthMList(vo);
	}

	// 시험방법 저장
	@RequestMapping(value = "insExprMthM.lims" )
	public @ResponseBody String insExprMthM(@RequestBody ExprMthMVo vo) {
		exprMthMService.insExprMthM(vo);
		return vo.getExprMthSeqno();
	}

	// 시험방법 업데이트
	@RequestMapping(value = "updExprMthM.lims" )
	public @ResponseBody String updExprMthM(@RequestBody ExprMthMVo vo) {
		exprMthMService.updExprMthM(vo);
		return vo.getExprMthSeqno();
	}

}