package lims.com.service.impl;

import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.com.dao.MainDao;
import lims.com.service.MainService;
import lims.com.vo.MainVo;
import lims.rsc.vo.CmpdsUseMVo;
import lims.rsc.vo.MrlsEdayChckMVo;
import lims.src.vo.ImpartclLogMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.util.enumMapper.EnumRDMS;

@Service
public class MainServiceImpl implements MainService{


	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Resource(name="mainDao")
	private MainDao mainDao;


	@Override
	public MainVo getSelProEa(MainVo vo) {
		return mainDao.getSelProEa(vo);
	}

	//메인 화면 초기 데이터 호출
	public HashMap<String, Object> getMainList(){
		HashMap<String, Object> map = new HashMap<String, Object>();
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo UserMVo = commonFunc.getLoginUser(httpServletRequest);
		MainVo vo = new MainVo();
		vo.setUserId(UserMVo.getUserId());

		map.put("url", mainDao.getUrl()); //메인 화면에서 세팅할 url
		map.put("aprData", mainDao.getAprData(vo)); // 결재 정보
		map.put("totalSale", mainDao.getTotalSale()); //전국 누적, 월, 일 매출
		map.put("areaSale", mainDao.getAreaSale()); //지역별 누적, 월, 일 매출 및 접수건
		map.put("newOrgList", mainDao.getNewOrgList()); // 신규 의뢰기관 목록
		map.put("docReturnList", mainDao.getDocReturnList()); // 서류 반송 목록
		map.put("sampleReturnList", mainDao.getSampleReturnList()); // 재검체 요청 목록
		map.put("prtHisList", mainDao.getPrtHisList()); // 결과보고서 재발행 내역 목록

		return map;
	}

	@Override
	public Integer saveUserPassword(UserMVo vo) {
		int result = 0;
		
		// 사용자의 현재 비밀번호와 일치하지 않을 때
		if(mainDao.getUserPasswordCheck(vo) == 0){
			result -= 1;
		}else{
			// Service에서 세션값 받아오기
			HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);

			String sLastChangerId = userMVo.getUserId();
			vo.setLastChangerId(sLastChangerId); // 로그인 세션값 할당
			vo.setLoginId(userMVo.getLoginId());
			
			result = mainDao.saveUserPassword(vo);
			
			// RDMS 패스워드 베이스64 인코딩
			String encodingPassword = Base64.getEncoder().encodeToString(vo.getPassword().getBytes());
			vo.setBasePassword(encodingPassword);
			
			// 받아온 세션값으로 사업장코드 가져오기
			String bplcCode = userMVo.getBestInspctInsttCode();
			Optional<EnumRDMS> rdms = EnumRDMS.findRdmsPL(bplcCode);
			if(rdms.isPresent()) {
				result = rdms.get().resetRdmsPassword(vo); // RDMS유저 비밀번호 업데이트
			}
		}
		
		return result;
	}

	@Override
	public List<UserMVo> getUserChangeBestInspctInsttList(UserMVo vo) {
		return mainDao.getUserChangeBestInspctInsttList(vo);
	}

	@Override
	public List<UserMVo> getUserChangeInspctInsttList(UserMVo vo) {
		return mainDao.getUserChangeInspctInsttList(vo);
	}

	@Override
	public List<UserMVo> getUserChangeUserList(UserMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo mainvo = commonFunc.getLoginUser(httpServletRequest);
		vo.setUserId(mainvo.getUserId());
		return mainDao.getUserChangeUserList(vo);
	}

	@Override
	public MainVo getOneDayCnt(MainVo vo) {
		return mainDao.getOneDayCnt(vo);
	}

	@Override
	public List<MainVo> getBbsList(MainVo vo) {

		List<MainVo> list = mainDao.getBbsList(vo);
		for(int i = 0; i < list.size(); i++) {
			if(list.get(i).getBlobCn() != null){
				list.get(i).setCn(new String(list.get(i).getBlobCn()));
			}
		}
		return list;
	}

	@Override
	public Map<String,Object> getBbsData(Map<String,Object> map){
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		return mainDao.getBbsData(map);
	}


	@Override
	public List<MainVo> gettcmList(MainVo vo) {
		return mainDao.gettcmList(vo);
	}



//	@Override
//	public List<MainVo> getIsscList(MainVo vo) {
//		return mainDao.getIsscList(vo);
//	}
	
	@Override
	public List<MainVo> getInspctList(MainVo vo) {
		return mainDao.getInspctList(vo);
	}
	@Override
	public List<MainVo> getPrductList(MainVo vo) {
		return mainDao.getPrductList(vo);
	}
	@Override
	public List<MainVo> getValidList(MainVo vo) {
		return mainDao.getValidList(vo);
	}
	@Override
	public List<MainVo> getRefromList(MainVo vo) {
		return mainDao.getRefromList(vo);
	}
	
	
	
	

	@Override
	public List<MainVo> getAbsntList(MainVo vo){
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);

		return mainDao.getAbsntList(vo);
	}

	@Override
	public  MainVo getJobrealmctn(MainVo vo){
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);

		return mainDao.getJobrealmctn(vo);
	}

	@Override
	public List<MainVo> getRequestMainPopupList(MainVo vo){
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		vo.setDeptCode(userMVo.getDeptCode());
		int sJobRealmCode;

		HashMap<String, String> jobCode = new HashMap<String, String>();
		// 0~9 클래스 인덱스값
		jobCode.put("0", "IM02000001"); // 수질
		jobCode.put("1", "IM02000002"); // 폐기물
		jobCode.put("2", "IM02000003"); // 대기
		jobCode.put("3", "IM02000004"); // 악취
		jobCode.put("4", "IM02000005"); // 소음/진동
		jobCode.put("5", "IM02000006"); // 실내공기질
		jobCode.put("6", "IM02000007"); // 다이옥신
		jobCode.put("7", "IM02000008"); // 토양
		jobCode.put("8", "IM02000009"); // 해양
		jobCode.put("9", "IM02000010"); // PCBs
		jobCode.put("10", "IM02000011"); // 석면
		jobCode.put("11", "IM02000012"); // 기타

		if(vo.getSelectedClass() != "" && vo.getSelectedClass() != null){
			sJobRealmCode = Integer.parseInt(vo.getSelectedClass()); // 메인화면 클릭한 항목 데이터

			// 메인 화면 10건의 항목에 대해 클릭한 데이터 삽입
			for(int i=0; i<jobCode.size(); i++){
				if(sJobRealmCode == i){
					vo.setJobRealmCode(jobCode.get(Integer.toString(i)));
				}
			}
		}

		return mainDao.getRequestMainPopupList(vo);
	}

	@Override
	public  MainVo getTimelimit(MainVo vo){
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);

		return mainDao.getTimelimit(vo);
	}

	@Override
	public  MainVo getRequestProgress(MainVo vo){
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);

		return mainDao.getRequestProgress(vo);
	}

	@Override
	public List<ImpartclLogMVo> getOnlineParticleList() {
		// TODO Auto-generated method stub
		return mainDao.getOnlineParticleList();
	}

	@Override
	public List<MrlsEdayChckMVo> getMhrlsEdayChckList() {
		// TODO Auto-generated method stub
		return mainDao.getMhrlsEdayChckList();
	}

	@Override
	public List<CmpdsUseMVo> getConStandList() {
		// TODO Auto-generated method stub
		return mainDao.getConStandList();
	}



}
