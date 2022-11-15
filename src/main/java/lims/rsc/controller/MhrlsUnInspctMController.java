package lims.rsc.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.rsc.service.MhrlsUnInspctMService;
import lims.rsc.vo.MhrlsUnInspctMVo;
import lims.sys.vo.UserMVo;
import lims.util.Locale.SetLocale;

@RequestMapping(value = "/reg")
@Controller
public class MhrlsUnInspctMController {

	@Resource(name = "MhrlsUnInspctMService")
	private MhrlsUnInspctMService mhrlsUnInspctMService;
	
	@Value("${form.file.download}")
	private String formFilePath;
	
	/**
	 * 미등록 기기 검교정 페이지
	 * @param request
	 * @param model
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "MhrlsUnInspctM.lims")
	public String MhrlsUnInspctM(HttpServletRequest request, Model model){
		model.addAttribute("formFilePath", formFilePath);
		return "rsc/MhrlsUnInspctM";
	}
	
	/**
	 * 미등록 설비 검교정 목록 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "getMhrlsUnInspctM.lims")
	public @ResponseBody List<MhrlsUnInspctMVo> getMhrlsUnInspctM(@RequestBody MhrlsUnInspctMVo vo){
		return mhrlsUnInspctMService.getMhrlsUnInspctM(vo);
		
	}
	
	/**
	 * 미등록 설비 검교정 목록 조회 (월별)
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "getMonthMhrlsUnInspctM.lims")
	public @ResponseBody List<MhrlsUnInspctMVo> getMonthMhrlsUnInspctM(@RequestBody MhrlsUnInspctMVo vo){
		return mhrlsUnInspctMService.getMonthMhrlsUnInspctM(vo);
		
	}
	/**
	 * 미등록 설비 검교정 목록 조회 (부서별)
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "getdeptMhrlsUnInspctM.lims")
	public @ResponseBody List<MhrlsUnInspctMVo> getdeptMhrlsUnInspctM(@RequestBody MhrlsUnInspctMVo vo){
		return mhrlsUnInspctMService.getdeptMhrlsUnInspctM(vo);
		
	}
	
	/**
	 * 미등록 설비 검교정 목록 저장
	 * @param vo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "saveMhrlsUnInspctM.lims")
	public @ResponseBody int saveMhrlsUnInspctM(@RequestBody MhrlsUnInspctMVo vo, HttpServletRequest request){
		return mhrlsUnInspctMService.saveMhrlsUnInspctM(vo);
	}
	
	/**
	 * 양식 파일 업로드
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "applyFormFile.lims")
	public @ResponseBody int applyFormFile(MultipartHttpServletRequest request) throws Exception{		
		return mhrlsUnInspctMService.applyFormFile(request);
		
	}
	
}
