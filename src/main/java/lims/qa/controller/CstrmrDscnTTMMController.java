package lims.qa.controller;

import lims.com.service.CmSanctnService;
import lims.com.service.impl.CmSanctnServiceImpl;
import lims.com.vo.CmExmntDto;
import lims.qa.service.CstrmrDscnTTMMService;
import lims.qa.vo.CstrmrDscnTtmmVo;
import lims.qa.vo.D8ReprtMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping(value="/qa")
public class CstrmrDscnTTMMController {

	private final CstrmrDscnTTMMService cstrmrDscnTTMMService;
	private final CmSanctnService cmSanctnServiceImpl;

	@Autowired
	CstrmrDscnTTMMController(CstrmrDscnTTMMService cstrmrDscnTTMMServiceImpl, CmSanctnService cmSanctnServiceImpl){
		this.cstrmrDscnTTMMService = cstrmrDscnTTMMServiceImpl;
		this.cmSanctnServiceImpl = cmSanctnServiceImpl;
	}

	@SetLocale()
	@RequestMapping(value = "CstrmrDscnTTM.lims")
	public String CstrmrDscnTTM (Model model, HttpServletRequest request) {

		return "qa/CstrmrDscnTTM";
	}

	@RequestMapping(value = "CstrmrDscnTTMList.lims")
	public @ResponseBody List<CstrmrDscnTtmmVo> CstrmrDscnTTMList (@RequestBody CstrmrDscnTtmmVo vo){
		return this.cstrmrDscnTTMMService.CstrmrDscnTTMList(vo);
	}

	@RequestMapping(value = "insCstrmrInfo.lims")
	public HttpEntity<CstrmrDscnTtmmVo> insCstrmrInfo (@RequestBody CstrmrDscnTtmmVo vo){
		this.cstrmrDscnTTMMService.insCstrmrInfo(vo);
//		return new ResponseEntity<CstrmrDscnTtmmVo>(vo, null, HttpStatus.OK);
		return ResponseEntity.ok()
				.headers(new HttpHeaders())
				.body(vo);
	}

	@RequestMapping(value = "/removeCstmrUser.lims")
	public HttpEntity<CstrmrDscnTtmmVo> removeCstmrUser (@RequestBody CstrmrDscnTtmmVo vo){
		this.cstrmrDscnTTMMService.removeCstmrUser(vo);
		return ResponseEntity.ok()
				.headers(new HttpHeaders())
				.body(vo);
	}

	@RequestMapping(value = "insCstrmrApprovalM.lims")
	public ResponseEntity<CstrmrDscnTtmmVo> insConfirmM (@RequestBody CstrmrDscnTtmmVo vo){
		this.cstrmrDscnTTMMService.insCstrmrInfo(vo);
		this.cmSanctnServiceImpl.approvalRequest(vo);
		return ResponseEntity.ok(vo);
	}

	@RequestMapping(value = "getCstmrUserList.lims")
	public @ResponseBody
	List<CstrmrDscnTtmmVo> getCstmrUserList (@RequestBody CstrmrDscnTtmmVo vo){
		return this.cstrmrDscnTTMMService.getCstmrUserList(vo);
	}

	@RequestMapping("/cstrmrSaveExmnt.lims")
	public ResponseEntity<Void> cstrmrSaveExmnt(@RequestBody CmExmntDto cmExmntDto) {
		try {
			this.cstrmrDscnTTMMService.saveExmnt(cmExmntDto);
			return ResponseEntity.ok().build();
		} catch (CustomException e) {
			throw e;
		}
	}

	@RequestMapping("/revertCstrmrDscntt.lims")
	public ResponseEntity<CstrmrDscnTtmmVo> revertCstrmrDscntt(@RequestBody CstrmrDscnTtmmVo vo) {
		try {
			this.cstrmrDscnTTMMService.revertCstrmrDscntt(vo);
			return ResponseEntity.ok(vo);
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, vo, "회수를 정상적으로 완료하지 못했습니다.");
		}
	}
}
