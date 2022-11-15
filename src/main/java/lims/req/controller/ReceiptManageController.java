package lims.req.controller;

import lims.req.service.ReceiptManageService;
import lims.req.vo.ReceiptManageDto;
import lims.util.Locale.SetLocale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/req")
public class ReceiptManageController {

	private final ReceiptManageService receiptManageService;

	@Autowired
	public ReceiptManageController(ReceiptManageService receiptManageServiceImpl) {
		this.receiptManageService = receiptManageServiceImpl;
	}

	@SetLocale()
	@RequestMapping(value = "ReceiptM.lims")
	public String ReceiptM(Model model) {
		return "req/ReceiptM";
	}

	@RequestMapping(value = "getRequestRceptList.lims")
	@ResponseBody
	public List<ReceiptManageDto> getRequestRceptList(@RequestBody ReceiptManageDto receiptManageDto) {
		return receiptManageService.getRequestRceptList(receiptManageDto);
	}

	@RequestMapping(value = "insMultiRecept.lims")
	@ResponseBody
	public int multipleReceipt(@RequestBody List<ReceiptManageDto> list) {
		return receiptManageService.multipleReceipt(list);
	}

	@RequestMapping(value = "cancelReceipt.lims")
	@ResponseBody
	public int cancelReceipt(@RequestBody List<ReceiptManageDto> list) {
		return receiptManageService.cancelReceipt(list);
	}

	@RequestMapping(value = "reqestReturn.lims")
	@ResponseBody
	public int reqestReturn(@RequestBody List<ReceiptManageDto> list) {
		return receiptManageService.reqestReturn(list);
	}

	@RequestMapping(value = "getReqRtnInfo.lims")
	@ResponseBody
	public ReceiptManageDto getReqRtnInfo(@RequestBody ReceiptManageDto receiptManageDto) {
		return receiptManageService.getReqRtnInfo(receiptManageDto);
	}

}
