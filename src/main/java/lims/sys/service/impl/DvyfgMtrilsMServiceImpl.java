package lims.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.sys.dao.DvyfgMtrilsMDao;
import lims.sys.service.DvyfgMtrilsMService;
import lims.sys.vo.DvyfgMtrilsMVo;

@Service("DvyfgMtrilsMService")
public class DvyfgMtrilsMServiceImpl implements DvyfgMtrilsMService{

	@Autowired
	private DvyfgMtrilsMDao dvyfgMtrilsMDao;
	
	/**
	 * 조회
	 */
	@Override
	public List<DvyfgMtrilsMVo> getDvyfgMtrils(DvyfgMtrilsMVo vo) {
		return dvyfgMtrilsMDao.getDvyfgMtrils(vo);
	}
	
	/**
	 * 저장
	 */
	@Override
	public int saveDvyfgMtrils(DvyfgMtrilsMVo vo) {
		
		int result = 0;
		
		//그리드 추가된내용 저장
		for(int i=0; i<vo.getInsMtrilsGrid().size(); i++){
			result = dvyfgMtrilsMDao.insDvyfgMtrils(vo.getInsMtrilsGrid().get(i));
		}
		
		//그리드 수정된 내용 저장
		for(int i=0; i<vo.getUpdMtrilsGrid().size(); i++){
			result = dvyfgMtrilsMDao.updDvyfgMtrils(vo.getUpdMtrilsGrid().get(i));
		}
		
		//그리드 삭제된 내용 저장
		for(int i=0; i<vo.getDelMtrilsGrid().size(); i++){
			result = dvyfgMtrilsMDao.delDvyfgMtrils(vo.getDelMtrilsGrid().get(i));
		}
		
		return result;
	}

	

	
}
