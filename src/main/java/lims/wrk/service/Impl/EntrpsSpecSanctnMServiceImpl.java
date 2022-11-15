package lims.wrk.service.Impl;


import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.wrk.dao.EntrpsSpecSanctnMDao;
import lims.wrk.service.EntrpsSpecSanctnMServcie;
import lims.wrk.vo.EntrpsSpecMVo;

@Service("EntrpsSpecSanctnMServcie")
public class EntrpsSpecSanctnMServiceImpl implements EntrpsSpecSanctnMServcie{

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
	private EntrpsSpecSanctnMDao entrpsSpecSanctnMDao;
	
	@Override
	public int getApprovalCnt(EntrpsSpecMVo vo){
		int result = entrpsSpecSanctnMDao.getApprovalCnt(vo);
		return result;
	}
	
	/**
	 * 결재 승인
	 */
	@Override
	public int insApprovalSanctn(List<EntrpsSpecMVo> vo) {		
		int result = 0;
		int approval = 0;
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		String num = "";
		String sanctnSj = "";
		String sanctnCn = "";
		
		List<EntrpsSpecMVo> lstChk = vo;
		
		for(int i=0; i<lstChk.size(); i++){
			lstChk.get(i).setLastChangerId(userMVo.getUserId());
			result += entrpsSpecSanctnMDao.approveSanctnInfo(lstChk.get(i));
			
			EntrpsSpecMVo sanctnInfoSanctUser = entrpsSpecSanctnMDao.getCmSanctnInfoSanctUser(lstChk.get(i));
			if(!sanctnInfoSanctUser.getTotSanctnerCo().equals(sanctnInfoSanctUser.getSanctnOrdr())){
				num=sanctnInfoSanctUser.getSanctnOrdr();
			}
			else{
				num=sanctnInfoSanctUser.getSanctnOrdr();
			}
			if(lstChk.get(i).getSanctnNextCnt() > 0) {
				result = entrpsSpecSanctnMDao.approveSanctnInfoNextAppn(lstChk.get(i));
				if("CM01000002".equals(lstChk.get(i).getSanctnProgrsSittnCode())){
					sanctnSj = "고객사 기준 규격("+lstChk.get(i).getStdrNm()+") 결재요청입니다.";
					sanctnCn ="<A href='https://lims.foosung.com/wrk/EntrpsSpecSanctnM.lims'>고객사 규격 결재 화면 이동</A>" ;
					lstChk.get(i).setSanctnSj(sanctnSj);
					lstChk.get(i).setSanctnCn(sanctnCn);
					result = entrpsSpecSanctnMDao.insWdtbSanctn(lstChk.get(i));
					result = entrpsSpecSanctnMDao.insWdtbTrgterSanctn(lstChk.get(i));
				}
			}
			else{
				// 결재진행상황 UPPER
				approval += entrpsSpecSanctnMDao.approveSanctn(lstChk.get(i));
				
			}
				if(lstChk.get(i).getTotSanctnerCo().equals(num)) {
				// 업데이트할때 기존버전은 라스트버전 n으로 전부 업데이트 하고 최신 버전만 Y로 변경
				int ver = Integer.valueOf(lstChk.get(i).getVer());
				if(ver > 1){
					EntrpsSpecMVo PreviousVo = new EntrpsSpecMVo();
					PreviousVo.setVer(String.valueOf(ver-1));
					PreviousVo.setPrductCtmmnySeqno(lstChk.get(i).getPrductCtmmnySeqno());
					PreviousVo.setBeginDte(lstChk.get(i).getBeginDte());
					entrpsSpecSanctnMDao.updatePrductCtmmnyPrevious(PreviousVo);
				}
				if(approval>0){
					
					EntrpsSpecMVo updVo = new EntrpsSpecMVo();
				
					updVo.setPrductCtmmnySeqno(lstChk.get(i).getPrductCtmmnySeqno());
					System.out.println(updVo.getPrductCtmmnySeqno());
					
					List<EntrpsSpecMVo> list = entrpsSpecSanctnMDao.limitMtril(updVo);
					
					for(int z=0; z<list.size(); z++){
						
						
						
						 result = entrpsSpecSanctnMDao.updMtrilSdspc(list.get(z));
						
					}
					
				}
			}
		}
		
		

			
			// 결재대기 -> 결재완료
			
			// 다음 결제대기예정자 -> 결재대기자로 변경
	
			//
					
			
		
		return result;
	}

	/**
	 * 결재 반려
	 */
	@Override
	public int insReturnSanctn(EntrpsSpecMVo vo) {
		int result = 0;
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(request);		// 현재 세션 사용자
		List<EntrpsSpecMVo> rtnList = vo.getRtnList();
		for(int i=0; i<rtnList.size(); i++){
			rtnList.get(i).setLastChangerId(userMVo.getUserId());
			rtnList.get(i).setReturnerId(userMVo.getUserId());
			rtnList.get(i).setRtnResn(vo.getRtnResn());
			rtnList.get(i).setSanctnProgrsSittnCode("CM01000004");
			rtnList.get(i).setOrdr(vo.getOrdr()+1);
	
			result += entrpsSpecSanctnMDao.updRtnSanctnUseAt(rtnList.get(i));
			result += entrpsSpecSanctnMDao.insRtnSanctn(rtnList.get(i));
			result += entrpsSpecSanctnMDao.updSanctnInfoProgrsCode(rtnList.get(i));
			result += entrpsSpecSanctnMDao.updSanctnProgrsCode(rtnList.get(i));
		}
		return result;
	}

}
