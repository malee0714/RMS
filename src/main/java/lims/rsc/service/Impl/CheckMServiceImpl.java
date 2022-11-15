package lims.rsc.service.Impl;

import lims.rsc.dao.CheckMDao;
import lims.rsc.service.CheckMService;
import lims.rsc.vo.CheckMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class CheckMServiceImpl implements CheckMService{
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
	private CheckMDao checkMDao;
	
	@Override
	public List<CheckMVo> getCheckMList(CheckMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		return checkMDao.getCheckMList(vo);
	}
	
	@Override
	public List<CheckMVo> getCheckDetailMList(CheckMVo vo) {
		return checkMDao.getCheckDetailMList(vo);
	}
	
	@Override
	public HashMap<String,Object> saveCheckDetailMList(List<CheckMVo> vo){
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		HashMap<String,Object> map = new HashMap<String,Object>();
		// 바코드 변수 선언
		List <Object> bacodeList = new ArrayList<Object>();
		int result = 0;
		int checkResult = 0;

		for(int i=0; i <vo.size(); i++){
			String sLastChangerId = userMVo.getUserId(); 
			String wrhsdlvrmanId = userMVo.getUserId(); 
			String wrhsdlvrDeptCode = userMVo.getDeptCode();
			vo.get(i).setLastChangerId(sLastChangerId); // 로그인 세션값 할당
			vo.get(i).setWrhsdlvrmanId(wrhsdlvrmanId); // 입출고자 ID 할당
			vo.get(i).setWrhsdlvrDeptCode(wrhsdlvrDeptCode); // 입출고자 부서 할당
			
			if( vo.get(i).getAcptncQtt() != null && vo.get(i).getAcptncQtt() != ""){ // 검수 수량이 있을경우
				
				// 구매내역 테이블 검수수량, 일자, 비고 채우기
				result += checkMDao.updCheckDetail(vo.get(i));
				
				if(vo.get(i).getGridCrud() != "" && vo.get(i).getGridCrud()  != null){
					
					if(vo.get(i).getGridCrud().equals("0")){
						// 입출고 테이블 저장
						result += checkMDao.insCheckWrhsdlvr(vo.get(i));
					}
					
					if(vo.get(i).getGridCrud().equals("U")){
						// 입출고 테이블 수정
						result += checkMDao.updCheckWrhsdlvr(vo.get(i));
					}
				}
				
				// 제품 바코드 테이블 값 채우기
				int acptncQtt = Integer.parseInt(vo.get(i).getAcptncQtt());
				for(int j=0; j<acptncQtt; j++){
					result += checkMDao.insBrcdSeqno(vo.get(i));
					
					// 바코드 데이터 할당
					bacodeList.add(vo.get(i).getBrcd());
				}

				// 구매테이블 진행상황 수정, 검수완료 일자 수정
				checkResult = checkMDao.updCheck(vo.get(i)); 
			}
			
		}

		map.put("checkResult", checkResult);
		map.put("result", result);
		map.put("bacodeList", bacodeList);
		
		return map;
	}
	

}
