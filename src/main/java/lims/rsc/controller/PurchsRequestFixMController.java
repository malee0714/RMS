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

import lims.rsc.service.PurchsRequestFixMService;
import lims.rsc.vo.PurchsRequestFixMVo;
import lims.rsc.vo.PurchsRequestMVo;
import net.sf.json.JSONObject;


@Controller
@RequestMapping(value="/reg")
public class PurchsRequestFixMController {
	
	
	@Resource(name = "purchsRequestFixMServiceImpl")
	private PurchsRequestFixMService purchsRequestFixMService;
	
	@RequestMapping(value = "PurchsRequestFixM.lims")
	public String purchsRequestFixM(Model model, HttpServletRequest request) {
		
		return "rsc/PurchsRequestFixM";
	}
	
	// 구매요청확정 그리드 리스트 조회
	@RequestMapping(value = "getPurchsRequestFixMList.lims" )
	public @ResponseBody List<PurchsRequestFixMVo> getPurchsRequestFixMList(@RequestBody PurchsRequestFixMVo vo, Model model) {
		List<PurchsRequestFixMVo> result = purchsRequestFixMService.getPurchsRequestFixMList(vo);
		return result;
	}

	// 구매요청 목록 그리드 리스트 조회
	@RequestMapping(value = "getRequstIsestatnFixMList.lims" )
	public @ResponseBody List<PurchsRequestMVo> getRequstIsestatnFixMList(@RequestBody PurchsRequestMVo vo, Model model) {
		List<PurchsRequestMVo> result = purchsRequestFixMService.getRequstIsestatnFixMList(vo);
		
		return result;
	}
	
	// 구매목록 그리드 리스트 조회
	@RequestMapping(value = "getPurchsIsestatnFixMList.lims" )
	public @ResponseBody List<PurchsRequestMVo> getPurchsIsestatnFixMList(@RequestBody PurchsRequestMVo vo, Model model) {
		List<PurchsRequestMVo> result = purchsRequestFixMService.getPurchsIsestatnFixMList(vo);
		
		return result;
	}
	
	// 구매 요청 확정 정보, 구매목록 저장
	@RequestMapping(value = "savePurchsRequestFixM.lims" )
	public @ResponseBody int savePurchsRequestFixM(@RequestBody HashMap<String, Object> map, Model model, HttpServletRequest request) {
		// map objcet를 JSONObject에 담을 변수 
		JSONObject jsonObject = null;
		// VO
		PurchsRequestFixMVo masterVO = new PurchsRequestFixMVo();
		
		// jsp에서 받아온 master map을 VO에 담는다
		Object masterObj = map.get("master");
		jsonObject = JSONObject.fromObject(masterObj);
		masterVO = (PurchsRequestFixMVo) JSONObject.toBean (jsonObject, lims.rsc.vo.PurchsRequestFixMVo.class);
		

		// jsp에서 받아온 detail map을 ListVO에 담는다
		List<Object> detailObj = (List<Object>) map.get("detail");
		List<PurchsRequestFixMVo> detailVO = new ArrayList<>();
		int i = 0;
		
		for(Object lstObj : detailObj){
			jsonObject = JSONObject.fromObject(lstObj); 
			detailVO.add(i, (PurchsRequestFixMVo) JSONObject.toBean(jsonObject, lims.rsc.vo.PurchsRequestFixMVo.class));
			i++;
		}
		
		// jsp에서 받아온 productDetail map을 ListVO에 담는다
		List<Object> productObj = (List<Object>) map.get("productDetail");
		List<PurchsRequestFixMVo> productVO = new ArrayList<>();
		int j = 0;
		
		for(Object prtObj : productObj){
			jsonObject = JSONObject.fromObject(prtObj);
			productVO.add(j, (PurchsRequestFixMVo) JSONObject.toBean(jsonObject, lims.rsc.vo.PurchsRequestFixMVo.class));
			j++;
		}
		
		return purchsRequestFixMService.savePurchsRequestFixM(masterVO, detailVO, productVO);
	}
	
	// 구매요청 삭제
	@RequestMapping(value = "delRequestFixM.lims" )
	public @ResponseBody int delRequestFixM(@RequestBody HashMap<String, Object> map, Model model, HttpServletRequest request){
		// map objcet를 JSONObject에 담을 변수 
		JSONObject jsonObject = null;
		// VO
		PurchsRequestFixMVo masterVO = new PurchsRequestFixMVo();
		
		// jsp에서 받아온 master map을 VO에 담는다
		Object masterObj = map.get("master");
		jsonObject = JSONObject.fromObject(masterObj);
		masterVO = (PurchsRequestFixMVo) JSONObject.toBean(jsonObject, lims.rsc.vo.PurchsRequestFixMVo.class);
		
		// VO
		PurchsRequestFixMVo detailVO = new PurchsRequestFixMVo();
		
		// jsp에서 받아온 detail map을 VO에 담는다
		Object detailObj = map.get("detail");
		jsonObject = JSONObject.fromObject(detailObj);
		detailVO = (PurchsRequestFixMVo) JSONObject.toBean(jsonObject, lims.rsc.vo.PurchsRequestFixMVo.class);
		
		return purchsRequestFixMService.delRequestFixM(masterVO, detailVO);
	}
	
	
	
	
	
	
	
	
	
}
