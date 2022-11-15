package lims.qa.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.qa.service.VendorAuditMService;
import lims.qa.vo.VendorAuditMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/qa")
public class VendorAuditMController {

	@Resource(name = "vendorAuditMServiceImpl")
	private VendorAuditMService vendorAuditMService;

	@SetLocale()
	@RequestMapping(value = "VendorAuditM.lims")
	public String VendorAuditM (Model model, HttpServletRequest request) {

		return "qa/VendorAuditM";
	}

	@RequestMapping(value = "getVendorAuditMList.lims")
	public @ResponseBody List<VendorAuditMVo> getVendorAuditMList(@RequestBody VendorAuditMVo vo, Model model){
		List<VendorAuditMVo> result = vendorAuditMService.getVendorAuditMList(vo);
		return result;
	}

	@RequestMapping(value = "insVendorAudit.lims")
	public @ResponseBody int insVendorAudit(@RequestBody VendorAuditMVo vo){
		return vendorAuditMService.insVendorAudit(vo);
	}
	
	@RequestMapping(value = "delVendorAudit.lims")
	public @ResponseBody int delVendorAudit(@RequestBody VendorAuditMVo vo){
		return vendorAuditMService.delVendorAudit(vo);
	}
}
