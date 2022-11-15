package lims.qa.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.com.vo.CmExmntDto;
import lims.com.vo.ComboVo;
import lims.qa.service.PcnMService;
import lims.qa.vo.PcnMVo;
import lims.qa.vo.QlityDocHistVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/qa")
public class PcnMController {
	
	@Resource(name = "PcnMService")
	private PcnMService pcnMService;
	
	@SetLocale()
	@RequestMapping(value = "PcnM.lims")
	public String PcnM(HttpServletRequest request, Model model) {
		return "qa/PcnM";
	}
	
	@RequestMapping(value = "/getPcnList.lims")
	public @ResponseBody List<PcnMVo> getPcnList(@RequestBody PcnMVo vo, HttpServletRequest request) {
		return pcnMService.getPcnList(vo);
	}
	
	@RequestMapping(value = "/insPcnInfo.lims")
	public ResponseEntity<PcnMVo> insPcnInfo(@RequestBody PcnMVo vo, HttpServletRequest request) {
		try {
			pcnMService.insPcnInfo(vo);
			return ResponseEntity.ok(vo);
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, vo, "PCN정보 저장/수정을 정상적으로 완료하지 못했습니다.");
		}
	}
	
	@RequestMapping(value = "/updPcnInfo.lims")
	public ResponseEntity<PcnMVo> updPcnInfo(@RequestBody PcnMVo vo, HttpServletRequest request) {
		try {
			pcnMService.updPcnInfo(vo);
			return ResponseEntity.ok(vo);
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, vo, "PCN정보 저장/수정을 정상적으로 완료하지 못했습니다.");
		}
	}
	
	/**
	 * 입력 결재 승인
	 */
	@RequestMapping("/insApprovalPcnM.lims")
	public ResponseEntity<PcnMVo> insApprovalPcnM(@RequestBody PcnMVo vo, HttpServletRequest request) {
		try {
			pcnMService.insApprovalPcnM(vo);
			return ResponseEntity.ok(vo);
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, vo, "PCN정보 저장/수정을 정상적으로 완료하지 못했습니다.");
		}
	}
	
	
	/**
	 * 업데이트 결재 승인
	 */
	@RequestMapping("/updApprovalPcnM.lims")
	public ResponseEntity<PcnMVo> updApprovalPcnM(@RequestBody PcnMVo vo, HttpServletRequest request) {
		try {
			pcnMService.updApprovalPcnM(vo);
			return ResponseEntity.ok(vo);
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, vo, "PCN정보 저장/수정을 정상적으로 완료하지 못했습니다.");
		}
	}
	
	
	// 고객사 이름 조회 
	@RequestMapping(value = "/getEntrpsNameList.lims")
	public @ResponseBody List<ComboVo> getEntrpsNameList(HttpServletRequest request) {
		return pcnMService.getEntrpsNameList();
	}
	
	// 해당 제품 이름 조회
	@RequestMapping(value = "/getMtrilNameList.lims")
	public @ResponseBody List<ComboVo> getMtrilNameList(HttpServletRequest request) {
		return pcnMService.getMtrilNameList();
	}
	
	/**
	 * 검토 정보 저장
	 * @param cmExmntDto 검토 dto
	 */
	@RequestMapping("/pcnManageSaveExmnt.lims")
	public ResponseEntity<Void> pcnManageSaveExmnt(@RequestBody CmExmntDto cmExmntDto) {
		try {
			pcnMService.saveExmnt(cmExmntDto);
			return ResponseEntity.ok().build();
		} catch (CustomException e) {
			throw e;
		}
	}
	
	/**
	 * 회수
	 */
	@RequestMapping("/revertPcn.lims")
	public ResponseEntity<PcnMVo> revertPcn(@RequestBody PcnMVo vo, HttpServletRequest request) {
		try {
			pcnMService.revertPcn(vo);
			return ResponseEntity.ok(vo);
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, vo, "회수를 정상적으로 완료하지 못했습니다.");
		}
	}
	
}
