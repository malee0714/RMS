package lims.rsc.controller;

import lims.com.vo.ComboVo;
import lims.rsc.service.CustlabEdayChckService;
import lims.rsc.vo.CustlabEdayChckRegistDto;
import lims.rsc.vo.CustlabEdayChckResultDto;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping(value = "/rsc")
public class CustlabEdayChckController {

	private final CustlabEdayChckService custlabEdayChckServiceImpl;

	@Autowired
	public CustlabEdayChckController(CustlabEdayChckService custlabEdayChckServiceImpl) {
		this.custlabEdayChckServiceImpl = custlabEdayChckServiceImpl;
	}

	@SetLocale
	@RequestMapping("/CustlabEdayChck.lims")
	public String returnPage(Model model) {
		return "/rsc/CustlabEdayChck";
	}
	
	@SetLocale
	@RequestMapping("/CustlabEdayChckSearch.lims")
	public String returnSearchPage(Model model) {
		return "/rsc/CustlabEdayChckSearch";
	}

	@RequestMapping("/getCustlabCombo.lims")
	@ResponseBody
	public List<ComboVo> getCustlabCombo() {
		return custlabEdayChckServiceImpl.getCustlabCombo();
	}

	@RequestMapping("/getCustlabEdayCheckList.lims")
	@ResponseBody
	public List<CustlabEdayChckRegistDto> getCustlabEdayCheckRegistList(@RequestBody CustlabEdayChckRegistDto custlabEdayChckRegistDto) {
		return custlabEdayChckServiceImpl.getCustlabEday(custlabEdayChckRegistDto);
	}
	
	@RequestMapping("/getCustlabEdayCheckResultList.lims")
	@ResponseBody
	public List<CustlabEdayChckResultDto> getCustlabEdayCheckResultList(@RequestBody CustlabEdayChckRegistDto custlabEdayChckRegistDto) {
		return custlabEdayChckServiceImpl.getCustlabEdayCheckResultList(custlabEdayChckRegistDto);
	}
	
	@RequestMapping("/getCustlabEdayCheckResultSearchList.lims")
	@ResponseBody
	public List<CustlabEdayChckResultDto> getCustlabEdayCheckResultSearchList(@RequestBody CustlabEdayChckRegistDto custlabEdayChckRegistDto) {
		return custlabEdayChckServiceImpl.getCustlabEdayCheckResultSearchList(custlabEdayChckRegistDto);
	}
	
	@RequestMapping("/saveEveryDayCheckRegist.lims")
	public ResponseEntity<CustlabEdayChckRegistDto> saveEveryDayCheckRegist(@RequestBody CustlabEdayChckRegistDto custlabEdayChckRegistDto) {
		try {
			custlabEdayChckServiceImpl.saveEveryDayCheckRegist(custlabEdayChckRegistDto);
			return ResponseEntity.ok(custlabEdayChckRegistDto);
		} catch (IllegalStateException e){
			throw new CustomException(e, custlabEdayChckRegistDto, e.getMessage());
		} catch (Exception e) {
			throw new CustomException(e, custlabEdayChckRegistDto, "분석실 일상 점검 정보 저장/수정이 정상적으로 완료되지 않았습니다.");
		}
	}
	
	@RequestMapping("/deleteEveryDayCheckRegist.lims")
	public ResponseEntity<Void> deleteEveryDayCheckRegist(@RequestBody CustlabEdayChckRegistDto custlabEdayChckRegistDto) {
		try {
			custlabEdayChckServiceImpl.deleteEveryDayCheckRegist(custlabEdayChckRegistDto);
			return ResponseEntity.ok().build();
		} catch (IllegalStateException e){
			throw new CustomException(e, custlabEdayChckRegistDto, e.getMessage());
		} catch (Exception e) {
			throw new CustomException(e, custlabEdayChckRegistDto, "분석실 일상 점검 정보 삭제가 정상적으로 완료되지 않았습니다.");
		}
	}
}
