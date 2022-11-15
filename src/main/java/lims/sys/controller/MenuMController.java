package lims.sys.controller;

import lims.sys.service.MenuMService;
import lims.sys.vo.AuthMVo;
import lims.sys.vo.MenuMVo;
import lims.util.Locale.SetLocale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/sys")
public class MenuMController {

	private final MenuMService menuMService;

	@Autowired
	public MenuMController(MenuMService menuMServiceImpl) {
		this.menuMService = menuMServiceImpl;
	}

	@SetLocale()
	@RequestMapping(value = "MenuM.lims" )
	public String MenuM(Model model) {
		return "sys/MenuM";
	}

	@SetLocale()
	@RequestMapping(value = "MenuHelpP.lims")
	public String MenuHelpP(Model model) {
		return "sys/MenuHelpP";
	}

	@RequestMapping(value = "getMenuSeqno.lims")
	@ResponseBody
	public MenuMVo getMenuSeqno(@RequestBody MenuMVo vo) {
		return menuMService.getMenuSeqno(vo);
	}

	@RequestMapping(value = "getMenuMList.lims" )
	@ResponseBody
	public List<MenuMVo> getMenuMList(@RequestBody MenuMVo vo) {
		return menuMService.getMenuMList(vo);
	}

	@RequestMapping(value = "getHirMenuList.lims" )
	@ResponseBody
	public List<MenuMVo> getHirMenuList(@RequestBody MenuMVo vo) {
		return menuMService.getHirMenuList(vo);
	}

	@RequestMapping(value = "getMenuLvList.lims" )
	@ResponseBody
	public List<MenuMVo> getMenuLvList(@RequestBody MenuMVo vo) {
		return menuMService.getMenuLvList(vo);
	}

	@RequestMapping(value = "getMenuOneList.lims" )
	@ResponseBody
	public List<MenuMVo> getMenuOneList(@RequestBody MenuMVo vo) {
		return menuMService.getMenuOneList(vo);
	}

	@RequestMapping(value = "getMenuTwoList.lims" )
	@ResponseBody
	public List<MenuMVo> getMenuTwoList(@RequestBody MenuMVo vo) {
		return menuMService.getMenuTwoList(vo);
	}

	@RequestMapping(value = "insMenuM.lims" )
	@ResponseBody
	public int insMenuM(@RequestBody MenuMVo vo) {
		return menuMService.insMenuM(vo);
	}

	@RequestMapping(value = "updMenuM.lims" )
	@ResponseBody
	public int updMenuM(@RequestBody MenuMVo vo) {
		return menuMService.updMenuM(vo);
	}

	@RequestMapping(value = "delMenuM.lims" )
	@ResponseBody
	public int delMenuM(@RequestBody List<MenuMVo> list) {
		return menuMService.delMenuM(list);
	}

	@RequestMapping(value = "getSchAuth.lims" )
	@ResponseBody
	public List<AuthMVo> getSchAuth(@RequestBody AuthMVo vo) {
		return menuMService.getSchAuth(vo);
	}

	@RequestMapping(value = "insManual.lims" )
	@ResponseBody
	public int insManual(@RequestBody MenuMVo vo) {
		return menuMService.insManual(vo);
	}

	@RequestMapping(value="searchEditorData")
	@ResponseBody
	public MenuMVo getEditorData(@RequestBody MenuMVo vo) {
		return menuMService.getEditorData(vo);
	}

	@RequestMapping(value = "chkBookMarkRegistred.lims")
	@ResponseBody
	public int chkBookMarkRegistred(@RequestBody MenuMVo vo) {
		return menuMService.chkBookMarkRegistred(vo);
	}

	@RequestMapping(value = "bookMarkControl.lims")
	@ResponseBody
	public MenuMVo bookMarkControl(@RequestBody MenuMVo vo) {
		return menuMService.bookMarkControl(vo);
	}

}
