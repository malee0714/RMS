package lims.sys.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.com.service.CommonService;
import lims.sys.dao.CanisterNoMDao;
import lims.sys.service.CanisterNoMService;
import lims.sys.vo.CanisterNoMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;

@Service
public class CanisterNoMServiceImpl implements CanisterNoMService{
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Resource(name = "commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	private CanisterNoMDao canisterNoMDao;
	
	@Override
	public List<CanisterNoMVo> getCan(CanisterNoMVo vo){
		return canisterNoMDao.getCan(vo);
	}
	
	@Override
	public int saveCan(List<CanisterNoMVo> list) {
		int count = 0;

		if (list.isEmpty())
			return count;
		
		for(int i=0; i<list.size(); i++) {
			// 중복 체크 호출
			canisterNoMDao.chkNo(list.get(i));

				if(list.get(i).getCanNoSeqno() == "" || list.get(i).getCanNoSeqno() == null) {
					count = canisterNoMDao.saveCan(list.get(i));
				} else {
					count = canisterNoMDao.upCan(list.get(i));
				}
			
		}
		
		return count;
	}
	
	@Override
	public int chkNo(CanisterNoMVo vo){
		return canisterNoMDao.chkNo(vo);
	}
	
	// 삭제
	@Override
	public int delCan(List<CanisterNoMVo> list) {
		int count = 0;
		if (list.isEmpty())
			return count;

		for (int i = 0; i < list.size(); i++) {
			count = canisterNoMDao.delCan(list.get(i));
			
		}
		return count;
	}
	
}
