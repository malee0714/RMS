package lims.com.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lims.com.service.IgnoreServletUrlService;
import lims.com.vo.ComboVo;
import lims.sys.vo.CmmnCodeMVo;
import lims.sys.vo.InsttMVo;
import lims.sys.vo.UserMVo;

@RestController
@RequestMapping("/isu")
public class IgnoreServletUrlController {

	@Resource(name = "ignoreServletUrlServiceImpl")
	private IgnoreServletUrlService ignoreServletUrlService;

	@RequestMapping("/getBplcCode.lims")
	public List<ComboVo> getBplcCode(@RequestBody InsttMVo param) {
		return ignoreServletUrlService.getBplcCode(param);
	}
	
	@RequestMapping(value = "/getOfcpsAndClsfCode.lims")
	public List<ComboVo> getOfcpsAndClsfCode(@RequestBody CmmnCodeMVo vo) {
		return ignoreServletUrlService.getOfcpsAndClsfCode(vo);
	}
	
	@RequestMapping("/getDeptCode.lims")
	public List<ComboVo> getDeptCode(@RequestBody InsttMVo param) {
		return ignoreServletUrlService.getDeptCode(param);
	}

	@RequestMapping("/insUserJoin.lims")
	public int insUserJoin(@RequestBody UserMVo param) {
		return ignoreServletUrlService.insUserJoin(param);
	}

	@RequestMapping(value = "/getPasswordPolicyString.lims")
	public UserMVo getPasswordPolicyString() {
		return 	ignoreServletUrlService.getPasswordPolicyString();
	}
}
