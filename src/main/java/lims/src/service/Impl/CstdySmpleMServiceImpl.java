package lims.src.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.rsc.vo.RgntMVo;
import lims.src.dao.CstdySmpleMDao;
import lims.src.service.CstdySmpleMService;
import lims.src.vo.CstdySmpleMVo;
import lims.src.vo.RequestCntMVo;
import lims.util.GetUserSession;

@Service("CstdySmpleMService")
public class CstdySmpleMServiceImpl implements CstdySmpleMService{

	@Autowired
	private CstdySmpleMDao cstdySmpleMDao;
	
	/**
	 * 담당 팀별 접수 건수 조회
	 * @return 
	 */
	@Override
	public List<CstdySmpleMVo> getCstdyList(CstdySmpleMVo vo) {
		GetUserSession sessionD = new GetUserSession();
		
		return cstdySmpleMDao.getCstdyList(vo);
	}
	
	@Override
	public int delRequestCntList(List<CstdySmpleMVo> vo){
		int count =0;
		for(int i = 0; i<vo.size();i++){
		 count += cstdySmpleMDao.delRequestCntList(vo.get(i));
		}
		return  count;
	}
}
