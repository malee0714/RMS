package lims.rsc.controller;

import lims.rsc.service.PurchsRequestMService;
import lims.rsc.vo.PurchsRequestMVo;
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


@Controller
@RequestMapping(value="/reg")
public class PurchsRequestMController {
	
	
	@Resource(name = "purchsRequestMServiceImpl")
	private PurchsRequestMService purchsRequestMService;
	
	@RequestMapping(value = "PurchsRequestM.lims")
	public String productM(Model model, HttpServletRequest request) {
		
		return "rsc/PurchsRequestM";
	}
	
	// 구매요청 그리드 리스트 조회
	@RequestMapping(value = "getPurchsRequestMList.lims" )
	public @ResponseBody List<PurchsRequestMVo> getPurchsRequestMList(@RequestBody PurchsRequestMVo vo, Model model) {
		List<PurchsRequestMVo> result = purchsRequestMService.getPurchsRequestMList(vo);
		
		return result;
	}
	
	// 구매요청 그리드 저장
	@RequestMapping(value = "savePurchsRequestM.lims" )
	public @ResponseBody int savePurchsRequestM(@RequestBody HashMap<String, Object> map, Model model, HttpServletRequest request) {
		// map objcet를 JSONObject에 담을 변수 
		JSONObject jsonObject = null;
		// VO
		PurchsRequestMVo masterVO = new PurchsRequestMVo();
		
		// jsp에서 받아온 master map을 VO에 담는다
		Object masterObj = map.get("master");
		jsonObject = JSONObject.fromObject(masterObj);
		masterVO = (PurchsRequestMVo) JSONObject.toBean(jsonObject, lims.rsc.vo.PurchsRequestMVo.class);
		
		// jsp에서 받아온 detail map을 ListVO에 담는다
		List<Object> detailObj = (List<Object>) map.get("detail");
		List<PurchsRequestMVo> detailVO = new ArrayList<>();
		
		int i = 0;
		
		/* ## JSONObject 주의사항 ## 
		 * JSONObject 라이브러리함수는 널값을 허용하지 않는다
		 * JSONObject를 채워주는 위치에서 널값과 관련된 에러가 날 경우 
		 * JSP 페이지에서 초기진입할때와 클리어 함수에 AUIGrid.clearGridData( 그리드 ID ); 를 해주면 된다.
		 * (혹은 java단에서 throws를 사용하면 된다.) 
		 */
		for(Object lstObj : detailObj){
			jsonObject = JSONObject.fromObject(lstObj); 
			detailVO.add(i, (PurchsRequestMVo) JSONObject.toBean(jsonObject, lims.rsc.vo.PurchsRequestMVo.class));
			i++;
		}
		
		List<Object> productObj = (List<Object>) map.get("productDetail");
		List<PurchsRequestMVo> productVO = new ArrayList<>();
		int j = 0;
		
		for(Object prtObj : productObj){
			jsonObject = JSONObject.fromObject(prtObj);
			productVO.add(j, (PurchsRequestMVo) JSONObject.toBean(jsonObject, lims.rsc.vo.PurchsRequestMVo.class));
			j++;
		}
		
		return purchsRequestMService.savePurchsRequestM(masterVO, detailVO, productVO);
	}
	
	// 구매요청 삭제
	@RequestMapping(value = "delPurchsRequestM.lims" )
	public @ResponseBody int delPurchsRequestM(@RequestBody HashMap<String, Object> map, Model model, HttpServletRequest request){
		// map objcet를 JSONObject에 담을 변수 
		JSONObject jsonObject = null;
		// VO
		PurchsRequestMVo masterVO = new PurchsRequestMVo();
		
		// jsp에서 받아온 master map을 VO에 담는다
		Object masterObj = map.get("master");
		jsonObject = JSONObject.fromObject(masterObj);
		masterVO = (PurchsRequestMVo) JSONObject.toBean(jsonObject, lims.rsc.vo.PurchsRequestMVo.class);
		
		// VO
		PurchsRequestMVo detailVO = new PurchsRequestMVo();
		
		// jsp에서 받아온 detail map을 VO에 담는다
		Object detailObj = map.get("detail");
		jsonObject = JSONObject.fromObject(detailObj);
		detailVO = (PurchsRequestMVo) JSONObject.toBean(jsonObject, lims.rsc.vo.PurchsRequestMVo.class);
		
		return purchsRequestMService.delPurchsRequestM(masterVO, detailVO);
	}
	
	// 구매요청 목록 삭제
	/*@RequestMapping(value = "delPurchsRequestMDetail.lims" )
	public @ResponseBody int delPurchsRequestMDetail(@RequestBody List<PurchsRequestMVo> vo){
		return purchsRequestMService.delPurchsRequestMDetail(vo);
	}*/
	
	// 구매요청 목록 조회
	@RequestMapping(value = "getRequstIsestatnMList.lims" )
	public @ResponseBody List<PurchsRequestMVo> getRequstIsestatnMList(@RequestBody PurchsRequestMVo vo, Model model) {
		List<PurchsRequestMVo> result = purchsRequestMService.getRequstIsestatnMList(vo);
		
		return result;
	}
	
	// 구매요청 목록 저장
	/*@RequestMapping(value = "saveRequstIsestatnMList.lims" )
	public @ResponseBody int saveRequstIsestatnMList(@RequestBody List<PurchsRequestMVo> vo){
		return purchsRequestMService.saveRequstIsestatnMList(vo);
	}*/

	// 시약 진행상황 바인딩
	@RequestMapping(value = "getComboRgntProgrsSittnCodeList.lims" )
	public @ResponseBody List<PurchsRequestMVo> getComboRgntProgrsSittnCodeList(@RequestBody PurchsRequestMVo vo, Model model) {
		List<PurchsRequestMVo> result = purchsRequestMService.getComboRgntProgrsSittnCodeList(vo);
		
		return result;
	}
	

}
