package lims.qa.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.qa.service.CstmrAuditLgstrMService;
import lims.qa.vo.CstmrAuditLgstrMVo;
import lims.qa.vo.VendorAuditLgstrMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/qa")
public class CstmrAuditLgstrMController {

	@Resource(name = "cstmrAuditLgstrMServiceImpl")
	private CstmrAuditLgstrMService cstmrAuditLgstrMService;

	@SetLocale()
	@RequestMapping(value = "CstmrAuditLgstrM.lims")
	public String CstmrAuditLgstrM (Model model, HttpServletRequest request) {

		return "qa/CstmrAuditLgstrM";
	}

	@RequestMapping(value = "getCstmrAuditLgstrMList.lims")
	public @ResponseBody List<CstmrAuditLgstrMVo> getCstmrAuditLgstrMList(@RequestBody CstmrAuditLgstrMVo vo, Model model){
		List<CstmrAuditLgstrMVo> result = cstmrAuditLgstrMService.getCstmrAuditLgstrMList(vo);
		return result;
	}

	@RequestMapping(value = "insCstmrAuditLgstr.lims")
	public @ResponseBody int insCstmrAuditLgstr(@RequestBody CstmrAuditLgstrMVo vo){
		return cstmrAuditLgstrMService.insCstmrAuditLgstr(vo);
	}
	@RequestMapping(value = "delCstmrAuditLgstr.lims")
	public @ResponseBody int delCstmrAuditLgstr(@RequestBody CstmrAuditLgstrMVo vo){
		return cstmrAuditLgstrMService.delCstmrAuditLgstr(vo);
	}
}
