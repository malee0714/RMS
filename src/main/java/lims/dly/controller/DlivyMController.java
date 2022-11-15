package lims.dly.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.dly.service.DlivyMService;
import lims.dly.service.Impl.DlivyAllamExcelUpload;
import lims.dly.vo.DlivyMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value = "/dly")
public class DlivyMController {

	@Resource(name = "DlivyMService")
	private DlivyMService dlivyMService;
	
	@Resource(name = "DlivyAllamExcelUpload")
	private DlivyAllamExcelUpload dlivyAllamExcelUpload;
	
	@Value("${form.file.download}")
	private String formFilePath;
	
	/**
	 * 미등록알림
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "DlivyM.lims")
	public String Dlivy(HttpServletRequest request, Model model){
		model.addAttribute("formFilePath", formFilePath);
		return "dly/DlivyM";
	}
	
	/**
	 * 바코드생성 양식 파일 업로드
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "applyFormFile.lims")
	public @ResponseBody HashMap<String, Object> applyFormFile(MultipartHttpServletRequest request) throws Exception{		
		return dlivyMService.applyFormFile(request);
		
	}
	
	/**
	 * INVOICE No 양식 파일 업로드
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "applyFormFile2.lims")
	public @ResponseBody HashMap<String, Object> applyFormFile2(MultipartHttpServletRequest request) throws Exception{		
		HashMap<String, Object> result =dlivyMService.applyFormFile2(request);
		return result;
		
	}
	
	/**
	 * D/O No 양식 파일 업로드
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "applyFormFile3.lims")
	public @ResponseBody HashMap<String, Object> applyFormFile3(MultipartHttpServletRequest request) throws Exception{		
		HashMap<String, Object> result =dlivyMService.applyFormFile3(request);
		return result;
		
	}
	
	/**
	 * 미등록알림 파일 업로드
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "dlivyAllamExcelUpload.lims")
	public @ResponseBody HashMap<String, Object> dlivyAllamExcelUpload(MultipartHttpServletRequest request) throws Exception{		
		return dlivyAllamExcelUpload.excelUpload(request);
		
	}
	
	
	
	/**
	 * 미등록 알림 리스트 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "getDlivyList.lims")
	public @ResponseBody List<DlivyMVo> getDlivyList(@RequestBody DlivyMVo vo){
		return dlivyMService.getDlivyList(vo);
	}
	
	/**
	 * 출고 이메일 이용자 리스트 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "getEmailDlivyList.lims")
	public @ResponseBody List<DlivyMVo> getEmailDlivyList(@RequestBody DlivyMVo vo){
		return dlivyMService.getEmailDlivyList(vo);
	}
	
	
	/**
	 * 미등록 알림 리스트 저장
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "insDlivyInfo.lims")
	public @ResponseBody int insDlivyInfo(@RequestBody DlivyMVo vo){
		return dlivyMService.insDlivyInfo(vo);
	}
	
	/**
	 * 출고 이메일 이용자 저장
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "insAddDlivyEmail.lims")
	public @ResponseBody int insAddDlivyEmail(@RequestBody DlivyMVo vo){
		return dlivyMService.insAddDlivyEmail(vo);
	}
	
	/**
	 * lot 유효성 체크
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "getLotValidation.lims")
	public @ResponseBody int getLotValidation(@RequestBody DlivyMVo vo){
		return dlivyMService.getLotValidation(vo);
	}
	
}
