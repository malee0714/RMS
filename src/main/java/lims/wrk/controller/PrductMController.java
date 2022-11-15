package lims.wrk.controller;

import lims.util.CommonFunc;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lims.wrk.service.PrductMService;
import lims.wrk.vo.PrductMVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/wrk")
public class PrductMController {
	
	
	@Resource(name = "prductMServiceImpl")
	private PrductMService prductMServiceImpl;
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	
	@SetLocale
	@RequestMapping(value = "PrductM.lims" )
	public String productM(HttpServletRequest request, Model model) {		
		return "wrk/PrductM";
	}
	
	/**
	 * 
	 * @param vo
	 * @return 부서 목록 뱉어냄
	 */
	
	@RequestMapping(value = "getDeptList.lims" )
	public @ResponseBody List<PrductMVo> getDeptList(@RequestBody PrductMVo vo) {
		return prductMServiceImpl.getDeptList(vo);
	}
	
	/**
	 * 
	 * @param vo
	 * @return 자재 목록
	 */
	
	@RequestMapping(value = "getMtrilList.lims" )
	public @ResponseBody List<PrductMVo> getMtrilList(@RequestBody PrductMVo vo) {
		return prductMServiceImpl.getMtrilList(vo);
	}

	/**
	 *
	 * @param vo
	 * @return 자재 관리 새로 저장
	 */

	@RequestMapping(value = "insMtrilNewSave.lims" )
	public @ResponseBody int insMtrilNewSave(@RequestBody PrductMVo vo) {
		try {
			return prductMServiceImpl.insMtrilNewSave(vo);
		}catch(Exception e) {
			log.error(e.getMessage(), e);
			throw new CustomException(e, vo, "자재 목록이 정상적으로 저장 되지 않았습니다.");
		}

	}

	/**
	 * 
	 * @param vo
	 * @return 자재 기존 데이터 저장
	 */
	
	@RequestMapping(value = "putMtrilSave.lims" )
	public @ResponseBody int putMtrilSave(@RequestBody PrductMVo vo) {
		try {
			return prductMServiceImpl.putMtrilSave(vo);
		}catch(Exception e) {
			log.error(e.getMessage(), e);
			throw new CustomException(e, vo, "자재 목록이 정상적으로 저장 되지 않았습니다.");
		}
	}
	
	/**
	 * 
	 * @param vo
	 * @return 자재 삭제
	 */
	
	@RequestMapping(value = "delMtril.lims" )
	public @ResponseBody int delMtril(@RequestBody PrductMVo vo) {
		try {
			return prductMServiceImpl.delMtril(vo);
		}catch(Exception e) {
			log.error(e.getMessage(), e);
			throw new CustomException(e, vo, "자재 목록이 정상적으로 삭제 되지 않았습니다.");
		}
	
	}
	
	/**
	 * 
	 * @param vo
	 * @return 자재 시험 항목 리스트
	 */
	
	@RequestMapping(value = "getMtrilExpriemList.lims" )
	public @ResponseBody List<PrductMVo> getMtrilExpriemList(@RequestBody PrductMVo vo) {
		return prductMServiceImpl.getMtrilExpriemList(vo);
	}
	
	/**
	 * 
	 * @return 마스터 단위 리스트
	 */

	@RequestMapping(value = "getMasterUnitList.lims" )
	public @ResponseBody List<PrductMVo> getMasterUnitList(@RequestBody  PrductMVo vo) {
		return prductMServiceImpl.getMasterUnitList(vo);
	}



	@RequestMapping(value = "getcylndrList.lims" )
	public @ResponseBody List<PrductMVo> getcylndrList(@RequestBody PrductMVo vo) {
		return prductMServiceImpl.getcylndrList(vo);
	}
	@RequestMapping(value = "getitemNoList.lims" )
	public @ResponseBody List<PrductMVo> getitemNoList(@RequestBody PrductMVo vo) {
		return prductMServiceImpl.getitemNoList(vo);
	}

	
	/**
	 * 
	 * @param list
	 * @return 일괄추가 
	 */
	@RequestMapping(value = "insMtrilExpriemAll.lims" )
	public @ResponseBody int insMtrilExpriemAll(@RequestBody PrductMVo vo) {
		try {
			return prductMServiceImpl.insMtrilExpriemAll(vo);
		}catch(Exception e) {
			log.error(e.getMessage(), e);
			throw new CustomException(e, vo, "시험항목 목록이 정상적으로 저장 되지 않았습니다.");
		}
	}


	/**
	 *
	 * @param list
	 * @return 일괄추가
	 */

	@RequestMapping(value = "deletCylinder.lims" )
	public @ResponseBody int deletCylinder(@RequestBody PrductMVo vo) {
		try {
			return prductMServiceImpl.deletCylinder(vo);
		}catch(Exception e) {
			log.error(e.getMessage(), e);
			throw new CustomException(e, vo, "시험항목 목록이 정상적으로 저장 되지 않았습니다.");
		}
	}
	/**
	 *
	 * @param list
	 * @return 일괄추가
	 */

	@RequestMapping(value = "deletItemNo.lims" )
	public @ResponseBody int deletItemNo(@RequestBody PrductMVo vo) {
		try {
			return prductMServiceImpl.deletItemNo(vo);
		}catch(Exception e) {
			log.error(e.getMessage(), e);
			throw new CustomException(e, vo, "시험항목 목록이 정상적으로 저장 되지 않았습니다.");
		}
	}

	@RequestMapping(value = "deletExpriem.lims" )
	public @ResponseBody int deletExpriem(@RequestBody PrductMVo vo) {
		try {
			return prductMServiceImpl.deletExpriem(vo);
		}catch(Exception e) {
			log.error(e.getMessage(), e);
			throw new CustomException(e, vo, "시험항목 목록이 정상적으로 저장 되지 않았습니다.");
		}
	}



}
