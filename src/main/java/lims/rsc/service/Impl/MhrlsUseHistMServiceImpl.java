package lims.rsc.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.com.service.CommonService;
import lims.rsc.dao.MhrlsUseHistMDao;
import lims.rsc.service.MhrlsUseHistMService;
import lims.rsc.vo.MhrlsUseHistMVo;

@Service("MhrlsUseHistMService")
public class MhrlsUseHistMServiceImpl implements MhrlsUseHistMService{

	@Autowired
    private MhrlsUseHistMDao mHrlsUseHistMDao;

	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Override
	public List<MhrlsUseHistMVo> getMhrlsUseHistM(MhrlsUseHistMVo vo) {
		return mHrlsUseHistMDao.getMhrlsUseHistM(vo);
	}

	@Override
	public int insMhrlsUseHistM(MhrlsUseHistMVo vo) {
		return mHrlsUseHistMDao.insMhrlsUseHistM(vo);
	}

	@Override
	public int updMhrlsUseHistDel(MhrlsUseHistMVo vo) {
		
//		if(vo.getType() != null && !vo.getType().equals("")) {
//			GetUserSession session = new GetUserSession();
//			String[] paramArr = new String[4];
//			HashMap<String, Object> paramMap = new HashMap<>();
//			paramArr[0] = vo.getSchChrgTeamSeCode();
//			paramArr[1] = vo.getShrMhrlsSeqno();
//			paramArr[2] = vo.getShrUseBeginDte();
//			paramArr[3] = vo.getShrUseEndDte();
//			paramMap.put("processNm", "기기 이력 전체 삭제");
//			paramMap.put("changerId", session.getUserId());	
//			paramMap.put("lastChangerId", session.getUserId());	
//			commonService.auditTrail("CM03000010",paramArr, paramMap);
//		}
		
		return mHrlsUseHistMDao.updMhrlsUseHistDel(vo);		
	}

}
