package lims.rsc.service.Impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.rsc.dao.MhrlsCmpdsUseMDao;
import lims.rsc.service.MhrlsCmpdsUseMService;
import lims.rsc.vo.MhrlsCmpdsUseMVo;

@Service("MhrlsCmpdsUseMService")
public class MhrlsCmpdsUseMServiceImpl implements MhrlsCmpdsUseMService{

	@Autowired
	private MhrlsCmpdsUseMDao mhrlsCmpdsUseMDao;
	
	/**
	 * 고비용 소모품 사용 조회
	 */
	@Override
	public List<MhrlsCmpdsUseMVo> getMhrlsCmpdsUseMList(MhrlsCmpdsUseMVo vo) {
		// TODO Auto-generated method stub
		return mhrlsCmpdsUseMDao.getMhrlsCmpdsUseMList(vo);
	}
	
	/**
	 * 바코드로 소모품 조회
	 */
	@Override
	public List<MhrlsCmpdsUseMVo> getBrcdMhrlsCmpdsUseM(MhrlsCmpdsUseMVo vo){
		return mhrlsCmpdsUseMDao.getBrcdMhrlsCmpdsUseM(vo);
	}

	/**
	 * 소모품 사용 시간 정보 저장
	 */
	@Override
	public MhrlsCmpdsUseMVo instMhrlsCmpdsUseM(MhrlsCmpdsUseMVo vo) {
		// TODO Auto-generated method stub
		try{			
			//소모품 사용시간 저장
			int result = mhrlsCmpdsUseMDao.instMhrlsCmpdsUseM(vo);
			
			vo.setNowUseAt("Y");
			//현재 사용 여부 수정
			result += mhrlsCmpdsUseMDao.updNowUseAt(vo);
			
			vo.setSuccesAt(result);
		}catch(Exception e){
			vo.setSuccesAt(0);
			throw e;
		}
		
		return vo;
	}
	
	/**
	 * 소모품 사용 시간 정보 수정
	 */
	@Override
	public MhrlsCmpdsUseMVo updtMhrlsCmpdsUseM(MhrlsCmpdsUseMVo vo) {
		try{
			//소모품 사용시간 수정
			int result = mhrlsCmpdsUseMDao.updtMhrlsCmpdsUseM(vo);
			
			if(result > 0 && vo.getUseEndDt() != null){
				vo.setNowUseAt("Y");
				result += mhrlsCmpdsUseMDao.updNowUseAt(vo);
			}
			
			vo.setSuccesAt(result);
		}catch(Exception e){
			vo.setSuccesAt(0);
			throw e;
		}
		
		return vo;
	}
	
	/**
	 * 소모품 사용 시간 정보 삭제
	 */
	@Override
	public MhrlsCmpdsUseMVo delMhrlsCmpdsUseM (MhrlsCmpdsUseMVo vo){		
		
		try{
			int result = mhrlsCmpdsUseMDao.delMhrlsCmpdsUseM(vo);
			vo.setSuccesAt(result);
		}catch(Exception e){
			vo.setSuccesAt(0);
			throw e;
		}
		
		return vo;
	}

}
