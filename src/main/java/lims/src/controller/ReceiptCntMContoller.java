package lims.src.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.src.service.ReceiptCntMService;
import lims.src.vo.ReceiptCntMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/src")
public class ReceiptCntMContoller {
	
	@Resource(name = "ReceiptCntMService")
	private ReceiptCntMService receiptCntMService;
	
	/**
	 * 접수 건수 조회
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "/ReceiptCntM.lims")
	public String ReceiptCntM(Model model){
		return "src/ReceiptCntM";
	}
	
	/**
	 * 담당 팀별 접수 건수 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getReceiptCntList.lims")
	public @ResponseBody List<ReceiptCntMVo> getReceiptCntList(@RequestBody ReceiptCntMVo vo){
		return receiptCntMService.getReceiptCntList(vo);
	}
}
