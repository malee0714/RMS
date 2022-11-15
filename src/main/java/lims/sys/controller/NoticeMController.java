package lims.sys.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.service.NoticeMService;
import lims.sys.vo.NoticeMVo;
import lims.util.Locale.SetLocale;


@Controller
@RequestMapping(value="/sys")
public class NoticeMController {
	
	
	@Resource(name = "noticeMServiceImpl")
	private NoticeMService noticeMService;
	
	@SetLocale()
	@RequestMapping(value = "NoticeM.lims")
	public String noticeM(Model model) {
		return "sys/NoticeM";
	}
	
	//게시판 관리 그리드 조회
	@RequestMapping(value = "getNoticeMList.lims")
	public @ResponseBody List<NoticeMVo> getNoticeMList (@RequestBody NoticeMVo vo,  Model model) {
		List<NoticeMVo> result = noticeMService.getNoticeMList(vo);
		
		return result;
	}
	
	// 저장 및 수정
	@RequestMapping(value = "saveNoticeM.lims")
	public @ResponseBody int saveNoticeM (@RequestBody List<NoticeMVo> vo) {
		
		return noticeMService.saveNoticeM(vo);
	}

	
}
