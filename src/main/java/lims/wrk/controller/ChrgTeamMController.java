package lims.wrk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.util.Locale.SetLocale;
import lims.wrk.service.ChrgTeamMService;
import lims.wrk.vo.ChrgTeamMVo;

@Controller
@RequestMapping("/wrk")
public class ChrgTeamMController {
	
	
	@Resource(name = "chrgTeamMServiceImpl")
	
	private ChrgTeamMService chrgTeamMService;
	
	@SetLocale()
	@RequestMapping(value = "ChrgTeamM.lims" )
	public String chrgTeamM(HttpServletRequest request, Model model) {		
		return "wrk/ChrgTeamM";
	}
	
	//결재라인목록 Grid
	@RequestMapping("/getChrgTeamList")
	public @ResponseBody List<ChrgTeamMVo> getChrgTeamList(@RequestBody ChrgTeamMVo vo, HttpServletRequest request){
		return chrgTeamMService.getChrgTeamList(vo);
	}	
	
	//사용자목록 Grid
	@RequestMapping("/getUserBList")
	public @ResponseBody List<ChrgTeamMVo> getUserList(@RequestBody ChrgTeamMVo vo, HttpServletRequest request){		
		return chrgTeamMService.getUserList(vo);
	}	
	
	//그룹목록 Grid
	@RequestMapping("/getChrgTeamUserList")
	public @ResponseBody List<ChrgTeamMVo> getChrgTeamUserList(@RequestBody ChrgTeamMVo vo, HttpServletRequest request){
		return chrgTeamMService.getChrgTeamUserList(vo);
	}
	
	//저장
	@RequestMapping("/saveChrgTeam")
	public @ResponseBody String saveChrgTeam(@RequestBody ChrgTeamMVo vo){
		return chrgTeamMService.saveChrgTeam(vo);
//		return masterChrgTeamMVO.getChrgTeamSeqno();
	}
	
	//삭제 이벤트
	@RequestMapping("/deleteChrgTeam.lims")
	public @ResponseBody int deleteChrgTeam(@RequestBody ChrgTeamMVo vo, Model model, HttpServletRequest request){
		int result = chrgTeamMService.deleteChrgTeam(vo);
		return result;
	};
	
	//담당팀  IP Grid
	@RequestMapping("/getChrgTeamIpList")
	public @ResponseBody List<ChrgTeamMVo> getChrgTeamIpList(@RequestBody ChrgTeamMVo vo){
		return chrgTeamMService.getChrgTeamIpList(vo);
	}	
	
	//담당팀  IP 콤보
	@RequestMapping("/getChrgTeamIpComboList")
	public @ResponseBody List<ChrgTeamMVo> getChrgTeamIpComboList(@RequestBody ChrgTeamMVo vo){
		return chrgTeamMService.getChrgTeamIpComboList(vo);
	}	
}
