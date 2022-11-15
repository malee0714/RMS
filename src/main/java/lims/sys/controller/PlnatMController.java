package lims.sys.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.service.PlnatMService;
import lims.sys.vo.PlnatMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value = "/sys")
public class PlnatMController {

	@Resource(name = "plnatMServiceImpl")
	private PlnatMService plnatMService;

	@SetLocale()
	@RequestMapping(value = "/PlnatM.lims")
	public String PlnatM(HttpServletRequest request, Model model) {
		return "sys/PlnatM";
	}

	@RequestMapping(value = "/getPlnatMList")
	public @ResponseBody List<PlnatMVo> getPlnatMList(@RequestBody PlnatMVo vo) {
		return plnatMService.getPlnatMList(vo);
	}

	@RequestMapping(value = "/insPlnat.lims")
	public @ResponseBody int insPlnat(@RequestBody List<PlnatMVo> list) {
		try{
		return plnatMService.insPlnat(list);
	}catch (Exception e){
		throw new CustomException(e,list,"저장이 정상적으로 처리되지 않았습니다");
	}
	}

	@RequestMapping(value = "/getlbcstList.lims")
	public @ResponseBody List<PlnatMVo> getlbcstList(@RequestBody PlnatMVo vo) {
		return plnatMService.getlbcstList(vo);
	}
	@RequestMapping(value = "/getPlnatQlityCtAmMList.lims")
	public @ResponseBody List<PlnatMVo> getPlnatQlityCtAmMList(@RequestBody PlnatMVo vo) {
		return plnatMService.getPlnatQlityCtAmMList(vo);
	}

	@RequestMapping(value = "/putPlnatQlityCtAm.lims")
	public @ResponseBody int putPlnatQlityCtAm(@RequestBody PlnatMVo vo) {
		try{
		return plnatMService.putPlnatQlityCtAm(vo);
	}catch (Exception e){
		throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
	}
	}
}
