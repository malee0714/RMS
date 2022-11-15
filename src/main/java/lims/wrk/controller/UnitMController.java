package lims.wrk.controller;

import lims.com.vo.ComboVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lims.wrk.service.UnitMService;
import lims.wrk.vo.EntrpsMDto;
import lims.wrk.vo.UnitMVo;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/wrk")
public class UnitMController {
	
	
	@Resource(name = "unitMServiceImpl")
	
	private UnitMService unitMService;
	
	
	/**
	 * 
	 * @param request
	 * @param model
	 * @return 페이지 이동
	 */
	@SetLocale()
	@RequestMapping(value = "UnitM.lims" )
	public String UnitM(HttpServletRequest request, Model model) {		
		return "wrk/UnitM";
		
	}
	
	//조회
	@RequestMapping("/getUnitList")
	public @ResponseBody List<UnitMVo> getUnitList(@RequestBody UnitMVo vo, HttpServletRequest request){		
		return unitMService.getUnitList(vo);
	}

	//조회
	@RequestMapping("/getUnitcomdo")
	public @ResponseBody List<ComboVo> getUnitcomdo(@RequestBody UnitMVo vo, HttpServletRequest request){
		return unitMService.getUnitcomdo(vo);
	}

	//저장
	@RequestMapping("/saveUnit.lims")
	public @ResponseBody int saveUnit(@RequestBody HashMap<String, Object> map, Model model, HttpServletRequest request){
		try {
			//map objcet를 JSONObject에 담을 변수 
			JSONObject jsonObject = null;
			
			// jsp에서 받아온 added map을 담당그룹ListVO에 담는다
			List<Object> detailObj = (List<Object>) map.get("addedRowItems");
			List<UnitMVo> addedUnitMVO = new ArrayList<>();
			int i = 0;
			
			for(Object lstObj : detailObj )
			{
				jsonObject = JSONObject.fromObject(lstObj);
				addedUnitMVO.add(i, (UnitMVo) JSONObject.toBean(jsonObject, lims.wrk.vo.UnitMVo.class)); 
				i++;
			}
			
			// jsp에서 받아온 edit map을 담당그룹ListVO에 담는다
			List<Object> detailObj1 = (List<Object>) map.get("editedRowItems");
			List<UnitMVo> editedUnitMVO = new ArrayList<>();
			i = 0;
			
			for(Object lstObj : detailObj1 )
			{
				jsonObject = JSONObject.fromObject(lstObj);
				editedUnitMVO.add(i, (UnitMVo) JSONObject.toBean(jsonObject, lims.wrk.vo.UnitMVo.class)); 
				i++;
			}
			
			// jsp에서 받아온 edit map을 담당그룹ListVO에 담는다
			List<Object> detailObj2 = (List<Object>) map.get("removedRowItems");
			List<UnitMVo> removedUnitMVO = new ArrayList<>();
			i = 0;
			
			for(Object lstObj : detailObj2 )
			{
				jsonObject = JSONObject.fromObject(lstObj);
				removedUnitMVO.add(i, (UnitMVo) JSONObject.toBean(jsonObject, lims.wrk.vo.UnitMVo.class)); 
				i++;
			}

			return unitMService.saveUnit(addedUnitMVO, editedUnitMVO, removedUnitMVO);
		}catch (Exception e) {
			log.error(e.getMessage(),e);
			throw new CustomException(e, map, "단위관리 정보가 정상적으로 저장되지 않았습니다.");
		}
		
	}
	
	// 단위명 확인.
	
	@RequestMapping("unitNmValidation.lims")
	@ResponseBody
	public int unitNmValidation(@RequestBody UnitMVo vo){
		return unitMService.unitNmValidation(vo);
	}
	
	
}
