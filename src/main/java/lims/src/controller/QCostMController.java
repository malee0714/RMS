package lims.src.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.controller.DsuseMController;
import lims.src.service.QCostMService;
import lims.src.service.RequestCntMService;
import lims.src.vo.QCostMVo;
import lims.src.vo.RequestCntMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/src")

public class QCostMController {
	
	@Resource(name = "QCostMServiceImpl")
	public QCostMService qCostMService;
	
	/**
	 * 부서별 의뢰 건수
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "/QCostM.lims")
	public String QcostM(Model model){
		return "src/QCostM";
	}
	
	/**
	 * 부서별 의뢰건수 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getQCostList.lims")
	public @ResponseBody List<QCostMVo> getQCostList(@RequestBody QCostMVo vo,HttpServletRequest request){

		try {
			return qCostMService.getQCostList(vo);
		}catch(Exception e) {
			throw new CustomException(e, vo, "Q COST 목록이 정상적으로 조회되지 않았습니다.");
		}
	}
	
	@RequestMapping(value = "/getCost.lims")
	public @ResponseBody List<QCostMVo> getCost(@RequestBody List<QCostMVo> list,HttpServletRequest request){
		return qCostMService.getCost(list);
	}
	@RequestMapping(value = "/getCostYear.lims")
	public @ResponseBody List<QCostMVo> getCostYear(@RequestBody QCostMVo vo,HttpServletRequest request){
		return qCostMService.getCostYear(vo);
	}
	@RequestMapping(value = "/getCapa.lims")
	public @ResponseBody List<QCostMVo> getCapa(@RequestBody List<QCostMVo> list,HttpServletRequest request){
		return qCostMService.getCapa(list);
	}
	
	
}
