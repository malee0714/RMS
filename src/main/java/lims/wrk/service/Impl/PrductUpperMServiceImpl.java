package lims.wrk.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.com.service.CommonService;
import lims.sys.vo.CanisterNoMVo;
import lims.util.CommonFunc;
import lims.wrk.dao.PrductUpperMDao;
import lims.wrk.service.PrductUpperMService;
import lims.wrk.vo.PrductUpperMVo;

@Service
public class PrductUpperMServiceImpl implements PrductUpperMService {
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	private PrductUpperMDao prductUpperMDao;
	
	@Override
	public List<PrductUpperMVo> getPrductUpp(PrductUpperMVo vo){
		return prductUpperMDao.getPrductUpp(vo);
	}
	
	@Override
	public int savePrductUpp(List<PrductUpperMVo> list) {
		int count = 0;

		if (list.isEmpty())
			return count;
		
		for(int i=0; i<list.size(); i++) {
			// 중복 체크 호출
			prductUpperMDao.chkNo(list.get(i));

				if(list.get(i).getPrductUpperSeqno() == "" || list.get(i).getPrductUpperSeqno() == null) {
					count = prductUpperMDao.savePrductUpp(list.get(i));
				} else {
					count = prductUpperMDao.upPrductUpp(list.get(i));
				}
			
		}
		
		return count;
	}
	
	@Override
	public int chkNo(PrductUpperMVo vo){
		return prductUpperMDao.chkNo(vo);
	}
	
	// 삭제
	@Override
	public int delPrductUpp(List<PrductUpperMVo> list) {
		int count = 0;
		if (list.isEmpty())
			return count;

		for (int i = 0; i < list.size(); i++) {
			count = prductUpperMDao.delPrductUpp(list.get(i));
			
		}
		return count;
	}
	
	
}
