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
import lims.wrk.dao.EntrpsFMDao;
import lims.wrk.service.EntrpsFMService;
import lims.wrk.service.EntrpsMService;
import lims.wrk.vo.EntrpsFMVo;

@Service
public  class EntrpsFMServiceImpl implements EntrpsFMService{
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
	EntrpsFMDao EntrpsFMDao;
	
	@Override
	public List<EntrpsFMVo> getEntrpsFMList(EntrpsFMVo EntrpsFMVo) {
		return EntrpsFMDao.getEntrpsFMList(EntrpsFMVo);
	}

	@Override
	public int userValidationF(EntrpsFMVo vo){
		return EntrpsFMDao.userValidationF(vo);
	}
	
	@Override
	public Integer insEntrpsFM(EntrpsFMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
//		String entrpsSeqno = vo.getEntrpsSeqno();
		int result = 0;

		String sLastChangerId = userMVo.getUserId();
		vo.setLastChangerId(sLastChangerId);
		if (vo.getCrud() != "" && vo.getCrud() != null) {
			if (vo.getCrud().equals("C")) {
				int userCheck = EntrpsFMDao.userValidationF(vo);
				if (userCheck != 0)
					return 0;
				result = EntrpsFMDao.insEntrpsFM(vo);
			}
			if (vo.getCrud().equals("U")) {
				result = EntrpsFMDao.updEntrpsFM(vo);
			}
		}
		List<EntrpsFMVo> chargerList = vo.getChargerList();
		for (int i = 0; i < chargerList.size(); i++) {
			chargerList.get(i).setLastChangerId(sLastChangerId);
			String gbnCrud = chargerList.get(i).getGbnCrud();
			
			if(chargerList.get(i).getGbnCrud() != "" && chargerList.get(i).getGbnCrud() != null ){
				if(gbnCrud.equals("C")){
					result = EntrpsFMDao.insEntrpscFM(chargerList.get(i));
				}
				if(gbnCrud.equals("U")){
					result = EntrpsFMDao.updEntrpscFM(chargerList.get(i));
				}
				if(gbnCrud.equals("D")){
					result = EntrpsFMDao.delEntrpscFM(chargerList.get(i));
				}
			}
		}
		return result;
	}
	

	@Override
	public Integer deleteEntrpsFM(EntrpsFMVo vo){
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		vo.setLastChangerId(userMVo.getUserId());
		return EntrpsFMDao.deleteEntrpsFM(vo);
	}
	
	@Override
	public Integer updEntrpsFM(EntrpsFMVo vo) {
		return EntrpsFMDao.updEntrpsFM(vo);
	}
		
	@Override
	public List<EntrpsFMVo> getEntrpscFMList(EntrpsFMVo EntrpsFMVo) {
		return EntrpsFMDao.getEntrpscFMList(EntrpsFMVo);
	}

	
}