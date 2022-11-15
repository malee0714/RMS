package lims.test.controller;

import lims.config.LocaleConfig;
import lims.test.service.ResultInputMService;
import lims.test.vo.ResultInputMVo;
import lims.test.vo.RoaMVo;
import lims.util.Locale.SetLocale;
import lims.util.ScriptEngineUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/test")
//@RequiredArgsConstructor
public class ResultInputMController {
	
	private final ResultInputMService resultInputMService;
	
	@Autowired
	public ResultInputMController(ResultInputMService resultInputMServiceImpl) {
		this.resultInputMService = resultInputMServiceImpl;
	}
	
	@SetLocale()
	@RequestMapping(value="ResultInputM.lims")
	public String ResultInputM(Model model) throws IOException {

		System.out.println(">> : " + ScriptEngineUtil.class.getClassLoader().getResource("").getPath());
		return "test/ResultInputM";
	}
	 
	//의뢰 목록 조회
	@RequestMapping(value="getReqestListSch.lims")
	public @ResponseBody List<ResultInputMVo> getReqestListSch(@RequestBody ResultInputMVo vo){
		return this.resultInputMService.getReqestListSch(vo); 
	}
	 
	//시험항목 목록 조회
	@RequestMapping(value="getExpriemListSch.lims")
	public @ResponseBody List<ResultInputMVo> getExpriemListSch(@RequestBody ResultInputMVo vo){
		List<ResultInputMVo> list = this.resultInputMService.getExpriemListSch(vo);
		return list;
	}

	//저장
	@RequestMapping(value="saveExpriemResult.lims")
	public @ResponseBody void saveExpriemResult(@RequestBody ResultInputMVo vo){
		this.resultInputMService.saveExpriemResult(vo);
	}

	//결과입력 완료
	@RequestMapping(value="completeResultInput.lims")
	public @ResponseBody void completeResultInput(@RequestBody ResultInputMVo vo){
		this.resultInputMService.completeResultInput(vo);
	}
	
	//계산식 변수 그리드 조회
	@RequestMapping(value="getExpriemCalcNomfrm.lims")
	public @ResponseBody List<ResultInputMVo> getExpriemCalcNomfrm(@RequestBody ResultInputMVo vo){
		return this.resultInputMService.getExpriemCalcNomfrm(vo);
	}
	
	
	@RequestMapping(value="returnExpriem.lims")
	public @ResponseBody void returnExpriem(@RequestBody ResultInputMVo vo){
		this.resultInputMService.returnExpriem(vo);
	}
	
	@RequestMapping(value="changeToNextOdr.lims")
	public @ResponseBody void changeToNextOdr(@RequestBody ResultInputMVo vo){
		this.resultInputMService.changeToNextOdr(vo);
	}
}
