package lims.qa.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.qa.service.VendorAuditLgstrMService;
import lims.qa.service.VendorAuditMService;
import lims.qa.vo.VendorAuditLgstrMVo;
import lims.qa.vo.VendorAuditMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/qa")
public class VendorAuditLgstrMController {

	@Resource(name = "vendorAuditLgstrMServiceImpl")
	private VendorAuditLgstrMService vendorAuditLgstrMService;

	@SetLocale()
	@RequestMapping(value = "VendorAuditLgstrM.lims")
	public String VendorAuditLgstrM (Model model, HttpServletRequest request) {

		return "qa/VendorAuditLgstrM";
	}

	@RequestMapping(value = "getVendorAuditLgstrMList.lims")
	public @ResponseBody List<VendorAuditLgstrMVo> getVendorAuditLgstrMList(@RequestBody VendorAuditLgstrMVo vo, Model model){
		List<VendorAuditLgstrMVo> result = vendorAuditLgstrMService.getVendorAuditLgstrMList(vo);
		return result;
	}

	@RequestMapping(value = "insVendorAuditLgstr.lims")
	public @ResponseBody int insVendorAuditLgstr(@RequestBody VendorAuditLgstrMVo vo){
		return vendorAuditLgstrMService.insVendorAuditLgstr(vo);
	}
	
	@RequestMapping(value = "delVendorAuditLgstr.lims")
	public @ResponseBody int delVendorAuditLgstr(@RequestBody VendorAuditLgstrMVo vo){
		return vendorAuditLgstrMService.delVendorAuditLgstr(vo);
	}
}
