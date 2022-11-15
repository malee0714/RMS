package lims.src.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import lims.spc.dao.SpcRuleTestDao;
import lims.spc.enm.ResultValueType;
import lims.spc.service.SpcRuleTestService;
import lims.spc.vo.SpcChart;
import lims.spc.vo.SpcParam;
import lims.spc.vo.SpcMtrilExpriem;
import lims.spc.vo.SpcRuleTestDto;
import lims.test.vo.ResultInputMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.src.service.DataChartMService;
import lims.src.vo.DataChartMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/src")
public class DataChartMController {

	private final DataChartMService dataChartMService;
	private final SpcRuleTestService spcRuleTestServiceImpl;
	private final SpcRuleTestDao spcRuleTestDao;

	@Autowired
	public DataChartMController(DataChartMService dataChartMServiceImpl, SpcRuleTestService spcRuleTestServiceImpl, SpcRuleTestDao spcRuleTestDao) {
		this.dataChartMService = dataChartMServiceImpl;
		this.spcRuleTestServiceImpl = spcRuleTestServiceImpl;
		this.spcRuleTestDao = spcRuleTestDao;
	}
	@SetLocale
	@RequestMapping(value="DataChartM.lims")
	public String DataChartM(Model model){
		return"src/DataChartM";
	}
	@RequestMapping(value = "/getDialogClickList.lims")
	public @ResponseBody List<ResultInputMVo> getDocList(@RequestBody ResultInputMVo vo, HttpServletRequest request){
		List<ResultInputMVo> result = dataChartMService.getDialogClickList(vo);
		return result;
	}
	@RequestMapping(value = "getDataChartList.lims" )
	@ResponseBody
	public List<SpcChart> getDataChartList(@RequestBody DataChartMVo vo) {
		
		SpcRuleTestDto spcRuleTestVO = SpcRuleTestDto
				.builder()
				.mtrilSeqno(vo.getMtrilSeqnoSch())
				.entrpsSeqno(vo.getEntrpsSeqnoSch())
				.mnfcturStartDte(vo.getMnfcturBeginDte())
				.mnfcturEndDte(vo.getMnfcturEndDte())
				.inspctTyCode(vo.getInspctTyCodeSch())
				.findFirst(false)
				.chartData(true)
				.coaAt(vo.getCoaAtSch())
				.qc(vo.isQcAtSch()) //boolean
				.build();
				
		return spcRuleTestServiceImpl.chartDataSupply(spcRuleTestVO);
	}
}
