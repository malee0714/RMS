package lims.wrk.controller;

import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lims.wrk.service.TrendStdrMService;
import lims.wrk.vo.TrendSpcExprVO;
import lims.wrk.vo.TrendSpcRuleVO;
import lims.wrk.vo.TrendStdrMVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


@Controller
@RequestMapping(value="/wrk")
public class TrendStdrMController {
	
	private final TrendStdrMService service;

	@Autowired
	public TrendStdrMController( @Qualifier("trendStdrMServiceImpl") TrendStdrMService service) {
		this.service = service;
	}
	
	@SetLocale
	@RequestMapping(value= "TrendStdrM.lims")
	public String TrendStdrM(HttpServletRequest request, Model model) {
		return "wrk/TrendStdrM";
	}
	
	/**
	 * spc 기준관리 목록 조회
	 */
	@RequestMapping("getSpcManageList")
	public @ResponseBody List<TrendStdrMVO> getSpcManageList( @RequestBody TrendStdrMVO vo ) {
		return service.getSpcManageList(vo);
	}
	
	/**
	 * spc기준별 spc rule 조회
	 */
	@RequestMapping("getSpcRules")
	public @ResponseBody List<TrendSpcRuleVO> getSpcRules( @RequestBody TrendStdrMVO vo ) {
		return service.getSpcRules(vo);
	}
	
	/**
	 * spc기준별 시험항목 조회
	 */
	@RequestMapping("getExprIemsOfSpcGroup")
	public @ResponseBody List<TrendSpcExprVO> getExprIemsOfSpcGroup(@RequestBody TrendStdrMVO vo ) {
		return service.getExprIemsOfSpcGroup(vo);
	}
	
	/**
	 * spc 기준 저장
	 */
	@RequestMapping("saveSpcManage")
	public @ResponseBody void saveSpcManage( @RequestBody List<TrendStdrMVO> list) {
		try {
			service.saveSpcManage(list);
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, "기준 그룹 저장이 정상적으로 완료되지 않았습니다.");
		}
	}

	/**
	 * spc 기준 삭제
	 */
	@RequestMapping("delSpcManage")
	public @ResponseBody void delSpcManage( @RequestBody List<TrendStdrMVO> list) {
		try {
			service.delSpcManage(list);
		} catch (Exception e) {
			throw new CustomException(e, "기준 그룹 삭제가 정상적으로 완료되지 않았습니다.");
		}
	}
	/**
	 * spc 기준 시험항목 삭제
	 */
	@RequestMapping("delSpcGroup")
	public @ResponseBody void delSpcGroup( @RequestBody List<TrendStdrMVO> list) {
		try {
			service.delSpcGroup(list);
		} catch (Exception e) {
			throw new CustomException(e, "기준 그룹 삭제가 정상적으로 완료되지 않았습니다.");
		}
	}

}
