package lims.sys.controller;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.sys.service.NoticeWriteMService;
import lims.sys.vo.NoticeWriteMVo;
import lims.util.Locale.SetLocale;

@Controller
@RequestMapping(value="/sys")
public class NoticeWriteMController {
	
	
	@Resource(name = "noticeWriteMServiceImpl")
	private NoticeWriteMService noticeWriteMService;
	
	@SetLocale()
	@RequestMapping(value = "NoticeWriteM.lims", method=RequestMethod.GET)
	public String noticeWriteM(Model model,HttpServletRequest request) {
		String board = request.getParameter("board");
		model.addAttribute("board", board);
		
		return "sys/NoticeWriteM";
	}
	
	// 게시판 바인딩
	@RequestMapping(value = "getBbsCode.lims")
	public @ResponseBody List<NoticeWriteMVo> getBbsCode(@RequestBody NoticeWriteMVo vo, Model model) {
		List<NoticeWriteMVo> result = noticeWriteMService.getBbsCode(vo);
		
		return result;
	}
	
	
	//공지사항 게시판  그리드 조회
	@RequestMapping(value = "getNoticeWriteMList.lims")
	public @ResponseBody List<NoticeWriteMVo> getNoticeWriteMList (@RequestBody NoticeWriteMVo vo,  Model model) {
		List<NoticeWriteMVo> result = noticeWriteMService.getNoticeWriteMList(vo);
		
		return result;
	}
	
	// 저장 및 수정
	@RequestMapping(value = "saveNoticeWriteM.lims")
	public @ResponseBody int saveNoticeWriteM (@RequestBody NoticeWriteMVo vo) {
		
		return noticeWriteMService.saveNoticeWriteM(vo);
	}
	
	// 조회수 증가
	@RequestMapping(value = "countNoticeWriteM.lims")
	public @ResponseBody int countNoticeWriteM (@RequestBody NoticeWriteMVo vo) {
		
		return noticeWriteMService.countNoticeWriteM(vo);
	}
	
	// 답변 조회
	@RequestMapping(value = "getNoticeAnswerM.lims")
	public @ResponseBody NoticeWriteMVo getNoticeAnswerM (@RequestBody NoticeWriteMVo vo,  Model model) {
		
		return noticeWriteMService.getNoticeAnswerM(vo);
	}
	
	// 답변 저장 및 수정
	@RequestMapping(value = "saveNoticeAnswerM.lims")
	public @ResponseBody int saveNoticeAnswerM (@RequestBody NoticeWriteMVo vo) {
		
		return noticeWriteMService.saveNoticeAnswerM(vo);
	}

}
