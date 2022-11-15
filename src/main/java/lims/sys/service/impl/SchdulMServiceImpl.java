package lims.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.sys.dao.SchdulMDao;
import lims.sys.service.SchdulMService;
import lims.sys.vo.SchdulMVo;

@Service
public class SchdulMServiceImpl implements SchdulMService{

	@Autowired
	public SchdulMDao schdulMDao; 
	   
	@Override
	public List<SchdulMVo> getSchdulMList(SchdulMVo vo) {
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>와우.");  
		return schdulMDao.getSchdulMList(vo);
	}

	@Override
	public List<SchdulMVo> getSchdulUserList(SchdulMVo vo) {
		return schdulMDao.getSchdulUserList(vo);
	}

	@Override
	public int saveSchdulInfo(SchdulMVo vo) {
		int result = 0;
		if(vo.getSchdulSeqno() == null || "".equals(vo.getSchdulSeqno())){
			result = schdulMDao.insSchdulInfo(vo);
		}else{ 
			result = schdulMDao.updSchdulInfo(vo); 
		}
		
		if(vo.getUserList().size() > 0){ 
			result = schdulMDao.delSchdulUser(vo); 
			for(int i = 0; i<vo.getUserList().size(); i++){
				vo.getUserList().get(i).setSchdulSeqno(vo.getSchdulSeqno());
				result = schdulMDao.insSchdulUser(vo.getUserList().get(i));
			}
		}
		return result;
	}
	
	@Override
	public int delSchdule(SchdulMVo vo) {
		int result= 0;
		result = schdulMDao.delSchdul(vo);
		result = schdulMDao.delSchdulUser(vo);
		return result;
	}
	
}
