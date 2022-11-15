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
import lims.wrk.dao.AbsnceMDao;
import lims.wrk.service.AbsnceMService;
import lims.wrk.vo.AbsnceMVo;
import lims.wrk.vo.EntrpsFMVo;
import lims.wrk.vo.UnitFMVo;

@Service
public class AbsnceMServiceImpl implements AbsnceMService{
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
	private AbsnceMDao absnceMDao;


	@Override
	public int insAbsnceM(AbsnceMVo vo) {
		int count = 0;
		count = absnceMDao.insAbsnceM(vo);
		return count;
	}

	@Override
	public int updAbsnceM(AbsnceMVo vo) {
		int count = 0;
		count = absnceMDao.updAbsnceM(vo);
		return count;
	}

	@Override
	public int saveAbsnceM(AbsnceMVo vo) {
		int count = 0;
		count = absnceMDao.saveAbsnceM(vo);
		return count;
	}

	@Override
	public List<AbsnceMVo> getAbsnceList(AbsnceMVo vo) {
		return absnceMDao.getAbsnceList(vo);
	}

	@Override
	public int deleteAbsnM(AbsnceMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		vo.setLastChangerId(userMVo.getUserId());
		return absnceMDao.deleteAbsnM(vo);
	}

	@Override
	public int confirmAbsnceM(AbsnceMVo vo) {
		return absnceMDao.confirmAbsnceM(vo);
	}
	
	
	
}
