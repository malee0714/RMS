package lims.req.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import lims.req.service.RequestSanctnMService;
import lims.req.vo.RequestSanctnMVo;
import lims.util.Locale.SetLocale;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/req")
public class RequestSanctnMController {

	@Resource(name = "requestSanctnMServiceImpl")
	private RequestSanctnMService requestSanctnMServiceImpl;

	@SetLocale
	@RequestMapping(value = "/RequestSanctnM.lims")
	public String RequestSanctnM(Model model, HttpServletRequest request) {
		return "req/RequestSanctnM";
	}

	@RequestMapping(value = "/getRequestSanctnList.lims")
	public @ResponseBody List<RequestSanctnMVo> getRequestSanctnList(@RequestBody RequestSanctnMVo vo) {
		return requestSanctnMServiceImpl.getRequestSanctnList(vo);
	}

	@RequestMapping(value  = "/getExpriemSanctnList.lims")
	public @ResponseBody List<RequestSanctnMVo> getExpriemSanctnList(@RequestBody RequestSanctnMVo vo) {
		return requestSanctnMServiceImpl.getExpriemSanctnList(vo);
	}

	@RequestMapping(value = "/updApproval.lims")
	public @ResponseBody int updApproval(@RequestBody List<RequestSanctnMVo> list) {
		return requestSanctnMServiceImpl.updApproval(list);
	}

	@RequestMapping(value = "/updRtn.lims")
	public @ResponseBody int updRtn(@RequestBody List<RequestSanctnMVo> list) {
		return requestSanctnMServiceImpl.updRtn(list);
	}
}
