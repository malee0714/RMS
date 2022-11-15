package lims.sys.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.service.OrgMService;
import lims.sys.vo.OrgMVo;
import lims.util.Locale.SetLocale;


@Controller
@RequestMapping("/wrk")
public class OrgMController {


	@Resource(name = "orgMServiceImpl")
	private OrgMService OrgM;

	@SetLocale()
	@RequestMapping(value = "OrgM.lims" )
	public String OrgM(HttpServletRequest request, Model model) {
		return "sys/OrgM";
	}

	@RequestMapping(value = "getBestComboList.lims" )
	public @ResponseBody List<OrgMVo> getBestComboList(@RequestBody OrgMVo vo) {
		return OrgM.getBestComboList(vo);
	}
	@RequestMapping(value = "getAuthorCodeList.lims" )
	public @ResponseBody List<OrgMVo> getAuthorCodeList(@RequestBody OrgMVo vo) {
		return OrgM.getAuthorCodeList(vo);
	}

	@RequestMapping(value = "getUpperComboList.lims" )
	public @ResponseBody List<OrgMVo> getUpperComboList(@RequestBody OrgMVo vo) {
		return OrgM.getUpperComboList(vo);
	}
	
	@RequestMapping(value = "getUpperComboListAll.lims" )
	public @ResponseBody List<OrgMVo> getUpperComboListAll(@RequestBody OrgMVo vo) {
		return OrgM.getUpperComboListAll(vo);
	}

	@RequestMapping(value = "getOrgMList.lims" )
	public @ResponseBody List<OrgMVo> getOrgMList(@RequestBody OrgMVo vo) {
		return OrgM.getOrgMList(vo);
	}

	@RequestMapping(value = "insOrgM.lims" )
	public @ResponseBody int insOrgM(@RequestBody OrgMVo vo) {
		return OrgM.insOrgM(vo);
	}

	@RequestMapping(value = "updOrgM.lims" )
	public @ResponseBody int updOrgM(@RequestBody OrgMVo vo) {
		return OrgM.updOrgM(vo);
	}

}
