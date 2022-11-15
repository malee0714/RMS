package lims.req.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.req.service.PartnersCoaMService;
import lims.req.vo.PartnersCoaMVo;
import lims.src.controller.QCostMController;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/req")
public class PartnersCoaMController {
	
	@Resource(name = "PartnersCoaMService")
	private PartnersCoaMService partnersCoaMService;
	
	/**
	 * 협력사 COA
	 * @return
	 */
	@SetLocale()
	@RequestMapping(value = "/PartnersCoaM.lims")
	public String PartnersCoaM(Model model,HttpServletRequest request){
		return "req/PartnersCoaM";
	}
	
	/**
	 * 협력업체 의뢰목록 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getPartnersCoaList.lims")
	public @ResponseBody List<PartnersCoaMVo> getPartnersCoaList(@RequestBody PartnersCoaMVo vo){
		
		
		try {
			return partnersCoaMService.getPartnersCoaList(vo);
		}catch(Exception e) {
			throw new CustomException(e, vo, "협력업체 의뢰목록이 정상적으로 조회되지 않았습니다.");
		}
		
	}
	
	/**
	 * 시험항목 정보 조회
	 */
	@RequestMapping(value = "/getImReqestExpriem.lims")
	public @ResponseBody List<PartnersCoaMVo> getImReqestExpriem(@RequestBody PartnersCoaMVo vo){
		return partnersCoaMService.getImReqestExpriem(vo);
	}
	/**
	 * 시험항목 내용 조회
	 */
	@RequestMapping(value = "/getExpriemCoaList.lims")
	public @ResponseBody List<PartnersCoaMVo> getExpriemCoaList(@RequestBody PartnersCoaMVo vo){
		return partnersCoaMService.getExpriemCoaList(vo);
	}
	
	/**
	 * 저장
	 * @return
	 */
	@RequestMapping(value = "/insPartnersCoaM.lims")
	public @ResponseBody int insPartnersCoaM(@RequestBody PartnersCoaMVo vo){		
		try{
			return partnersCoaMService.insPartnersCoaM(vo);
			}catch (Exception e){
				throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
			}
	}
	
	/**
	 * 수정
	 */
	@RequestMapping(value = "/updPartnersCoaM.lims")
	public @ResponseBody int updPartnersCoaM(@RequestBody PartnersCoaMVo vo){
		try{
			return partnersCoaMService.updPartnersCoaM(vo);
			}catch (Exception e){
				throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
			}
	}
	
	/**
	 * 의뢰정보 삭제
	 */
	@RequestMapping(value = "/delPartnersCoaM.lims")
	public @ResponseBody int delPartnersCoaM(@RequestBody PartnersCoaMVo vo){
		try{
			return partnersCoaMService.delPartnersCoaM(vo);
			}catch (Exception e){
				throw new CustomException(e,vo,"저장이 정상적으로 처리되지 않았습니다");
			}

	}
							
	@RequestMapping(value = "/getPartnersMtrilCode.lims")
	public @ResponseBody String getPartnersMtrilCode(@RequestBody PartnersCoaMVo vo){
		return partnersCoaMService.getMtrilCode(vo);
	}
	
	@RequestMapping(value = "/getExpriem.lims")
	public @ResponseBody List<PartnersCoaMVo> getExpriem(@RequestBody PartnersCoaMVo vo){
		return partnersCoaMService.getExpriem(vo);
	}
	@RequestMapping(value = "/getVenderLotNo.lims")
	public @ResponseBody int getVenderLotNo(@RequestBody PartnersCoaMVo vo){
		return partnersCoaMService.getVenderLotNo(vo);
	}
	
}
