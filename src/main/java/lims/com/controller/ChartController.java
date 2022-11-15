package lims.com.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.com.vo.ChartVo;
import lims.test.service.IssueMService;
import lims.test.vo.IssueMVo;
import lims.util.AES256Cipher;

@Controller
@RequestMapping("/chart")
public class ChartController {
	@Resource(name = "IssueMService")
	private IssueMService issueMService;

	@RequestMapping(value = "/getChart.lims")
	public String getChart(Model model, HttpServletRequest request){
		request.getAttribute("c");
		request.getAttribute("call");
		return "chart";
	}

	/**
	 * 이슈관리 데이터 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping("/getIssueMList.lims")
	public @ResponseBody List<IssueMVo> getIssueMList(@RequestBody IssueMVo vo){
		try{
			String c = AES256Cipher.AES_Decode(vo.getC().toString());
			vo.setShrIssueSeqno(c);
		}catch(Exception e){
			e.getStackTrace();
		}
		return issueMService.getIssueMList(vo);
	}

	/**
	 * 이슈관리 리스트 조회
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/getChartData.lims",consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody List<ChartVo> getChartData(@RequestBody IssueMVo vo){

		List<ChartVo> IssueVo = new ArrayList<>();

		try{
			String c = AES256Cipher.AES_Decode(vo.getC().toString());
			vo.setIssueSeqno(c);
			IssueVo = issueMService.getIssueMChart(vo);

		}catch(Exception e){
			e.getStackTrace();
		}


		return IssueVo;
	}

	@RequestMapping(value = "/getIssueMChartData.lims",consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody List<ChartVo> getIssueMChartData(@RequestBody IssueMVo vo){

		return issueMService.getIssueMChartData(vo);
	}

	/**
	 *
	 * @param vo
	 * @return 차트 이미지 생성해서 다시 이름 뱉어줌
	 */

	@RequestMapping("/saveChartImg.lims")
	public @ResponseBody String saveChartImg(@RequestBody IssueMVo vo){
		System.out.println(">>>>>>>>>>>>> saveChartImg.lims 진입");
		return issueMService.saveChartImg(vo);
	}

	@RequestMapping("/updMailCn.lims")
	public @ResponseBody int updMailCn(@RequestBody IssueMVo vo){
		try{
			String c = AES256Cipher.AES_Decode(vo.getC().toString());
			vo.setIssueSeqno(c);
			vo.setEmailCn(URLDecoder.decode(vo.getEmailCn(),"UTF-8"));
		}catch(Exception e){
			e.getStackTrace();
		}
		return issueMService.updMailCn(vo);
	}
}
