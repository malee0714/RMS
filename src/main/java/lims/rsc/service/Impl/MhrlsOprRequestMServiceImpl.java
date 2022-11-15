package lims.rsc.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.req.vo.RequestMVo;
import lims.rsc.dao.MhrlsOprRequestMDao;
import lims.rsc.service.MhrlsOprRequestMService;
import lims.rsc.vo.MhrlsOprRequestMVo;

@Service("MhrlsOprRequestMService")
public class MhrlsOprRequestMServiceImpl implements MhrlsOprRequestMService{

	@Autowired
    private MhrlsOprRequestMDao mhrlsOprRequestMDao;
	
	/**
	 * 기기 가동 목록 조회
	 */
	@Override
	public List<MhrlsOprRequestMVo> getMhrlsOprList(MhrlsOprRequestMVo vo) {
		// TODO Auto-generated method stub
		return mhrlsOprRequestMDao.getMhrlsOprList(vo);
	}

	/**
	 * 기기관리번호 바코드 조회
	 */
	@Override
	public List<RequestMVo> getImReqestList(RequestMVo vo) {
		// TODO Auto-generated method stub
		return mhrlsOprRequestMDao.getImReqestList(vo);
	}

	public List<MhrlsOprRequestMVo> getMhrlsManageNoList(MhrlsOprRequestMVo vo) {
		// TODO Auto-generated method stub
		return mhrlsOprRequestMDao.getMhrlsManageNoList(vo);
	}
	
	/**
	 * 저장
	 */
	@Override
	public int insMhrlsOprRequest(MhrlsOprRequestMVo vo) {
		
		int result = 0;
		
		try{
			
			//기기 가동 조회
			List<MhrlsOprRequestMVo> getOprVo = mhrlsOprRequestMDao.getMhrlsOpr(vo);
			
			if(getOprVo.size() == 0){
				//기기 가동정보 저장
				result = mhrlsOprRequestMDao.insMhrlsOpr(vo);
			}
			else{
				result = mhrlsOprRequestMDao.udpMhrlsOrp(vo);
			}
			
			MhrlsOprRequestMVo addListVo = new MhrlsOprRequestMVo();
			MhrlsOprRequestMVo removeListVo = new MhrlsOprRequestMVo();
			
			//추가된 행 데이터 저장
			for(int i=0; i<vo.getGridData1().size(); i++ ){				
				addListVo = vo.getGridData1().get(i);
				addListVo.setOprDte(vo.getOprDte());
				addListVo.setMhrlsSeqno(vo.getMhrlsSeqno());
				addListVo.setLastChangerId(vo.getLastChangerId());
				//추가된 기기 가동 의뢰 저장
				result += mhrlsOprRequestMDao.insMhrlsRequestOpr(addListVo);
			}
			
			//행삭제한 데이터 저장
			for(int i=0; i<vo.getGridData2().size(); i++ ){				
				removeListVo = vo.getGridData2().get(i);
				removeListVo.setOprDte(vo.getOprDte());
				removeListVo.setMhrlsSeqno(vo.getMhrlsSeqno());
				removeListVo.setLastChangerId(vo.getLastChangerId());
				//삭제된 기가 가동 의뢰 저장
				result += mhrlsOprRequestMDao.updMhrlsRequestOpr(removeListVo);
			}
			
			//기기가동 기기가동건수 저장
			MhrlsOprRequestMVo updListVo = new MhrlsOprRequestMVo();
			updListVo.setMhrlsSeqno(vo.getMhrlsSeqno());
			updListVo.setOprDte(vo.getOprDte());
			mhrlsOprRequestMDao.updMhrlsRequestOprCnt(updListVo);
			
		}catch(Exception e){
			result = 0;
			throw e;
		}		
		return result;
	}

	@Override
	public List<RequestMVo> getImReqestBacdList(RequestMVo vo) {
		// TODO Auto-generated method stub
		return mhrlsOprRequestMDao.getImReqestBacdList(vo);
	}
	
	/**
	 * 기기 가동 목록 삭제
	 */
	@Override
	public int delMhrlsOprRequest(MhrlsOprRequestMVo vo){
		return mhrlsOprRequestMDao.delMhrlsOprRequest(vo);
		
	}

	
}
