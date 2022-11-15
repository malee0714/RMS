package lims.sys.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.service.SysEstbsMService;
import lims.sys.vo.SysEstbsMVo;

import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/sys")
public class SysEstbsMController {
	
	@Resource(name = "sysEstbsMServiceImpl")
	private SysEstbsMService sysEstbsMService;
	
	@SetLocale()
	@RequestMapping(value = "SysEstbsM.lims")
	public String cmmnCodeM(Model model) {
		return "sys/SysEstbsM";
	}
	
	// 시스템 정책 정보 가져오기
	@RequestMapping(value = "getSysManage.lims")
	public @ResponseBody List<SysEstbsMVo> getSysManage (@RequestBody SysEstbsMVo vo, Model model) {
		return sysEstbsMService.getSysManage(vo);
	}
	
	// 시스템 정책 설정 저장
	@RequestMapping(value = "saveSysManage.lims")
	public @ResponseBody int saveSysManage (@RequestBody SysEstbsMVo vo,  Model model) {
		return sysEstbsMService.updSysManage(vo);
	}
	
}
