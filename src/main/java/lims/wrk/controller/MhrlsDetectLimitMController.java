package lims.wrk.controller;

import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lims.wrk.service.MhrlsDetectLimitMService;
import lims.wrk.vo.MhrlsDetectLimitMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value="/wrk")
public class MhrlsDetectLimitMController {
	
	private final MhrlsDetectLimitMService mhrlsDetectLimitMServiceImpl;

	@Autowired
	public MhrlsDetectLimitMController(MhrlsDetectLimitMService mhrlsDetectLimitMServiceImpl) {
		this.mhrlsDetectLimitMServiceImpl = mhrlsDetectLimitMServiceImpl;
	}

	@SetLocale
	@RequestMapping(value = "MhrlsDetectLimitM.lims")
	public String MhrlsDl(HttpServletRequest request, Model model) {
		return "wrk/MhrlsDetectLimitM";
	}
	
	//조회
	@RequestMapping(value = "/getDLExpriems.lims")
	public @ResponseBody List<MhrlsDetectLimitMVo> getDLExpriems(@RequestBody MhrlsDetectLimitMVo vo){
		return mhrlsDetectLimitMServiceImpl.getDLExpriems(vo);
	}
	
	@RequestMapping("/saveExprDl.lims")
	public @ResponseBody int saveExprDl( @RequestBody MhrlsDetectLimitMVo vo ){
		try {
			return mhrlsDetectLimitMServiceImpl.saveExprDl(vo);
		} catch (Exception e) {
			throw new CustomException(e, vo, "시험항목 DL 저장이 정상적으로 완료되지 않았습니다.");
		}
	}

}
