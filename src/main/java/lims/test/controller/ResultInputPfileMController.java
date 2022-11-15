package lims.test.controller;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import lims.test.service.ResultInputPfileMService;



@Controller
@RequestMapping("/test")
public class ResultInputPfileMController {
	@Resource(name = "ResultInputPfileMService")
	private ResultInputPfileMService resultInputPfileMService;
	
	@RequestMapping(value = "ResultInputPfileM.lims")
	public String ResultInputPfileM(Model model){
		return "test/ResultInputPfileM";
	}
	
	
	@RequestMapping(value = "fileTxtUpload.lims")
	public @ResponseBody HashMap<String, Object> fileTxtUpload(MultipartHttpServletRequest request) throws Exception{	
		System.out.println(request);
		return resultInputPfileMService.fileTxtUpload(request);
		
	}
	
}
