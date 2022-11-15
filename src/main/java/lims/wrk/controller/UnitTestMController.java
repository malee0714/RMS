package lims.wrk.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.com.vo.CmExmntDto;
import lims.qa.vo.AuditManageDto;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lims.wrk.service.UnitMService;
import lims.wrk.service.UnitTestMService;
import lims.wrk.vo.UnitTestMVo;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/sys")
public class UnitTestMController {
	
	
	@Autowired
	private UnitTestMService unitTestMServiceImpl;
	
	
	/**
	 * @param request
	 * @param model
	 * @return 페이지 이동
	 */
	@SetLocale()
	@RequestMapping(value = "UnitTestM.lims" )
	public String UnitTestM(HttpServletRequest request, Model model) {		
		return "wrk/UnitTestM";
		
	}
	
	// 단위 테스트 조건 조회
	@RequestMapping("/getUnitTestList.lims")
	@ResponseBody
	public List<UnitTestMVo> getUnitTestList(HttpServletRequest requestst, @RequestBody UnitTestMVo vo) {
		return unitTestMServiceImpl.getUnitTestList(vo);
	}
	
	// 메뉴별 담당자 모두 조회
	@RequestMapping("/getAllMenuCharger.lims")
	@ResponseBody
	public List<UnitTestMVo> getAllMenuCharger(HttpServletRequest requestst) {
		return unitTestMServiceImpl.getAllMenuCharger();
	}

	// 메뉴별 담당자 수정
	@RequestMapping("/saveMenuCharger.lims")
	@ResponseBody
	public ResponseEntity<UnitTestMVo> saveMenuCharger(@RequestBody UnitTestMVo unitTestMVo) {
		try {
			unitTestMServiceImpl.saveMenuCharger(unitTestMVo);
			return ResponseEntity.ok(unitTestMVo);
		} catch (CustomException e) {
			throw e;
		}
	}
	
	// 단위 테스트 삭제 업데이트
	@RequestMapping("/deleteUnitTest.lims")
	@ResponseBody
	public ResponseEntity<UnitTestMVo> deleteUnitTest(@RequestBody UnitTestMVo unitTestMVo) {
		try {
			unitTestMServiceImpl.deleteUnitTest(unitTestMVo);
			return ResponseEntity.ok(unitTestMVo);
		} catch (CustomException e) {
			throw e;
		}
	}
	
	// 메뉴 체인지 
	@RequestMapping("/changeInputChargerNm.lims")
	@ResponseBody
	public HashMap<String, String> changeInputChargerNm(@RequestBody Integer menuSeqno) {
		HashMap<String, String> data = new HashMap<>();
		String chargerNm = unitTestMServiceImpl.changeInputChargerNm(menuSeqno);
		data.put("chargerNm", chargerNm);
		
		return data;
	}
	
	
	
	// 단위 테스트 등록
	@RequestMapping("/saveUnitTest.lims")
	@ResponseBody
	public ResponseEntity<UnitTestMVo> saveUnitTest(@RequestBody UnitTestMVo unitTestMVo) {
		try {
			unitTestMServiceImpl.saveUnitTest(unitTestMVo);
			return ResponseEntity.ok(unitTestMVo);
		} catch (CustomException e) {
			throw e;
		}
	}
	
	// 단위 테스트 수정
	@RequestMapping("/updateUnitTest.lims")
	@ResponseBody
	public ResponseEntity<UnitTestMVo> updateUnitTest(@RequestBody UnitTestMVo unitTestMVo) {
		try {
			unitTestMServiceImpl.updateUnitTest(unitTestMVo);
			return ResponseEntity.ok(unitTestMVo);
		} catch (CustomException e) {
			throw e;
		}
	}
	
}
