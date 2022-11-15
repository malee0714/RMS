package lims.wrk.controller;

import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lims.wrk.service.CLManageMService;
import lims.wrk.vo.CLManageMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/wrk")
public class CLManageMController {

	private final CLManageMService clmanageMService;

	@Autowired
	public CLManageMController(CLManageMService CLManageMServiceImpl) {
		this.clmanageMService = CLManageMServiceImpl;
	}

	@SetLocale
	@RequestMapping(value = "CLManageM.lims" )
	public String productM(Model model) {
		return "wrk/CLManageM";
	}

	/**
	 * 자재목록 조회
	 */
	@RequestMapping(value = "/getCLManageList.lims" )
	public @ResponseBody List<CLManageMVo> getCLManageList(@RequestBody CLManageMVo vo) {
		return clmanageMService.getCLManageList(vo);
	}

	/**
	 * 저장
	 */
	@RequestMapping(value = "/updateCLM.lims" )
	public @ResponseBody int updateCLM(@RequestBody List<CLManageMVo> list) {
		try {
			return clmanageMService.updateCLM(list);
		} catch (Exception e) {
			throw new CustomException(e,"산정기준 저장이 정상적으로 완료되지 않았습니다.");
		}
	}
}
