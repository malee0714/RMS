package lims.qa.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.qa.service.CstmrAuditMService;
import lims.qa.vo.CstmrAuditMVo;
import lims.qa.vo.VendorAuditMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/qa")
public class CstmrAuditMController {

	@Resource(name = "cstmrAuditMServiceImpl")
	private CstmrAuditMService cstmrAuditMService;

	@SetLocale()
	@RequestMapping(value = "CstmrAuditM.lims")
	public String CstmrAuditM (Model model, HttpServletRequest request) {

		return "qa/CstmrAuditM";
	}

	@RequestMapping(value = "getCstmrAuditMList.lims")
	public @ResponseBody List<CstmrAuditMVo> getCstmrAuditMList(@RequestBody CstmrAuditMVo vo, Model model){
		List<CstmrAuditMVo> result = cstmrAuditMService.getCstmrAuditMList(vo);
		return result;
	}

	@RequestMapping(value = "insCstmrAudit.lims")
	public @ResponseBody int insVendorAudit(@RequestBody CstmrAuditMVo vo){
		return cstmrAuditMService.insCstmrAudit(vo);
	}
	
	@RequestMapping(value = "delCstmrAudit.lims")
	public @ResponseBody int delCstmrAudit(@RequestBody CstmrAuditMVo vo){
		return cstmrAuditMService.delCstmrAudit(vo);
	}
}
