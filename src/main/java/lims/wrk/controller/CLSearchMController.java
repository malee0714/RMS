package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lims.wrk.service.CLSearchMService;
import lims.wrk.vo.CLVersionResultVO;
import lims.wrk.vo.CLVersionVO;

@Controller
@RequestMapping("/wrk")
public class CLSearchMController {
	
	private final CLSearchMService clSearchMServiceImpl;

	@Autowired
	public CLSearchMController(CLSearchMService cLSearchMServiceImpl) {
		this.clSearchMServiceImpl = cLSearchMServiceImpl;
	}

	@SetLocale
	@RequestMapping(value = "CLSearchM.lims")
	public String clSearchM(HttpServletRequest request, Model model) {
		return "wrk/CLSearchM";
	}
	
	/**
	 * 자재별 version 목록
	 */
	@RequestMapping(value = "getCLVersions.lims")
	public @ResponseBody List<CLVersionVO> getCLVersions(@RequestBody CLVersionVO vo) {
		return clSearchMServiceImpl.getCLVersions(vo);
	}
	
	/**
	 * version별 결과 목록 
	 */
	@RequestMapping(value = "getCLVersionResults.lims")
	public @ResponseBody List<CLVersionResultVO> getCLVersionResults(@RequestBody CLVersionResultVO vo) {
		return clSearchMServiceImpl.getCLVersionResults(vo);
	}
	
	@RequestMapping(value = "updateClVersionResult.lims")
	public ResponseEntity<Void> updateClVersionResult(@RequestBody List<CLVersionResultVO> list) {
		try {
			clSearchMServiceImpl.updateClVersionResult(list);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			throw new CustomException(e, "버전별 CL 결과값 수정이 정상적으로 완료되지 않았습니다.");
		}
	}
}
