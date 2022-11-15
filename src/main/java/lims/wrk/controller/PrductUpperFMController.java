package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;
import lims.wrk.service.PrductUpperFMService;
import lims.wrk.vo.PrductUpperMVo;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/wrk")
public class PrductUpperFMController {

	@Resource(name = "prductUpperFMServiceImpl")
	private PrductUpperFMService prductUpperFMService;

	@SetLocale()
	@RequestMapping(value = "PrductUpperFM.lims")
	public String CanFM(HttpServletRequest request, Model model) {
		return "wrk/PrductUpperFM";
	}

	// 조회
	@RequestMapping(value = "/getPrductUppFM.lims")
	public @ResponseBody List<PrductUpperMVo> getPrductUpp(@RequestBody PrductUpperMVo vo) {
		return prductUpperFMService.getPrductUppFM(vo);
	}

	// 저장
	@RequestMapping(value = "/savePrductUppFM.lims")
	public @ResponseBody int savePrductUpp(@RequestBody PrductUpperMVo vo, Model model, HttpServletRequest request) {
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setLastChangerId(UserMVo.getUserId());
		return prductUpperFMService.savePrductUppFM(vo);

	}

	// 삭제
	@RequestMapping(value = "/delPrductUppFM.lims")
	public @ResponseBody int delPrductUpp(@RequestBody PrductUpperMVo vo, Model model, HttpServletRequest request) {
		return prductUpperFMService.delPrductUppFM(vo);
	}

}
