package lims.rsc.controller;

import lims.rsc.service.CustlabManageService;
import lims.rsc.vo.CustlabExpriemDto;
import lims.rsc.vo.CustlabDto;
import lims.rsc.vo.CustlabProductDto;
import lims.rsc.vo.CustlabWorkerDto;
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
@RequestMapping(value="/rsc")
public class CustlabManageController {

	private final CustlabManageService custlabManageServiceImpl;

	@Autowired
	public CustlabManageController(CustlabManageService custlabManageServiceImpl) {
		this.custlabManageServiceImpl = custlabManageServiceImpl;
	}

	@SetLocale
	@RequestMapping("/CustlabM.lims")
	public String returnPage(Model model){
		return "/rsc/CustlabM";
	}

	@RequestMapping("/getCustlab.lims")
	@ResponseBody
	public List<CustlabDto> getCustlab(@RequestBody CustlabDto custlabDto) {
		return custlabManageServiceImpl.getCustlab(custlabDto);
	}
	
	@RequestMapping("/getCustlabWorkers.lims")
	@ResponseBody
	public List<CustlabWorkerDto> getCustlabWorkers(@RequestBody CustlabWorkerDto workerDto) {
		return custlabManageServiceImpl.getCustlabWorkers(workerDto);
	}
	
	@RequestMapping("/getCustlabProducts.lims")
	@ResponseBody
	public List<CustlabProductDto> getCustlabProducts(@RequestBody CustlabDto custlabDto) {
		return custlabManageServiceImpl.getCustlabProducts(custlabDto);
	}
	
	@RequestMapping("/getCustlabDayExpriems.lims")
	@ResponseBody
	public List<CustlabExpriemDto> getCustlabDayExpriems(@RequestBody CustlabDto custlabDto) {
		return custlabManageServiceImpl.getCustlabDayExpriems(custlabDto);
	}
	
	@RequestMapping("/saveCustlab.lims")
	public ResponseEntity<CustlabDto> saveCustlab(@RequestBody CustlabDto custlabDto) {
		try {
			custlabManageServiceImpl.saveCustlab(custlabDto);
			return ResponseEntity.ok(custlabDto);
		} catch (IllegalStateException e){
			throw new CustomException(e, custlabDto, e.getMessage());
		} catch (Exception e) {
			throw new CustomException(e, custlabDto, "분석실정보 저장/수정이 정상적으로 완료되지 않았습니다.");
		}
	}
	
	@RequestMapping("/deleteCustlab.lims")
	public ResponseEntity<Void> deleteCustlab(@RequestBody CustlabDto custlabDto) {
		try {
			custlabManageServiceImpl.deleteCustlab(custlabDto);
			return ResponseEntity.ok().build();
		} catch (IllegalStateException e){
			throw new CustomException(e, custlabDto, e.getMessage());
		} catch (Exception e) {
			throw new CustomException(e, custlabDto, "분석실정보 삭제가 정상적으로 완료되지 않았습니다.");
		}
	}

	@RequestMapping("/selectchrgDeptCode.lims")
	@ResponseBody
	public String selectchrgDeptCode(@RequestBody CustlabDto custlabDto){
			return custlabManageServiceImpl.selectchrgDeptCode(custlabDto);
	}
}