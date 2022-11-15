package lims.rsc.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.rsc.dao.StdMttrMDao;
import lims.rsc.service.StdMttrMService;
import lims.rsc.vo.StdMttrMVo;

@Service
public class StdMttrMServiceImpl implements StdMttrMService {

	@Autowired
	private StdMttrMDao stdMttrMDao;
	
	@Override
	public StdMttrMVo saveStdMttrM(StdMttrMVo vo) {
		
		if(vo.getStdMttrSeqno().equals("")){
			//저장
			stdMttrMDao.saveStdMttrM(vo);
		}			
		else{
			//수정
			stdMttrMDao.updStdMttrM(vo);
		}
		
		//상위 표준 물질 그리드 저장, 추가나 삭제한게 있을때 저장함
		if(vo.getAddGridListData().size() > 0 || vo.getRemoveGridListData().size() > 0){
			
			stdMttrMDao.delUpperStdMttr(vo);
			
			for(int i=0; i<vo.getGridListData().size(); i++){
				StdMttrMVo gridStdMttrMVo = new StdMttrMVo();
				gridStdMttrMVo = vo.getGridListData().get(i);
				gridStdMttrMVo.setUpperStdMttrSeqno(vo.getGridListData().get(i).getStdMttrSeqno());
				gridStdMttrMVo.setStdMttrSeqno(vo.getStdMttrSeqno());
				gridStdMttrMVo.setOrdr(String.valueOf(i));				
				stdMttrMDao.insUpperStdMttr(gridStdMttrMVo);
			}
		}
		
		return vo;
	}

	@Override
	public List<StdMttrMVo> getStdMttrList(StdMttrMVo vo) { 
		return stdMttrMDao.getStdMttrList(vo);
	}

	/**
	 * 상위 표준 물질 조회
	 */
	@Override
	public List<StdMttrMVo> getUpperStdMttr(StdMttrMVo vo) {
		return stdMttrMDao.getUpperStdMttr(vo);
	}
}
