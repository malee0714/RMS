package lims.com.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.com.service.RdmsCommonService;
import lims.com.vo.RdmsMVo;

@Controller
@RequestMapping("/com")
public class RdmsCommonController {
	
	@Resource(name="rdmsCommonServiceImpl")
	private RdmsCommonService rdmsCommonService; 

	//RDMS 데이터 추출
	@RequestMapping(value = "/getRdmsResultData.lims")
	public @ResponseBody void getRdmsResultData(@RequestBody List<RdmsMVo> vo, HttpServletRequest request){
		String ip = request.getRemoteAddr();
		System.out.println("check ip : " + ip);
		rdmsCommonService.getRdmsResultData(vo, ip);
	}
	//RDMS 데이터 삭제
		@RequestMapping(value = "/delRdmsResultData.lims")
		public @ResponseBody int delRdmsResultData(@RequestBody List<RdmsMVo> vo, HttpServletRequest request){
			rdmsCommonService.delRdmsResultData(vo);
			return 0;
		}
	
	//RDMS 컨버터 종료 권한 부여
	@RequestMapping(value = "/updateCloseCnvt.lims")
	public @ResponseBody int updateCloseCnvt(@RequestBody RdmsMVo vo){		
		return rdmsCommonService.updateCloseCnvt(vo); 
	}
	
	//RDMS 데이터 추출
	@RequestMapping(value = "/delBinderChck.lims")
	public @ResponseBody void delBinderChck(@RequestBody List<RdmsMVo> vo, HttpServletRequest request){		
		rdmsCommonService.delBinderChck(vo);
	}
	
}
