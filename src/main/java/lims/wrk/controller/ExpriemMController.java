package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.util.Locale.SetLocale;
import lims.wrk.service.ExpriemMService;
import lims.wrk.vo.ExpriemMVo;
@Controller
@RequestMapping("/wrk")
public class ExpriemMController {

	@Resource(name = "expriemMServiceImpl")
	private ExpriemMService expriemMService;

	@SetLocale()
	@RequestMapping(value = "ExpriemM.lims" )
	public String ExpriemM(Model model) {
		return "wrk/ExpriemM";
	}

	@RequestMapping(value = "getExpriemMList.lims" )
	public @ResponseBody List<ExpriemMVo> getExpriemMList(@RequestBody ExpriemMVo vo) {
		return expriemMService.getExpriemMList(vo);
	}

	@RequestMapping(value = "insExpriemM.lims" )
	public @ResponseBody String insExpriemM(@RequestBody ExpriemMVo vo) {
		expriemMService.insExpriemM(vo);
		return vo.getExpriemSeqno();
	}

	@RequestMapping(value = "updExpriemM.lims" )
	public @ResponseBody String updExpriemM(@RequestBody ExpriemMVo vo) {
		expriemMService.updExpriemM(vo);
		return vo.getExpriemSeqno();
	}

	@RequestMapping(value = "getExpriemNmCnt.lims" )
	public @ResponseBody int getExpriemNmCnt(@RequestBody ExpriemMVo vo) {
		return expriemMService.getExpriemNmCnt(vo);
	}

	@RequestMapping(value = "deleteExpriem.lims" )
	public @ResponseBody int deleteExpriem(@RequestBody ExpriemMVo vo) {
		return expriemMService.deleteExpriem(vo);
	}

	@RequestMapping(value = "updExpriemSortOrdr.lims")
	public @ResponseBody int updExpriemSortOrdr(@RequestBody List<ExpriemMVo> list) {
		return expriemMService.updExpriemSortOrdr(list);
	}
}