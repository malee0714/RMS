package lims.rsc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.rsc.service.CndtnCheckMService;
import lims.rsc.vo.CndtnCheckMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.util.Locale.SetLocale;
import net.sf.json.JSONObject;


@Controller
@RequestMapping(value="/reg")
public class CndtnCheckMController {
	
	
	@Resource(name = "cndtnCheckMServiceImpl")
	private CndtnCheckMService cndtnCheckMService;
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@SetLocale()
	@RequestMapping(value = "CndtnCheckM.lims")
	public String CndtnCheckM(Model model, HttpServletRequest request) {	
		return "rsc/CndtnCheckM";
	}
	
	@SetLocale()
	@RequestMapping(value = "ChartM.lims")
	public String ChartM(Model model, HttpServletRequest request) {	
		return "rsc/ChartM";
	}
	
	// 상단 그리드 조회
	@RequestMapping(value = "/getcndtn.lims")
	public @ResponseBody List<CndtnCheckMVo> getcndtn(@RequestBody CndtnCheckMVo vo){
		return cndtnCheckMService.getcndtn(vo);
	}
	
	// 하단 그리드 조회
	@RequestMapping(value = "/getCnd.lims")
	public @ResponseBody List<CndtnCheckMVo> getCnd(@RequestBody CndtnCheckMVo vo){
		return cndtnCheckMService.getCnd(vo);
	}
	// 상단 그리드 클릭시 하단 그리드 조회(디테일)
	@RequestMapping(value = "/getCndVal.lims")
	public @ResponseBody List<CndtnCheckMVo> getCndVal(@RequestBody CndtnCheckMVo vo){
		return cndtnCheckMService.getCndVal(vo);
	}
	
	// 그리드 조회(기기값 및 날짜 값이 있을 경우 보여주기 위함)
	@RequestMapping(value = "/selectmhr.lims")
	public @ResponseBody List<CndtnCheckMVo> selectmhr(@RequestBody CndtnCheckMVo vo){
		return cndtnCheckMService.selectmhr(vo);
	}
	
	// 수치 차트 조회
	@RequestMapping(value = "/getchValueList.lims")
	public @ResponseBody List<CndtnCheckMVo> getchValueList(@RequestBody CndtnCheckMVo vo){
		return cndtnCheckMService.getchValueList(vo);
	}
	
	// 넘어온 값으로 차트 조회
	@RequestMapping(value = "/getchkValueList.lims")
	public @ResponseBody CndtnCheckMVo getchkValueList(@RequestBody CndtnCheckMVo vo){
		return cndtnCheckMService.getchkValueList(vo);
	}

	
	// 테이블값 저장
	@RequestMapping(value = "/saveCndtnDetail.lims")
	public @ResponseBody int saveCndtnDetail(@RequestBody CndtnCheckMVo list,Model model, HttpServletRequest request){
		return cndtnCheckMService.saveCndtnDetail(list);
	}
}
