package lims.rsc.service.Impl;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.rsc.dao.RgntHistMDao;
import lims.rsc.dao.RgntMDao;
import lims.rsc.service.RgntHistMService;

import lims.rsc.vo.RgntHistMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;

@Service
public class RgntHistMServiceImpl implements RgntHistMService{
	
	
	@Autowired
	private RgntHistMDao rgntHistMDao;
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Override
	public List<RgntHistMVo> getPrduct(RgntHistMVo vo){
		return rgntHistMDao.getPrduct(vo);
	}
	@Override
	public List<RgntHistMVo> getHistlist(RgntHistMVo vo){

		return rgntHistMDao.getHistlist(vo);
	}
	
}
