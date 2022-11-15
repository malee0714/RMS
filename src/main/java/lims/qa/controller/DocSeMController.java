package lims.qa.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import lims.qa.service.DocSeMService;
import lims.qa.vo.DocSeMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/qa")
public class DocSeMController {

//	private Util util = Util.getInstance();


	@Resource(name = "docSeMServiceImpl")
	private DocSeMService docSeMService;

	@SetLocale()
	@RequestMapping(value = "DocSeM.lims")
	public String docSeM(Model model) {
		return "qa/DocSeM";
	}

	// 그룹/상세 중복 값 체크
	@RequestMapping(value = "confirmDocSeMGbnList.lims")
	public @ResponseBody int confirmDocSeMGbnList (@RequestBody DocSeMVo vo,  Model model){
		return  docSeMService.confirmDocSeMGbnList(vo);
	}


	@RequestMapping(value="getDocSeMList.lims")
	public @ResponseBody List<DocSeMVo> getDocSeMList (@RequestBody DocSeMVo vo, Model model){
		List<DocSeMVo> result = docSeMService.getDocSeMList(vo);
		return result;
	}

	// 상세 코드 조회(검색)
	@RequestMapping(value = "getDocSeMDetailList.lims")
	public @ResponseBody List<DocSeMVo> getDocSeMDetailList (@RequestBody DocSeMVo vo, Model model) {
		List<DocSeMVo> result = docSeMService.getDocSeMDetailList(vo);

		return result;
	}

	// 그룹코드 입력 및 수정
	@RequestMapping(value = "putDocSeM.lims")
	public @ResponseBody int putDocSeM(@RequestBody DocSeMVo vo) {

		return docSeMService.putDocSeM(vo);
	}

	//상세코드 입력 및 수정
	@RequestMapping(value = "putDocSeMDetail.lims")
	public @ResponseBody int putDocSeMDetail(@RequestBody DocSeMVo vo) {

		return docSeMService.putDocSeMDetail(vo);
	}

}

