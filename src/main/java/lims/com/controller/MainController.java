package lims.com.controller;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.script.ScriptEngine;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.itextpdf.text.log.SysoLogger;

import lims.com.dao.LocaleDao;
import lims.com.service.MainService;
import lims.com.vo.MainVo;
import lims.rsc.vo.CmpdsUseMVo;
import lims.rsc.vo.MrlsEdayChckMVo;
import lims.src.controller.QCostMController;
import lims.src.vo.ImpartclLogMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.util.ScriptEngineUtil;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/")
public class MainController {
	
	
	
	@Resource(name="mainServiceImpl")
	private MainService mainServiceImpl;
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
	private LocaleDao LocaleDao;
	
	@SetLocale()
	@RequestMapping(value = "main.lims" )
	public Model login(Model model) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
//		MainVo vo = mainServiceImpl.getSelProEa();
		
//		model.addObject("data", vo);
//		model.setViewName("main");
		
		return model;
	}
	
	@SetLocale()
	@RequestMapping(value = "imminentNotifyP01.lims" )
	public Model imminentNotifyP01(Model model) {
		return model;
	}
	
	
	
	@RequestMapping(value = "getSelProEa.lims" )
	public @ResponseBody MainVo getSelProEa(Model model, @RequestBody MainVo vo) {
		return mainServiceImpl.getSelProEa(vo);
	}
	
	//메인 헤더에서 사용자 정보 수정
	@RequestMapping(value = "saveUserPassword.lims" )
	public @ResponseBody Integer saveUserPassword(@RequestBody UserMVo vo, Model model, HttpServletRequest request) {
		Integer check = 1;
		// ID 현재 세션에서 얻어와서
		UserMVo UserMVo = (UserMVo) request.getSession().getAttribute("UserMVo");
		// vo 수정자에 저장
		vo.setLastChangerId(UserMVo.getUserId());
		
		check = mainServiceImpl.saveUserPassword(vo);
		
		return check;
	}
	
	//기관콤보박스목록가져오기
	@RequestMapping(value = "getUserChangeBestInspctInsttList.lims" )
	public @ResponseBody List<UserMVo> getUserChangeBestInspctInsttList(@RequestBody UserMVo vo, Model model) {
		return mainServiceImpl.getUserChangeBestInspctInsttList(vo);
	}
	
	//부서콤보박스목록가져오기
	@RequestMapping(value = "getUserChangeInspctInsttList.lims" )
	public @ResponseBody List<UserMVo> getUserChangeInspctInsttList(@RequestBody UserMVo vo, Model model) {
		return mainServiceImpl.getUserChangeInspctInsttList(vo);
	}
	
	//사용자콤보박스목록가져오기
	@RequestMapping(value = "getUserChangeUserList.lims" )
	public @ResponseBody List<UserMVo> getUserChangeUserList(@RequestBody UserMVo vo, Model model) {
		return mainServiceImpl.getUserChangeUserList(vo);
	}

	//메인 화면 헤더 부분에 일일 카운트 정보 호출
	@RequestMapping(value = "getOneDayCnt.lims" )
	public @ResponseBody MainVo getOneDayCnt(@RequestBody MainVo vo) {
		return mainServiceImpl.getOneDayCnt(vo);
	}
	
	// 메인 화면 공지사항 그리드 조회
	@RequestMapping(value = "getBbsList.lims")
	public @ResponseBody List<MainVo> getBbsList(@RequestBody MainVo vo){
		List<MainVo> result = mainServiceImpl.getBbsList(vo);

		return result;
	}
	
	
	// 메인 화면 팀별 그리드 조회(당월)
	@RequestMapping(value = "gettcmList.lims")
	public @ResponseBody List<MainVo> gettcmList(@RequestBody MainVo vo){
		List<MainVo> result = mainServiceImpl.gettcmList(vo);
		
		return result;
	}
	
	
	// 메인 화면 이상목록 그리드 조회(당월)
//	@RequestMapping(value = "getIsscList.lims")
//	public @ResponseBody List<MainVo> getIsscList(@RequestBody MainVo vo){
//		List<MainVo> result = mainServiceImpl.getIsscList(vo);
//
//		return result;
//	}
	@RequestMapping(value = "getInspctList.lims")
	public @ResponseBody List<MainVo> getInspctList(@RequestBody MainVo vo){
		List<MainVo> result = mainServiceImpl.getInspctList(vo);
		
		return result;
	}
	@RequestMapping(value = "getPrductList.lims")
	public @ResponseBody List<MainVo> getPrductList(@RequestBody MainVo vo){
		List<MainVo> result = mainServiceImpl.getPrductList(vo);
		
		return result;
	}
	@RequestMapping(value = "getValidList.lims")
	public @ResponseBody List<MainVo> getValidList(@RequestBody MainVo vo){
		List<MainVo> result = mainServiceImpl.getValidList(vo);
		
		return result;
	}
	@RequestMapping(value = "getRefromList.lims")
	public @ResponseBody List<MainVo> getRefromList(@RequestBody MainVo vo){
		List<MainVo> result = mainServiceImpl.getRefromList(vo);
		
		return result;
	}
	
	
	
	
	
	// 부재자 현황 조회
	@RequestMapping(value = "getAbsntList.lims")
	public @ResponseBody List<MainVo> getAbsntList(@RequestBody MainVo vo){
		List<MainVo> result = mainServiceImpl.getAbsntList(vo);
		
		return result;
	}
	
	// 이번 달 의뢰건수
	@RequestMapping(value = "getJobrealmctn.lims")
	public @ResponseBody MainVo getJobrealmctn(@RequestBody MainVo vo){
		return mainServiceImpl.getJobrealmctn(vo);
	}
	
	// 이번 달 의뢰건수 팝업
	@RequestMapping(value = "getRequestMainPopupList.lims")
	public @ResponseBody List<MainVo> getRequestMainPopupList(@RequestBody MainVo vo){
		List<MainVo> result = mainServiceImpl.getRequestMainPopupList(vo);
		
		return result;
	}

	// 처리기한 임박건수
	@RequestMapping(value = "getTimelimit.lims")
	public @ResponseBody MainVo getTimelimit(@RequestBody MainVo vo){
		return mainServiceImpl.getTimelimit(vo);
	}
	
	// 우리부서 진행상황
	@RequestMapping(value = "getRequestProgress.lims")
	public @ResponseBody MainVo getRequestProgress(@RequestBody MainVo vo){
		return mainServiceImpl.getRequestProgress(vo);
	}
	
	// 우리부서 진행상황
	@RequestMapping(value = "getOnlineParticleList.lims")
	public @ResponseBody List<ImpartclLogMVo> getOnlineParticleList(){
		return mainServiceImpl.getOnlineParticleList();
	}
	
	// 우리부서 진행상황
	@RequestMapping(value = "getMhrlsEdayChckList.lims")
	public @ResponseBody List<MrlsEdayChckMVo> getMhrlsEdayChckList(){
		return mainServiceImpl.getMhrlsEdayChckList();
	}
	
	//고비용+표준물질
	@RequestMapping(value = "getConStandList.lims")
	public @ResponseBody List<CmpdsUseMVo> getConStandList(){
		return mainServiceImpl.getConStandList();
	}
	
	@RequestMapping(value = "popup/popBbs.lims")
	public String popBbs(Model model, HttpServletRequest request){
		Map<String, Object> map = commonFunc.getParameterMap(request);
		map.put("sntncSeqno", map.get("param"));
		
		
//		if(list.get(i).getBlobCn() != null){
//			list.get(i).setCn(new String(list.get(i).getBlobCn()));
//		}
//		
		model.addAttribute("user", (UserMVo)request.getSession().getAttribute("UserMVo"));
		
		Map<String, Object> result = mainServiceImpl.getBbsData(map);
		System.out.println("test>>>"+result.get("BLOB_CN"));
		Blob blob = (Blob) result.get("BLOB_CN");
		byte[] bdata = null;
		try {
			bdata = blob.getBytes(1, (int) blob.length());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String text = new String(bdata);
		
		
		
		System.out.println("test2>>>"+text);
		
		result.put("CN", text);
		
		model.addAttribute("detail", result);
	
		
		
		model.addAttribute("param", map);
		return "com/popup/popBbs";
	}

}
