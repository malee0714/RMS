package lims.test.controller;

import lims.test.service.RoaMService;
import lims.test.vo.RoaMVo;
import lims.util.Locale.SetLocale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
//import lims.test.vo.RoaMVo;

@Controller
@RequestMapping("/test")
public class RoaMController {
	private final RoaMService roaMService;

	@Autowired
	public RoaMController(RoaMService roaMServiceImpl) {
		this.roaMService = roaMServiceImpl;
	}

	@SetLocale
	@RequestMapping(value = "/ResultOfAnalysisM.lims")
	public String RoaM(Model model) {
		return "test/RoaM";
	}

	@RequestMapping(value = "getReqList.lims")
	public @ResponseBody List<RoaMVo> getReqList(@RequestBody RoaMVo vo) {
		return this.roaMService.getReqList(vo);
	}

	@RequestMapping(value = "/roaList.lims")
	public @ResponseBody List<RoaMVo> roaList(@RequestBody RoaMVo vo) {
		return this.roaMService.roaList(vo);
	}

	/**
	 * 
	 * @param
	 * @return 그리드의 결과입력자 목록 가져오는거
	 */
	@RequestMapping(value = "/resultRegisterUserList.lims")
	public @ResponseBody List<RoaMVo> resultRegisterUserList() {
		return this.roaMService.resultRegisterUserList();
	}

	/**
	 * 
	 * @param
	 * @return roa 데이터 결과수정함. 입력자랑 입력일 수정가능.
	 */
	@RequestMapping(value = "/updRoaData.lims")
	public @ResponseBody
	ResponseEntity<Void> updRoaData(@RequestBody List<RoaMVo> vo, HttpServletRequest req,
							  HttpServletResponse res) {
		try {
			HttpServletResponse response = (HttpServletResponse) res;
			// 브라우저 리소스에 접근하는 임의의 요청을 허용한다.
			// *는 모든 url에서의 요청을 허용한다는것 같아요. (특정 url만 허용하기위해서는 *대신 url작성 ex)www.naver.com)
			response.setHeader("Access-Control-Allow-Origin", "*");
			// 요청 허용 메소드 정의
			response.setHeader("Access-Control-Allow-Methods", "POST, GET, DELETE, PUT");
			// 요청 결과를 캐시 할 수 있는 시간 설정
			response.setHeader("Access-Control-Max-Age", "3600");
			// 요청 허용할 헤더
			response.setHeader("Access-Control-Allow-Headers", "x-requested-with, origin, content-type, accept");
			HttpServletRequest request = (HttpServletRequest) req;
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.setProperty("sun.net.http.allowRestrictedHeaders", "true");

		return new ResponseEntity<Void>(this.roaMService.updRoaData(vo), HttpStatus.OK);
	}

	/**
	 * 
	 * @return 고객사 목록을 가져옴.
	 */
	@RequestMapping(value = "/getEntrpsList.lims")
	public @ResponseBody List<RoaMVo> getEntrpsList(@RequestBody RoaMVo vo) {
		return this.roaMService.getEntrpsList(vo);
	}

	/**
	 * 
	 * @param vo
	 * @return 해당의뢰에 엮인 상위라뜨 리스트
	 */
	@RequestMapping(value = "/getUpperLotList.lims")
	public @ResponseBody List<RoaMVo> getUpperLotList(@RequestBody RoaMVo vo) {
		return this.roaMService.getUpperLotList(vo);
	}

	/**
	 * 
	 * @param vo
	 * @return ROA를 생성한다.
	 */
	@RequestMapping(value = "/resultOfAnalysisGenerator_aka_genRoa.lims")
	public @ResponseBody Map<String, Object> resultOfAnalysisGenerator_aka_genRoa(@RequestBody RoaMVo vo) {
		return this.roaMService.resultOfAnalysisGenerator_aka_genRoa(vo);
	}

	/**
	 * 
	 * @param vo
	 * @return 시험항목 코드를 보내면 lotId와 lcl,ucl, 평균 result값을 가지고 찰트를 만듭니다
	 */
	@RequestMapping(value = "/getLotChartList.lims")
	public @ResponseBody List<RoaMVo> getLotChartList(@RequestBody RoaMVo vo) {
		return this.roaMService.getLotChartList(vo);
	}

	/**
	 * 
	 * @param vo
	 * @return 알디엠에스 날짜목록
	 */
	@RequestMapping(value = "/getRdmsDateList.lims")
	public @ResponseBody List<RoaMVo> getRdmsDateList(@RequestBody RoaMVo vo) {
		return this.roaMService.getRdmsDateList(vo);
	}

	/**
	 * 
	 * @param vo
	 * @return rdms date 변경함
	 */
	@RequestMapping(value = "/updRdmsDate.lims")
	public @ResponseBody HashMap<String, Object> updRdmsDate(@RequestBody List<RoaMVo> vo) {
		return this.roaMService.updRdmsDate(vo);
	}

	/**
	 * 
	 * @param vo
	 * @return ROA 기준규격 동기화 기능입니다
	 */
	@RequestMapping(value = "/setChangeNowData.lims")
	public @ResponseBody HashMap<String, Object> setChangeNowData(@RequestBody RoaMVo vo) {
		return this.roaMService.setChangeNowData(vo);
	}

	/**
	 * 
	 * @param vo
	 * @return 의뢰 그리드 클릭시 최초 실험날짜 가져옴
	 */
	@RequestMapping(value = "/getRealAnalsData.lims")
	public @ResponseBody Map<String, Object> getRealAnalsData(@RequestBody RoaMVo vo) {
		return this.roaMService.getRealAnalsData(vo);
	}

	/**
	 * 
	 * @param vo
	 * @return roa 이력 몰록
	 */
	@RequestMapping(value = "/getRoaEditHistList.lims")
	public @ResponseBody List<RoaMVo> getRoaEditHistList(@RequestBody RoaMVo vo) {
		return this.roaMService.getRoaEditHistList(vo);
	}

	/**
	 * 
	 * @param vo
	 * @return 분석중으로 돌려줌
	 */
	@RequestMapping(value = "/setRoaRollback.lims")
	public @ResponseBody void setRoaRollback(@RequestBody List<RoaMVo> vo) {
		this.roaMService.setRoaRollback(vo);
	}

	@RequestMapping(value = "/genRoa.lims")
	public @ResponseBody void genRoa(@RequestBody RoaMVo vo) {
		this.roaMService.genRoa(vo);
	}

}
