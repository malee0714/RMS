package lims.com.controller;

import lims.com.service.CommonService;
import lims.com.service.LoginMService;
import lims.com.vo.*;
import lims.dly.vo.DlivyMVo;
import lims.qa.vo.DocDto;
import lims.qa.vo.QlityDocHistVo;
import lims.req.vo.ReceiptManageDto;
import lims.rsc.vo.*;
import lims.src.vo.ImpartclLogMVo;
import lims.sys.vo.CmmnCodeMVo;
import lims.sys.vo.InsttMVo;
import lims.sys.vo.UserMVo;
import lims.test.vo.ResultInputMVo;
import lims.util.ExcelExport;
import lims.util.Img2Excel;
import lims.util.Locale.SetLocale;
import lims.util.Util;
import lims.wrk.vo.*;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.*;

@Controller
@RequestMapping("/com")
public class CommonController {

	private final CommonService commonService;

	private final LoginMService loginMService;

	@Autowired
	public CommonController(CommonService commonServiceImpl, LoginMService loginMServiceImpl) {
		this.commonService = commonServiceImpl;
		this.loginMService = loginMServiceImpl;
	}

	//SELECT BOX (HTML)
	//공통 코드
	@RequestMapping(value = "/getCmmnCode.lims" )
	public @ResponseBody List<ComboVo> getCmmnCode(@RequestBody CmmnCodeMVo param) {
		return commonService.getCmmnCode(param);
	}

	//부서기준 사용자 조회
	@RequestMapping(value = "/getDeptToUserLsit.lims" )
	public @ResponseBody List<InsttMVo> getDeptToUserLsit(@RequestBody InsttMVo param) {
		return commonService.getDeptToUserLsit(param);
	}

	@RequestMapping(value = "/getUserNmCombo.lims" )
	@ResponseBody
	public List<InsttMVo> getUserNmCombo(@RequestBody InsttMVo vo) {
		return commonService.getUserNmCombo(vo);
	}

	@RequestMapping(value = "/getSession.lims" )
	public @ResponseBody UserMVo getSession(HttpServletRequest request) {
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		return UserMVo;
	}

	@RequestMapping(value = "/getAuth.lims" )
	public @ResponseBody UserMVo getAuth() {
		return commonService.getAuth();
	}

	@RequestMapping(value = "/getUser.lims" )
	public @ResponseBody UserMVo getUser(@RequestBody UserMVo vo) {
		return loginMService.getUser(vo);
	}

	//업체 조회(팝업)
	@RequestMapping(value = "/getEntrpsFclty.lims")
	public @ResponseBody List<EntrpsMVo> getEntrpsFclty(@RequestBody EntrpsMVo vo, HttpServletRequest request){
		List<EntrpsMVo> result = commonService.getEntrpsFclty(vo);
		return result;
	}

	// RDMS 뷰어
	@RequestMapping(value = "/rdmsViewer.lims" )
	public @ResponseBody Object rdmsViewer(@RequestBody RdmsMVo vo, HttpServletRequest request, Model model) throws Exception {
		Util util = Util.getInstance();
		String uuid = UUID.randomUUID().toString();

		HashMap<String, String> map = new HashMap<String, String>();

		vo.setUuid(uuid);
		int r = commonService.rdmsViewer(vo);
		Object[] ret = new Object[2];

		ret[0] = util.getRdmsUrl();

		if (r == 0) {
			ret[1] = r;
		} else {
			ret[1] = uuid;
		}
		return ret;
	}

	// 엑셀파일 쓰기
	@RequestMapping(value="/excelWrite.lims")
	public @ResponseBody MainVo excelWrite(@RequestBody MainVo vo,  ModelMap model, HttpServletRequest req) throws Exception {


		//List<MainVo> list = mainService.getBbsList(vo);

		ExcelExport ex = new ExcelExport();
		System.out.println("ex 객체 호출");
		return  ex.excelWrite(vo.getFileName());
	}

	// 엑셀파일 쓰기
	@RequestMapping(value="/excelRead.lims")
	public @ResponseBody List<HashMap<String,Object>> excelRead(HttpServletRequest request) throws Exception {

		ExcelExport ex = new ExcelExport();
		System.out.println("엑셀 읽기");
		String fileName = request.getParameter("fileName");
		return  ex.excelRead(fileName);
	}

	// 업체 조회(시약/표준품 관리 팝업)
	@RequestMapping(value = "/getProductEntrpsFclty.lims")
	public @ResponseBody List<EntrpsMVo> getProductEntrpsFclty(@RequestBody EntrpsMVo vo, HttpServletRequest request){
		List<EntrpsMVo> result = commonService.getProductEntrpsFclty(vo);
		return result;
	}

	// 엑셀파일 다운로드
	@RequestMapping(value="/excelDownload.lims")
	public @ResponseBody void excelDownload(HttpServletRequest req, HttpServletResponse response) {
		try{
			//다운로드
			ServletOutputStream out = null;

			String fileName = req.getParameter("fileName");
			String fullPath = req.getParameter("fullPath");
			String fileType = fileName.substring(fileName.indexOf(".") + 1, fileName.length());
			if (fileType.trim().equalsIgnoreCase("xlsx")) {
				response.setContentType("application/vnd.ms-excel");
			} else {
				response.setContentType("application/octet-stream");
			}

			//String text = URLDecoder.decode(fileName, "UTF-8") ;
			String docName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
			response.setHeader("Content-Disposition", "attachment;filename=" + docName + ";");
			FileUtils utils = new FileUtils();
			File file = new File(fullPath);//다운받을 파일 경로
			byte[] fileBytes = utils.readFileToByteArray(file);//파일 크기 바이트로 변환
			if (fileBytes != null && fileBytes.length > 0) {
				out = response.getOutputStream();
				out.write(fileBytes);
				out.flush();
			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	//기기 조회 (팝업)
	@RequestMapping(value = "/getEqpmnList.lims" )
	public @ResponseBody List<EqpmnManageDto> getEqpmnList(@RequestBody EqpmnManageDto vo, HttpServletRequest request){
		UserMVo user = (UserMVo)request.getSession().getAttribute("UserMVo");
//		vo.setInspctInsttCode(user.getBestInspctInsttCode());
		return commonService.getEqpmnList(vo);
	}

	// 의뢰목록 팝업
	@RequestMapping(value = "getReqestListPop.lims")
	@ResponseBody
	public List<EqpmnInspcCrrctDto> getReqestListPop(@RequestBody EqpmnInspcCrrctDto eqpmnInspcCrrctDto) {
		return commonService.getReqestListPop(eqpmnInspcCrrctDto);
	}

	// 사용자 목록 (팝업)
	@RequestMapping(value = "/getPopUpRqesterNmList.lims" )
	public @ResponseBody List<UserMVo> getPopUpRqesterNmList(@RequestBody UserMVo vo, Model model) {
		List<UserMVo> result = commonService.getPopUpRqesterNmList(vo);

		return result;
	}

	// 사용자 목록 (콤보)
	@RequestMapping(value = "/getDeptCombo.lims" )
	public @ResponseBody List<InsttMVo> getDeptCombo(@RequestBody InsttMVo vo, Model model) {
		List<InsttMVo> result = commonService.getDeptCombo(vo);

		return result;
	}
	
	// 장비관리번호 콤보
	@RequestMapping(value = "getEqpManageNoCombo.lims")
	@ResponseBody
	public List<ComboVo> getEqpManageNoCombo(@RequestBody EqpmnGageDto eqpmnGageDto) {
		return commonService.getEqpManageNoCombo(eqpmnGageDto);
	}

	//기기 명 (콤보)
	@RequestMapping(value = "/getEqpmnNmCombo.lims" )
	public @ResponseBody List<EqpmnManageDto> getEqpmnNmCombo(@RequestBody EqpmnManageDto vo, Model model) {
		List<EqpmnManageDto> result = commonService.getEqpmnNmCombo(vo);

		return result;
	}

	@RequestMapping(value = "/getCustLabCombo.lims")
	public @ResponseBody List<ComboVo> getCustLabCombo() {
		return commonService.getCustLabCombo();
	}

	//시험항목조회-기준규격(팝업)
	@RequestMapping(value = "/getExprIemListM.lims")
	public @ResponseBody List<ExpriemMVo> getExprIemListM(@RequestBody ExpriemMVo vo, HttpServletRequest request){
		List<ExpriemMVo> result = commonService.getExprIemListM(vo);
		return result;
	}

	//시험항목조회-기준규격 리스트 체크해서 시험항목 만듬.(팝업)
	@RequestMapping(value = "/getAddExprIemListM.lims")
	public @ResponseBody List<ExpriemMVo> getAddExprIemListM(@RequestBody ExpriemMVo vo, HttpServletRequest request){
		return commonService.getAddExprIemListM(vo);
	}

	//시험항목조회-제품 일련번호로 구분해서 시험항목 (팝업)
	@RequestMapping(value = "/getprductAddExprIemListM.lims")
	public @ResponseBody List<ExpriemMVo> getprductAddExprIemListM(@RequestBody WrhousngMVo vo, HttpServletRequest request){
		return commonService.getprductAddExprIemListM(vo);
	}

	//담당팀 콤보
	@RequestMapping(value = "/getChrgTeamCombo.lims")
	public @ResponseBody List<ChrgTeamMVo> getChrgTeamCombo(@RequestBody ChrgTeamMVo vo, HttpServletRequest request){
		return commonService.getChrgTeamCombo(vo);
	}

	//시험항목조회-기준규격 리스트 체크해서 시험항목 만듬.(팝업)
	@RequestMapping(value = "/chartImgDown.lims")
	public Img2Excel chartImgDown(ImpartclLogMVo vo, HttpServletRequest request, HttpServletResponse response){
		return new Img2Excel(vo.getChartImg());
	}

	//시험항목조회-기준규격 리스트 체크해서 시험항목 만듬.(팝업)
	@RequestMapping(value = "/getCmmnDteFileCombo.lims")
	public @ResponseBody List<CmmnCodeMVo> getCmmnDteFileCombo(@RequestBody CmmnCodeMVo vo, HttpServletRequest request){
		return commonService.getCmmnDteFileCombo(vo);
	}

	@RequestMapping(value = "insAuditAt.lims")
	@ResponseBody
	public int insAuditAt(@RequestBody CmmnCodeMVo vo) {
		return commonService.insAuditAt(vo);
	}

	//담당팀 콤보(의뢰 접수 기준)
	@RequestMapping(value = "/getAnalsTeamCombo.lims")
	public @ResponseBody List<ChrgTeamMVo> getAnalsTeamCombo(@RequestBody ChrgTeamMVo vo, HttpServletRequest request){
		return commonService.getAnalsTeamCombo(vo);
	}

	//담당팀 콤보(의뢰 접수 기준)
	@RequestMapping(value = "/getExprMthCombo.lims")
	public @ResponseBody List<ExprMthMVo> getExprMthCombo(@RequestBody ExprMthMVo vo, HttpServletRequest request){
		return commonService.getExprMthCombo(vo);
	}

	@RequestMapping(value = "/getMhrlsNmCombo.lims")
	public @ResponseBody List<ComboVo> getMhrlsNmCombo(@RequestBody CmpdsUseMVo vo, HttpServletRequest request){
		return commonService.getMhrlsNmCombo(vo);
	}

	/**
	 * @param vo 시험항목 분류 콤보 리스트
	 */
	@RequestMapping(value = "/getExpriemClComboList.lims")
	public @ResponseBody List<ComboVo> getExpriemClComboList(@RequestBody CmmnCodeMVo vo){;
		return commonService.getExpriemClComboList(vo);
	}

	/**
	 * @param vo - 예방 조치 문구 콤보 리스트
	 */
	@RequestMapping(value = "/getPrevntMsgGbnList.lims")
	public @ResponseBody List<ComboVo> getPrevntMsgGbnList(@RequestBody CmmnCodeMVo vo){
		return commonService.getPrevntMsgGbnList(vo);
	}

	/**
	 * 부서별 알림대상자 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getSyDeptAcctoNtcnTrgter.lims")
	public @ResponseBody List<DlivyMVo> getSyDeptAcctoNtcnTrgter(@RequestBody DlivyMVo vo){
		return commonService.getSyDeptAcctoNtcnTrgter(vo);
	}

	/**
	 * 부서별 알림대상자 저장
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/insSyDeptAcctoNtcnTrgter.lims")
	public @ResponseBody int insSyDeptAcctoNtcnTrgter(@RequestBody DlivyMVo vo){
		return commonService.insSyDeptAcctoNtcnTrgter(vo);
	}

	/**
	 *
	 * @param vo
	 * @return warning mail db에 쌓아주고 키값배열 그대로 뱉어주는 컨트롤러
	 */
	/*@RequestMapping(value = "/stackEmailCn.lims")
	public @ResponseBody String[] test(@RequestBody IssueMVo vo){

		String[] test = vo.getStringIssue();

		Thread thread = swing.getThread();
		System.out.println(">>>>>>> : test");
		for(int i=0; i<test.length; i++) {
			synchronized (thread) {
				// test = ["iOlQEnF3RQdaBP07Ma4F0Q%3D%3D", "iOlQEnF3RQdaBP07Ma4F0Q%3D%3D", "iOlQEnF3RQdaBP07Ma4F0Q%3D%3D", "iOlQEnF3RQdaBP07Ma4F0Q%3D%3D"]
//				swing.goUrl("203.229.218.224:23001//chart/getChart.lims?c=" + test[i] + "&call=issue");
				swing.goUrl("localhost:8082/chart/getChart.lims?c=" + test[i] + "&call=issue");
				try {
					thread.wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}

		System.out.println(">>>>>>> : test22");

		return test;
	}*/

	@RequestMapping(value = "/getCommonAllInfo.lims")
	public @ResponseBody List<CmmnCodeMVo> getCommonAllInfo(@RequestBody CmmnCodeMVo vo){
		return commonService.getCommonAllInfo(vo);
	}

	// 단위(콤보)
	@RequestMapping(value = "/getUnitListCombo.lims" )
	public @ResponseBody List<ComboVo> getUnitListCombo(@RequestBody UnitMVo vo, Model model) {
		return commonService.getUnitListCombo(vo);
	}

	@RequestMapping(value = "ckeditor5ImageUpload.lims")
	public @ResponseBody String ckeditor5ImageUpload(@RequestParam(value = "upload", required = false) MultipartFile fileload) {
		if(!fileload.isEmpty()) {
			try {
				String originalFileName = fileload.getOriginalFilename();
				String originalExtension = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
				String regex = "(jpg|jpeg|png|gif|bmp)";
				if(originalExtension.matches(regex)) {
					BufferedImage image = ImageIO.read(fileload.getInputStream());
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					ImageIO.write(image, "png", baos);
					String encodedImage = Base64.getEncoder().encodeToString(baos.toByteArray());    //생성된 바이너리
					encodedImage = "data:image/jpeg;base64," + encodedImage;
//					String encodedImage = "";
//					encodedImage = "data:image/jpeg;base64," + org.springframework.security.crypto.codec.Base64.encode(baos.toByteArray());
					return "{ \"uploaded\" : true, \"url\" : \"" + encodedImage + "\" }";
				} else {
					return "{ \"uploaded\" : false, \"error\" : {\"message\" : \"이미지파일만 가능합니다. 다시 시도해 주세요.\"} }";
				}
			} catch(IOException e) {
				e.printStackTrace();
			}
		}
		return "{ \"uploaded\" : false, \"error\" : {\"message\" : \"업로드 중 에러가 발생했습니다. 다시 시도해 주세요.\"} }";
	}

	/**
	 * 결재회수
	 * @param vo DocMVo sanctnSeqno
	 * @return
	 */
	@RequestMapping(value = "/colSanctnM.lims")
	public @ResponseBody int colSanctnM(@RequestBody DocDto vo){
		return commonService.colSanctnM(vo);
	}

	/**
	 * 결재회수
	 * @param vo DocMVo sanctnSeqno
	 * @return
	 */
	@RequestMapping(value = "/getMtrilComboList.lims")
	public @ResponseBody List<PrductMVo> getMtrilComboList(@RequestBody PrductMVo vo){
		return commonService.getMtrilComboList(vo);
	}

	/**
	 * 배포처 저장
	 *
	 */
	@RequestMapping(value = "/delTrgterList")
	public @ResponseBody int delTrgterList(@RequestBody WdtbVo vo){
		return commonService.delTrgterList(vo);
	}

	/**
	 * 배포처 저장
	 *
	 */
	@RequestMapping(value = "/insWdtb")
	public @ResponseBody int insWdtb(@RequestBody WdtbVo vo){
		return commonService.insWdtb(vo);
	}

	/**
	 * 배포 대상자 조회
	 *
	 *
	 */
	@RequestMapping(value = "/getWdtbTrgterList.lims")
	public @ResponseBody List<WdtbVo> getWdtbTrgterList(@RequestBody WdtbVo vo){
		return commonService.getWdtbTrgterList(vo);
	}

	/**
	 * 품질 문서 이력 조회
	 *
	 */
	@RequestMapping(value = "/getQlityDocHistList.lims")
	public @ResponseBody List<QlityDocHistVo> getQlityDocHistList(@RequestBody QlityDocHistVo vo){
		return commonService.getQlityDocHistList(vo);
	}

	/**
	 * @return 시험항목 체크리스트에 바인더아이템벨류아이디 유/무 확인하기위한 리스트
	 */
	@RequestMapping(value = "getPdfViewerBinderitemvalueId.lims" )
	public @ResponseBody List<ResultInputMVo> getPdfViewerBinderitemvalueId(@RequestBody List<ResultInputMVo> list) {
		return commonService.getPdfViewerBinderitemvalueId(list);
	}

	/**
	 * @return PDF Viewer 팝업에 RowData 리스트
	 */
	@RequestMapping(value = "getPdfViewerRowData.lims" )
	public @ResponseBody List<RdmsMVo> getPdfViewerRowData(@RequestBody ResultInputMVo vo) {
		return commonService.getPdfViewerRowData(vo);
	}

	/**
	 * @return PDF Viewer Data
	 */
	@RequestMapping(value = "getblobPdfViewer.lims" )
	public @ResponseBody FileDetailMVo getblobPdfViewer(@RequestBody RdmsMVo vo) {
		return commonService.getblobPdfViewer(vo);
	}

	/**
	 * @return PDF Viewer Data List
	 */
	@RequestMapping(value = "getCheckBlobPdfViewer.lims" )
	public @ResponseBody FileDetailMVo getCheckBlobPdfViewer(@RequestBody List<RdmsMVo> list) {
		return commonService.getCheckBlobPdfViewer(list);
	}

	/**
	 * @return 병합문서보기 팝업
	 */
	@SetLocale()
	@RequestMapping(value = "PdfViewerPopupM.lims")
	public String pdfViewerPopupM(Model model, HttpServletRequest request) {
		Map<String, Object> paramMap = new HashMap<>();
		Enumeration<String> paramNames = request.getParameterNames();
		while(paramNames.hasMoreElements()) {
			String name	= paramNames.nextElement().toString();
			paramMap.put(name, request.getParameter(name));
		}
		model.addAttribute("param", paramMap);
		return "src/PdfViewerPopupM";
	}

	/**
	 *
	 * @param param - 사용자 입력 패스워드
	 * @return int
	 */
	@RequestMapping(value = "passwordPolicyCheck.lims")
	public @ResponseBody int passwordPolicyCheck(@RequestBody String param) {
		return commonService.passwordPolicyCheck(param);
	}


	/**
	 *
	 * rd 서버 저장
	 *
	 */
	@RequestMapping(value = "printCours.lims")
	public @ResponseBody List<PrintngMVO> printCours(@RequestBody PrintngMVO vo){
		return commonService.printCours(vo);

	}
	@RequestMapping(value = "getScpExprList.lims")
	public @ResponseBody List<TrendStdrMVO> getScpExprList(@RequestBody TrendStdrMVO vo){
		return commonService.getScpExprList(vo);

	}
	
	//분석실 콤보
	@RequestMapping(value = "/getCustlabCombo.lims")
	public @ResponseBody List<ReceiptManageDto> getCustlabCombo(@RequestBody ReceiptManageDto vo, HttpServletRequest request){
		return commonService.getCustlabCombo(vo);
	}
	
	// 결재 건수 조회
	@RequestMapping(value = "/getSanctnCount.lims")
	public @ResponseBody List<SanctnCountDto> getSanctnCount(){
		return commonService.getSanctnCount();
	}
	
}
