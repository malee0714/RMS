package lims.qa.controller;

import lims.com.vo.CmExmntDto;
import lims.qa.service.DocMService;
import lims.qa.vo.AuditManageDto;
import lims.qa.vo.DocDto;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.net.DatagramPacket;
import java.util.List;

@Controller
@RequestMapping(value="/qa")
public class DocMController {

	@Resource(name = "docMServiceImpl")
	private DocMService docMService;

	@SetLocale()
	@RequestMapping(value = "DocM.lims")
	public String DocM (Model model, HttpServletRequest request) {
		return "qa/DocM";
	}

	/**
	 * 문서 목록 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getDocList.lims")
	public @ResponseBody List<DocDto> getDocList(@RequestBody DocDto vo){
		return docMService.getDocList(vo);
	}

	/**
	 * 문서 이력 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getDocHistList.lims")
	public @ResponseBody List<DocDto> getDocHistList(@RequestBody DocDto vo){
		return docMService.getDocHistList(vo);
	}

	/**
	 * 문서 정보 임시 저장
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/insDocM.lims")
	public @ResponseBody DocDto insDocM(@RequestBody DocDto vo){
		try {
			docMService.insDocM(vo);
			return vo;
		} catch (CustomException e ) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, vo, "문서정보 저장/수정을 정상적으로 완료하지 못했습니다.");
		}
	}
	/**
	 * 문서 히스테리 정보 삭제
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/insConfirmM.lims")
	public @ResponseBody DocDto insConfirmM(@RequestBody DocDto vo){
		try {
			docMService.insConfirmM(vo);
			return vo;
		} catch (CustomException e ) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, vo, "문서정보 저장/수정을 정상적으로 완료하지 못했습니다.");
		}
	}
	
	@RequestMapping(value = "/getDocSanctnLineCombo.lims")
	public @ResponseBody List<DocDto> getDocSanctnLineCombo(@RequestBody DocDto vo){
		return docMService.getDocSanctnLineCombo(vo);
	}
	
	@RequestMapping(value = "/getMtrilNmCombo.lims")
	public @ResponseBody List<DocDto> getMtrilNmCombo(@RequestBody DocDto vo){
		return docMService.getMtrilNmCombo(vo);
	}
	
	@RequestMapping(value = "/getEntrpsNmCombo.lims")
	public @ResponseBody List<DocDto> getEntrpsNmCombo(@RequestBody DocDto vo){
		return docMService.getEntrpsNmCombo(vo);
	}

	@RequestMapping(value = "/docNoChk.lims")
	public @ResponseBody int docNoChk(@RequestBody DocDto vo, Model model){
		return docMService.docNoChk(vo);
	}
	
	@RequestMapping("/revertDoc.lims")
	@ResponseBody
	public DocDto revertDoc(@RequestBody DocDto docDto) {
		try {
			docMService.revertDoc(docDto);
			return docDto;
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, docDto, "회수를 정상적으로 완료하지 못했습니다.");
		}
	}
	
	/**
	 * 검토 정보 저장
	 * @param cmExmntDto 검토 dto
	 */
	@RequestMapping("/docSaveExmnt.lims")
	public ResponseEntity<Void> docSaveExmnt(@RequestBody CmExmntDto cmExmntDto) {
		try {
			docMService.saveExmnt(cmExmntDto);
			return ResponseEntity.ok().build();
		} catch (CustomException e) {
			throw e;
		}
	}
}
