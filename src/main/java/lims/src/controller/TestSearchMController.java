package lims.src.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import lims.util.GetUserSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.com.vo.FileDetailMVo;
import lims.com.vo.RdmsMVo;
import lims.req.vo.RequestMVo;
import lims.src.service.TestSearchMService;
import lims.src.vo.TestSearchMVo;
import lims.test.vo.ResultInputMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping("/src")
public class TestSearchMController {

	@Resource(name="testSearchMServiceImpl")
	private TestSearchMService testSearchMService;

	@SetLocale()
	@RequestMapping(value="TestSearchM.lims")
	public String TestSearchM(TestSearchMVo vo, Model model){
		return "src/TestSearchM";
	}

	//의뢰 목록 조회
	@RequestMapping(value="getReqestList.lims")
	public @ResponseBody List<ResultInputMVo> getReqestList(@RequestBody ResultInputMVo vo){
		GetUserSession session = new GetUserSession();
		vo.setAuthorSeCode(session.getAuthorSeCode());
		return testSearchMService.getReqestListSch(vo);
	}

	//시험항목 목록 조회
	@RequestMapping(value="getExpriemListSch.lims")
	public @ResponseBody List<ResultInputMVo> getExpriemListSch(@RequestBody ResultInputMVo vo){
		return testSearchMService.getExpriemListSch(vo);
	}

	/**
	 *
	 * @param vo
	 * @return 접수에 물린 상위 로트 리스트
	 */
	@RequestMapping(value = "getReqestUpperLotList.lims" )
	public @ResponseBody List<RequestMVo> getReqestUpperLotList(@RequestBody RequestMVo vo) {
		return testSearchMService.getReqestUpperLotList(vo);
	}

	/**
	 *
	 * @param vo
	 * @return 접수에 물린 분석 초중말 리스트
	 */
	@RequestMapping(value = "getReqestChrgTeamList.lims" )
	public @ResponseBody List<RequestMVo> getReqestChrgTeamList(@RequestBody RequestMVo vo) {
		return testSearchMService.getReqestChrgTeamList(vo);
	}

	/**
	 *
	 * @param vo
	 * @return 접수에 물린 Can.no 리스트
	 */
	@RequestMapping(value = "getReqestCanNoList.lims" )
	public @ResponseBody List<RequestMVo> getReqestCanNoList(@RequestBody RequestMVo vo) {
		return testSearchMService.getReqestCanNoList(vo);
	}

	/**
	 *
	 * @param vo
	 * @return 상위 lot id 콤보 리스트
	 */
	@RequestMapping(value = "getUpperLotId.lims" )
	public @ResponseBody List<RequestMVo> getUpperLotId(@RequestBody RequestMVo vo) {
		return testSearchMService.getUpperLotId(vo);
	}

	/**
	 *
	 * @param List<vo>
	 * @return PDF Viewer Data
	 */
	@RequestMapping(value = "getblobPdfViewer.lims" )
	public @ResponseBody FileDetailMVo getblobPdfViewer(@RequestBody RdmsMVo vo) {
		return testSearchMService.getblobPdfViewer(vo);
	}

	/**
	 *
	 * @param List<vo>
	 * @return PDF Viewer Data List
	 */
	@RequestMapping(value = "getCheckBlobPdfViewer.lims" )
	public @ResponseBody FileDetailMVo getCheckBlobPdfViewer(@RequestBody List<RdmsMVo> list) {
		return testSearchMService.getCheckBlobPdfViewer(list);
	}

	/**
	 *
	 * @param List<vo>
	 * @return 병합문서보기 팝업
	 */
	@SetLocale()
	@RequestMapping(value = "PdfViewerPopupM.lims")
	public String pdfViewerPopupM(Model model, HttpServletRequest request) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		Enumeration<String> paramNames = request.getParameterNames();

		while(paramNames.hasMoreElements()) {
			String name	= paramNames.nextElement().toString();
			String value = request.getParameter(name);
			paramMap.put(name, value);
		}

		model.addAttribute("param", paramMap);

		return "src/PdfViewerPopupM";
	}
}
