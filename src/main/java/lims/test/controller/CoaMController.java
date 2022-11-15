package lims.test.controller;

import lims.com.service.DragDropFileMService;
import lims.com.service.FileUpDownloadMService;
import lims.com.vo.ComboVo;
import lims.com.vo.FileDetailMVo;
import lims.test.service.CoaMService;
import lims.test.vo.CoaMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequestMapping("/test")
public class CoaMController {

	@Value("${file.upload.path}")
	private String uploadPath;
	private final CoaMService coaMService;
	private final FileUpDownloadMService fileUpDownloadMService;
	private final DragDropFileMService dragDropFileMService;

	@Autowired
	public CoaMController(CoaMService coaMServiceImpl, FileUpDownloadMService fileUpDownloadMServiceImpl,
						  DragDropFileMService dragDropFileMServiceImpl) {
		this.coaMService = coaMServiceImpl;
		this.fileUpDownloadMService = fileUpDownloadMServiceImpl;
		this.dragDropFileMService = dragDropFileMServiceImpl;
	}

	@SetLocale()
	@RequestMapping(value = "/CoaM.lims")
	public String CoaM(Model model) {
		return "test/CoaM";
	}

	@RequestMapping(value = "/getCoaList.lims")
	@ResponseBody
	public List<CoaMVo> getCoaList(@RequestBody CoaMVo vo) {
		return coaMService.getCoaList(vo);
	}

	@RequestMapping(value = "/createExcelSample.lims")
	@ResponseBody
	public Map<String, String> createExcelSample(@RequestBody List<CoaMVo> list, HttpServletResponse response) {
		return coaMService.createExcelSample(list, response);
	}

	@RequestMapping(value = "/getExpriemXls.lims")
	@ResponseBody
	public Map<String, String> getExpriemXls(@RequestBody List<CoaMVo> list, HttpServletResponse response) {
		return coaMService.getExpriemXls(list, response);
	}

	@RequestMapping(value = "/insCoaInfo.lims")
	@ResponseBody
	public Map<String, String> insCoaInfo(@RequestBody List<CoaMVo> list, HttpServletResponse response) {
		return coaMService.insCoaInfo(list, response);
	}

	@RequestMapping(value = "/excelDownload.lims")
	public void excelDownload(@RequestParam(value="params", required=false) String params, HttpServletResponse response) {

		try {
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(URLDecoder.decode(params, "UTF-8"));
			JSONObject jsonObj = (JSONObject) obj;

			String fileName = jsonObj.get("fileName").toString();
			String fileType = jsonObj.get("fileType").toString();
			String filePath = jsonObj.get("filePath").toString();

			Map<String, String> map = new HashMap<String, String>();
			map.put("fileName", fileName);
			map.put("fileType", fileType);
			map.put("filePath", filePath);

			fileUpDownloadMService.downloadAction(map, response);

			//생성한 파일 마지막에 삭제
			File createFile = new File(filePath);
			if (createFile.isFile())
				createFile.delete();

		} catch (Exception e) {
			throw new CustomException(e, params, "엑셀 다운로드 과정에서 예외가 발생했습니다.");
		}
	}

	@RequestMapping("/pblicateCoaExcelDownload.lims")
	public void pblicateCoaExcelDownload(@RequestParam(value = "param") String param, HttpServletResponse response) {

		try {
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(URLDecoder.decode(param, "UTF-8"));
			JSONObject jsonObj = (JSONObject) obj;

			FileDetailMVo fileVO = new FileDetailMVo();
			fileVO.setAtchmnflSeqno(Integer.valueOf(jsonObj.get("atchmnflSeqno").toString()));
			List<FileDetailMVo> fileInfo = dragDropFileMService.getFiles(fileVO);

			Map<String, String> map = new HashMap<String, String>();
			String fileName = fileInfo.get(0).getOrginlFileNm();
			map.put("fileName", fileName);
			map.put("fileType", fileName.substring(fileName.indexOf("."), fileName.length()).replace(".", ""));
			map.put("filePath", uploadPath +  fileInfo.get(0).getStreFileNm());

			fileUpDownloadMService.downloadAction(map, response);

		} catch (Exception e) {
			throw new CustomException(e, param, "COA 성적서 재출력 과정에서 예외가 발생했습니다.");
		}
	}

	@RequestMapping(value = "/getReqUpperLotList.lims")
	@ResponseBody
	public List<CoaMVo> getReqUpperLotList(@RequestBody CoaMVo vo) {
		try {
			return coaMService.getReqUpperLotList(vo);
		} catch (Exception e) {
			throw new CustomException(e, vo, "의뢰 lot목록 조회 과정에서 예외가 발생했습니다.");
		}
	}

	@RequestMapping(value = "/getCoaUpperList.lims")
	@ResponseBody
	public List<CoaMVo> getCoaUpperList(@RequestBody CoaMVo vo) {
		try {
			return coaMService.getCoaUpperList(vo);
		} catch (Exception e) {
			throw new CustomException(e, vo, "발행된 해당 COA의 lot목록을 조회하는 과정에서 예외가 발생했습니다.");
		}
	}

	@RequestMapping(value = "/getEntrpsListHasPrint.lims")
	@ResponseBody
	public List<CoaMVo> getEntrpsListHasPrint(@RequestBody CoaMVo vo) {
		return coaMService.getEntrpsListHasPrint(vo);
	}

	@RequestMapping(value = "/getEntrpsPrintCombo.lims")
	@ResponseBody
	public List<ComboVo> getEntrpsPrintCombo(@RequestBody CoaMVo vo) {
		try {
			return coaMService.getEntrpsPrintCombo(vo);
		} catch (Exception e) {
			throw new CustomException(e, vo, "업체양식 목록을 조회하는 과정에서 예외가 발생했습니다.");
		}
	}

	@RequestMapping(value = "/getEntrpsPrintInfo.lims")
	@ResponseBody
	public CoaMVo getEntrpsPrintInfo(@RequestBody CoaMVo vo) {
		try {
			return coaMService.getEntrpsPrintInfo(vo);
		} catch (Exception e) {
			throw new CustomException(e, vo, "업체양식 정보를 조회하는 과정에서 예외가 발생했습니다.");
		}
	}
	
	@RequestMapping(value = "/delCoaList.lims")
	@ResponseBody
	public int delCoaList(@RequestBody List<CoaMVo> list) {
		return coaMService.delCoaList(list);
	}
	
}
