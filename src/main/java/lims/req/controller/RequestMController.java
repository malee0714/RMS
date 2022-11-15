package lims.req.controller;

import lims.req.service.RequestMService;
import lims.req.vo.RequestMVo;
import lims.util.Locale.SetLocale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/req")
public class RequestMController {

	@Resource(name = "requestMServiceImpl")
	private RequestMService requestMServiceImpl;

	@SetLocale
	@RequestMapping(value = "RequestM.lims" )
	public String RequestM(Model model) {
		return "req/RequestM";
	}

	@RequestMapping(value = "getMtrilEqpSeCombo.lims")
	public @ResponseBody List<RequestMVo> getMtrilEqpSeCombo(@RequestBody RequestMVo vo) {
		return requestMServiceImpl.getMtrilEqpSeCombo(vo);
	}

	@RequestMapping(value = "getMtrilVendorCombo.lims")
	public @ResponseBody List<RequestMVo> getMtrilVendorCombo(@RequestBody RequestMVo vo) {
		return requestMServiceImpl.getMtrilVendorCombo(vo);
	}

	@RequestMapping(value = "getRequestList.lims" )
	public @ResponseBody List<RequestMVo> getRequestList(@RequestBody RequestMVo vo) {
		return requestMServiceImpl.getRequestList(vo);
	}

	@RequestMapping(value = "insReqest.lims")
	public @ResponseBody RequestMVo insReqest(@RequestBody RequestMVo vo) {
		return requestMServiceImpl.insReqest(vo);
	}

	@RequestMapping(value = "updReqest.lims")
	public @ResponseBody String updReqest(@RequestBody RequestMVo vo) {
		return requestMServiceImpl.updReqest(vo);
	}

	@RequestMapping(value = "delReqest.lims")
	public @ResponseBody String delReqest(@RequestBody RequestMVo vo) {
		return requestMServiceImpl.delReqest(vo);
	}

	@RequestMapping(value = "getExpriemList.lims")
	public @ResponseBody List<RequestMVo> getExpriemList(@RequestBody RequestMVo vo) {
		return requestMServiceImpl.getExpriemList(vo);
	}

	@RequestMapping(value = "getReMatchingLotNo.lims")
	public @ResponseBody List<RequestMVo> getReMatchingLotNo(@RequestBody List<RequestMVo> list) {
		return requestMServiceImpl.getReMatchingLotNo(list);
	}

	@RequestMapping(value = "getVendorLotNoList.lims")
	public @ResponseBody List<RequestMVo> getVendorLotNoList(@RequestBody RequestMVo vo) {
		return requestMServiceImpl.getVendorLotNoList(vo);
	}

	@RequestMapping(value = "getRequestMtrilExpriemList.lims")
	public @ResponseBody List<RequestMVo> getRequestMtrilExpriem(@RequestBody RequestMVo vo) {
		return requestMServiceImpl.getRequestMtrilExpriem(vo);
	}

	@RequestMapping(value = "/getsploreCylndrList.lims")
	public @ResponseBody List<RequestMVo> getsploreCylndrList(@RequestBody RequestMVo vo) {
		return requestMServiceImpl.getsploreCylndrList(vo);
	}

	@RequestMapping(value = "/getsploreItemList.lims")
	public @ResponseBody List<RequestMVo> getsploreItemList(@RequestBody RequestMVo vo) {
		return requestMServiceImpl.getsploreItemList(vo);
	}

	@RequestMapping(value = "/getmtrilSeqno.lims")
	public @ResponseBody List<RequestMVo> getmtrilSeqno(@RequestBody RequestMVo vo) {
		return requestMServiceImpl.getmtrilSeqno(vo);
	}

}
