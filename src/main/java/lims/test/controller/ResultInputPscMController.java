package lims.test.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.test.service.ResultInputPscMService;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/test")
public class ResultInputPscMController {
	                         
	@Resource(name = "ResultInputPscMService")
	private ResultInputPscMService resultInputPscMService;
	
	/**
	 * 결과 입력(공정)
	 * @param model
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "ResultInputPscM.lims")
	public String ResultInputPscM(Model model){
		
		return "test/ResultInputPscM";
	}
	
	/**
	 * 등록파일 업로드, 시험결과 저장
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "paraUpload.lims")
	public @ResponseBody HashMap<String, Object> paraUpload(MultipartHttpServletRequest request) throws Exception{		
		return resultInputPscMService.paraUpload(request);
		
	}
}
