package lims.qa.controller;

import lims.com.service.CmSanctnService;
import lims.com.vo.CmExmntDto;
import lims.qa.service.D8ReprtMService;
import lims.qa.service.D8ReprtMService;
import lims.qa.vo.AuditManageDto;
import lims.qa.vo.D8ReprtMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value="/qa")
public class D8ReprtMController {

	private final D8ReprtMService d8ReprtMService;
	private final CmSanctnService cmSanctnServiceImpl;

	@Autowired
    D8ReprtMController(D8ReprtMService d8ReprtMServiceImpl, CmSanctnService cmSanctnServiceImpl){
		this.d8ReprtMService = d8ReprtMServiceImpl;
		this.cmSanctnServiceImpl = cmSanctnServiceImpl;
	}

	@SetLocale()
	@RequestMapping(value = "D8ReprtM.lims")
	public String D8ReprtM (Model model, HttpServletRequest request) {

		return "qa/D8ReprtM";
	}

	@RequestMapping(value = "d8ReprtMList.lims")
	public @ResponseBody List<D8ReprtMVo> d8ReprtMList (@RequestBody D8ReprtMVo vo){
		return this.d8ReprtMService.d8ReprtMList(vo);
	}

	@RequestMapping(value = "insD8ReprtInfo.lims")
	public HttpEntity<D8ReprtMVo> insD8ReprtInfo (@RequestBody D8ReprtMVo vo){
		this.d8ReprtMService.insD8ReprtInfo(vo);
		return ResponseEntity.ok()
				.headers(new HttpHeaders())
				.body(vo);
	}

	@RequestMapping(value = "insD8ReprtApprovalM.lims")
	public ResponseEntity<D8ReprtMVo> insConfirmM (@RequestBody D8ReprtMVo vo){
		this.d8ReprtMService.insD8ReprtInfo(vo);
		this.cmSanctnServiceImpl.approvalRequest(vo);
		return ResponseEntity.ok(vo);
	}

	@RequestMapping("/d8SaveExmnt.lims")
	public ResponseEntity<Void> d8ReprtSaveExmnt(@RequestBody CmExmntDto cmExmntDto) {
		try {
			this.d8ReprtMService.saveExmnt(cmExmntDto);
			return ResponseEntity.ok().build();
		} catch (CustomException e) {
			throw e;
		}
	}

	@RequestMapping("/revertD8Reprt.lims")
	public ResponseEntity<D8ReprtMVo> revertD8Reprt(@RequestBody D8ReprtMVo d8ReprtMVo) {
		try {
			d8ReprtMService.revertD8Reprt(d8ReprtMVo);
			return ResponseEntity.ok(d8ReprtMVo);
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, d8ReprtMVo, "회수를 정상적으로 완료하지 못했습니다.");
		}
	}
}
