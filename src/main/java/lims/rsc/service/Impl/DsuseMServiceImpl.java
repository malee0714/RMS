package lims.rsc.service.Impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.rsc.dao.DsuseMDao;
import lims.rsc.service.DsuseMService;
import lims.rsc.vo.DsuseMVo;
import lims.rsc.vo.RgntMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;

@Service
public class DsuseMServiceImpl implements DsuseMService{
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
	private DsuseMDao dsuseMDao;
	
	public List<DsuseMVo> getDsuseBacode(DsuseMVo vo){
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		
		return dsuseMDao.getDsuseBacode(vo);
	}
	
	public int insDsuseBacode(List<DsuseMVo> vo){
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		int result = 0;
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		try {
			transFormat.parse("2016-09-15 00:00:00.000");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		for(int i=0; i <vo.size(); i++) {
				RgntMVo rgntMVo=new RgntMVo() ;
				result += dsuseMDao.insDsuseBacode(vo.get(i));

				rgntMVo.setPrductSeqno(vo.get(i).getPrductSeqno());
				rgntMVo.setWrhsdlvrSeCode(vo.get(i).getWrhsdlvrSeCode());
				rgntMVo.setWrhsdlvrQy(1);
				dsuseMDao.nowInvntryupdate(rgntMVo);
		}

		return result;
	}
	
}
