package lims.qa.service.Impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.com.service.CommonService;
import lims.qa.dao.CstmrRDataDao;
import lims.qa.service.CstmrRDataService;
import lims.qa.vo.CstmrRDataVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;

@Service
public class CstmrRDataServiceImpl implements CstmrRDataService{

	@Autowired
	private CstmrRDataDao cstmrRDataDao;

	
	/**
	 * 저장
	 */
	@Resource(name = "commonServiceImpl")
	private CommonService commonService;


	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	public int insCstmrRData(CstmrRDataVo vo) {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(request);		// 현재 세션 사용자
		int result = 0;
		HashMap<String,Object> map = new HashMap<>();
		
		map.put("wdtbDt",vo.getWdtbDt());
		map.put("wdtbPrearngeDt",vo.getWdtbPrearngeDt());
		map.put("wdtbSeqno",vo.getWdtbSeqno());
		map.put("cn",vo.getCn());
		map.put("lastChangerId", userMVo.getUserId());
		map.put("wdtbPosblAt","Y");
		List<CstmrRDataVo> wdtbInfoList2 = vo.getWdtbInfoList2();
		ArrayList<HashMap<String, Object>> wdtbInfoList = new ArrayList<>();
		
		for(int i=0; i<wdtbInfoList2.size(); i++){
			HashMap<String,Object> map2 = new HashMap<>();
			wdtbInfoList2.get(i).setEmailTrnsmisComptAt("N");
			wdtbInfoList2.get(i).setChrctrTrnsmisComptAt("N");
			map2.put("wdtbSeqno",wdtbInfoList2.get(i).getWdtbSeqno());
			map2.put("ordr",i+1);
			map2.put("userId", wdtbInfoList2.get(i).getUserId());
			map2.put("emailTrnsmisAt", wdtbInfoList2.get(i).getEmailTrnsmisAt());
			map2.put("chrctrTrnsmisAt", wdtbInfoList2.get(i).getChrctrTrnsmisAt());
			map2.put("emailTrnsmisComptAt", wdtbInfoList2.get(i).getEmailTrnsmisComptAt());
			map2.put("chrctrTrnsmisComptAt", wdtbInfoList2.get(i).getChrctrTrnsmisComptAt());
			map2.put("lastChangerId",userMVo.getUserId());
			wdtbInfoList.add(map2);
			
		}
		map.put("wdtbInfoList", wdtbInfoList);
		
		try{
			//개정
			if(String.valueOf(vo.getCrud()).equals("R")){
				//해당 일련번호  deleteAt = 'Y'
				//새로 개정하는 데이터 INSERT -> 일련번호 삭제 
//				result = docMDao.insDocHist(vo);
				vo.setLastVerAt("N");
				result += cstmrRDataDao.updCtmrRLastAt(vo); //해당 데이터 긁어와서 최종여부 수정
				vo.setDocSeqno(null);
				result += cstmrRDataDao.insCstmrRData(vo); //해당 데이터 새로 INSERT 즉 개정
				if("Y".equals(vo.getWdtbAt())){
					if(wdtbInfoList2.size()>0){
						commonService.saveWdtbList(map);
						String SwdtbSeqno = (String) map.get("wdtbSeqno");
						
						vo.setWdtbSeqno(SwdtbSeqno);
						result = cstmrRDataDao.updWdtbSeqno(vo);	
					}
				}
			} 
			
			//문서 삭제
			
			
			else if(String.valueOf(vo.getCrud()).equals("D")){
				result += cstmrRDataDao.updCtmrRDeleteAt(vo); //해당 데이터 긁어와서 데이터 삭제
				
				vo.setLastVerAt("Y");
				result += cstmrRDataDao.updCtmrRLastAt(vo);
			}
			
			//폐기
			else if(String.valueOf(vo.getCrud()).equals("N")){//폐기시 일련번호 지우고 새로 insert태우기
				vo.setLastVerAt("N");
				result += cstmrRDataDao.updCtmrRLastAt(vo); //해당 데이터 긁어와서 데이터 삭제
				vo.setDocSeqno(null);
				result += cstmrRDataDao.insCstmrRData(vo); //해당 데이터 새로 INSERT 즉 개정
				if(wdtbInfoList2.size()>0){
					commonService.saveWdtbList(map);
					String SwdtbSeqno = (String) map.get("wdtbSeqno");
					
					vo.setWdtbSeqno(SwdtbSeqno);
					result = cstmrRDataDao.updWdtbSeqno(vo);
				}
			}
			//문서 제정
			else{
				if("0".equals(vo.getReformNo())){   //제정시 개정일자 -> 제정일자에 세팅
					vo.setEstbshDte(vo.getReformDte()); 
					vo.setReformDte(null);	
				}
				if(vo.getDocSeqno()!=null && vo.getDocSeqno()!=""){
					result = cstmrRDataDao.updCstmrRData(vo); // 문서 수정
				}
				else{
					result = cstmrRDataDao.insCstmrRData(vo); // 첫 제정 시
				}
				if("Y".equals(vo.getWdtbAt())){
					if(wdtbInfoList2.size()>0){
						commonService.saveWdtbList(map);
						String SwdtbSeqno = (String) map.get("wdtbSeqno");
						
						vo.setWdtbSeqno(SwdtbSeqno);
						result = cstmrRDataDao.updWdtbSeqno(vo);
					}
				}
			}
		}catch(Exception e){
			result = 0;
			
			throw e;
			
		}

		return result;
	}
	/**
	 * 문서 목록 조회
	 */
	@Override
	public List<CstmrRDataVo> getCstmrRDataList(CstmrRDataVo vo) {
		return cstmrRDataDao.getCstmrRDataList(vo);
	}

	/**
	 * 문서 이력 조회
	 */
	@Override
	public List<CstmrRDataVo> getCstmrRDataHistList(CstmrRDataVo vo) {
		return cstmrRDataDao.getCstmrRDataHistList(vo);

	}
}
