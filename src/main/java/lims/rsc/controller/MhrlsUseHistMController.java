package lims.rsc.controller;

import lims.rsc.service.MhrlsUseHistMService;
import lims.rsc.vo.MhrlsUseHistMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/rsc")
public class MhrlsUseHistMController {
	
	@Resource(name = "MhrlsUseHistMService")
	MhrlsUseHistMService mHrlsUseHistMService; 

	@SetLocale()
	@RequestMapping(value = "MhrlsUseHistM.lims" )
	public String MhrlsUseHistM(HttpServletRequest request, Model model) {
		return "rsc/MhrlsUseHistM";
	}

	@RequestMapping(value = "/getMhrlsUseHistM.lims")
	public @ResponseBody List<MhrlsUseHistMVo> getMhrlsUseHistM(@RequestBody MhrlsUseHistMVo vo, HttpServletRequest request){
		List<MhrlsUseHistMVo> result = mHrlsUseHistMService.getMhrlsUseHistM(vo);
		return result;
	}
	
	@RequestMapping(value = "/insMhrlsUseHistM.lims")
	public @ResponseBody int insMhrlsUseHistM(@RequestBody MhrlsUseHistMVo vo, HttpServletRequest request){
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		vo.setLastChangerId(UserMVo.getUserId());
		int result = mHrlsUseHistMService.insMhrlsUseHistM(vo);
		return result;
	}
	
	@RequestMapping(value = "/updMhrlsUseHistDel.lims")
	public @ResponseBody int updMhrlsUseHistDel(@RequestBody MhrlsUseHistMVo vo, HttpServletRequest request){
		return mHrlsUseHistMService.updMhrlsUseHistDel(vo);
	}
}
